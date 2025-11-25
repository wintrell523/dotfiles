#!/usr/bin/env zsh

# Dynamic Test Runner for Frontend Monorepo
# Usage: ./test-runner.sh [options]
# Example: ./test-runner.sh -e dev -m build -a dms -t "@team:platform+@regression"

set -e

# Default values
ENVIRONMENT="dev"
MODE="build"
APP="dms"
TAGS=""
WATCH=false
BASE_URL=""
HELP=false

# Available options
ENVIRONMENTS=("dev" "stage")
MODES=("build" "url")
APPS=("dms" "price-report" "vin-decoder" "digital-certificate" "iam")
TEAMS=("@team:sugma" "@team:warehouse" "@team:workshop" "@team:platform" "@team:sentinels" "@team:soyuz" "@team:caraudit")
TEST_TYPES=("@regression" "@mergeRequest")
MODULES=("@module:settings" "@module:vehicle" "@module:sourcing" "@module:accounting" "@module:customer" "@module:employee" "@module:datagrid-e2e" "@module:warehouse:article" "@module:warehouse:delivery-note" "@module:warehouse:service-order")

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Help function
show_help() {
    echo -e "${BLUE}Dynamic Test Runner for Frontend Monorepo${NC}"
    echo ""
    echo "Usage: $0 [options]"
    echo ""
    echo "Options:"
    echo -e "  ${GREEN}-e, --env${NC}        Environment (${YELLOW}$(IFS=', '; echo "${ENVIRONMENTS[*]}")${NC}) [default: dev]"
    echo -e "  ${GREEN}-m, --mode${NC}       Mode (${YELLOW}$(IFS=', '; echo "${MODES[*]}")${NC}) [default: build]"
    echo -e "  ${GREEN}-a, --app${NC}        Application (${YELLOW}$(IFS=', '; echo "${APPS[*]}")${NC}) [default: dms]"
    echo -e "  ${GREEN}-t, --tags${NC}       Test tags (e.g., '@team:platform+@regression')"
    echo -e "  ${GREEN}-u, --url${NC}        Base URL (required when mode=url)"
    echo -e "  ${GREEN}-w, --watch${NC}      Watch mode (interactive)"
    echo -e "  ${GREEN}-h, --help${NC}       Show this help message"
    echo ""
    echo "Examples:"
    echo -e "  ${YELLOW}# Team regression tests${NC}"
    echo "  $0 -e dev -m build -a dms -t '@team:platform+@regression'"
    echo ""
    echo -e "  ${YELLOW}# Test against custom URL${NC}"
    echo "  $0 -e dev -m url -a dms -u 'https://dms.dev.omnetic.dev' -t '@team:sugma'"
    echo ""
    echo -e "  ${YELLOW}# Interactive mode${NC}"
    echo "  $0 -e dev -m build -a dms -t '@team:warehouse' -w"
    echo ""
    echo -e "  ${YELLOW}# Stage environment tests${NC}"
    echo "  $0 -e stage -m build -a dms -t '@team:sentinels+@regression'"
    echo ""
    echo -e "  ${YELLOW}# Module-specific merge request tests${NC}"
    echo "  $0 -e dev -m build -a dms -t '@module:settings+@mergeRequest'"
    echo ""
    echo "Available Tags:"
    echo -e "  ${BLUE}Teams:${NC} $(IFS=', '; echo "${TEAMS[*]}")"
    echo -e "  ${BLUE}Test Types:${NC} $(IFS=', '; echo "${TEST_TYPES[*]}")"
    echo -e "  ${BLUE}Modules:${NC} $(IFS=', '; echo "${MODULES[*]}")"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -e|--env)
            ENVIRONMENT="$2"
            shift 2
            ;;
        -m|--mode)
            MODE="$2"
            shift 2
            ;;
        -a|--app)
            APP="$2"
            shift 2
            ;;
        -t|--tags)
            TAGS="$2"
            shift 2
            ;;
        -u|--url)
            BASE_URL="$2"
            shift 2
            ;;
        -w|--watch)
            WATCH=true
            shift
            ;;
        -h|--help)
            HELP=true
            shift
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            show_help
            exit 1
            ;;
    esac
done

# Show help if requested
if [ "$HELP" = true ]; then
    show_help
    exit 0
fi

# Validation functions
validate_environment() {
    local env="$1"
    for valid_env in "${ENVIRONMENTS[@]}"; do
        if [[ "$env" == "$valid_env" ]]; then
            return 0
        fi
    done
    echo -e "${RED}Error: Invalid environment '$env'. Valid options: $(IFS=', '; echo "${ENVIRONMENTS[*]}")${NC}"
    exit 1
}

validate_mode() {
    local mode="$1"
    for valid_mode in "${MODES[@]}"; do
        if [[ "$mode" == "$valid_mode" ]]; then
            return 0
        fi
    done
    echo -e "${RED}Error: Invalid mode '$mode'. Valid options: $(IFS=', '; echo "${MODES[*]}")${NC}"
    exit 1
}

validate_app() {
    local app="$1"
    for valid_app in "${APPS[@]}"; do
        if [[ "$app" == "$valid_app" ]]; then
            return 0
        fi
    done
    echo -e "${RED}Error: Invalid app '$app'. Valid options: $(IFS=', '; echo "${APPS[*]}")${NC}"
    exit 1
}

# Validate inputs
validate_environment "$ENVIRONMENT"
validate_mode "$MODE"
validate_app "$APP"

# Check if URL is required for url mode
if [[ "$MODE" == "url" && -z "$BASE_URL" ]]; then
    echo -e "${RED}Error: Base URL is required when mode is 'url'. Use -u or --url option.${NC}"
    exit 1
fi

# Build the command
build_command() {
    local target="e2e:${ENVIRONMENT}:${MODE}"
    local args="--app=${APP}"
    
    if [[ -n "$TAGS" ]]; then
        args="${args} --grepTags='${TAGS}'"
    fi
    
    if [[ "$MODE" == "url" && -n "$BASE_URL" ]]; then
        args="${args} --baseUrl='${BASE_URL}'"
    fi
    
    if [[ "$WATCH" == true ]]; then
        target="${target}:watch"
    fi
    
    echo "npx nx run ${target} ${args}"
}

# Display configuration
echo -e "${BLUE}=== Test Runner Configuration ===${NC}"
echo -e "Environment: ${YELLOW}${ENVIRONMENT}${NC}"
echo -e "Mode:        ${YELLOW}${MODE}${NC}"
echo -e "App:         ${YELLOW}${APP}${NC}"
echo -e "Tags:        ${YELLOW}${TAGS:-'(none)'}${NC}"
if [[ "$MODE" == "url" ]]; then
    echo -e "Base URL:    ${YELLOW}${BASE_URL}${NC}"
fi
echo -e "Watch Mode:  ${YELLOW}${WATCH}${NC}"
echo ""

# Build and display the command
COMMAND=$(build_command)
echo -e "${GREEN}Executing:${NC} ${COMMAND}"
echo ""

# Execute the command
eval "$COMMAND"