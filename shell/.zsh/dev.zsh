# Development tools and language-specific aliases/functions
# Programming languages, package managers, and development utilities

# ===== Language Aliases =====
alias python=python3
alias py=python3

# ===== AI =====
alias cl=claude

# ===== Playwright =====
function dms-pw-gen() { nx run dms-playwright-e2e:aigen -- "$@"; }
function as-pw-gen() { nx run admin-service-playwright-e2e:aigen -- "$@"; }
alias dms-pw-ui='nx run dms-playwright-e2e:e2e-ui'
alias as-pw-ui='nx run admin-service-playwright-e2e:e2e-ui'
function dms-pw-fix() { local file="$1"; shift; nx run dms-playwright-e2e:aigen -- --file "$file" "$@"; }
function as-pw-fix() { local file="$1"; shift; nx run admin-service-playwright-e2e:aigen -- --file "$file" "$@"; }

# ===== Package Managers =====
alias y=yarn

# ===== Container & Orchestration =====
alias k=kubectl

# ===== Development Functions =====

# Secure npm install alias with package age checking
pnpm() {
	if [[ "$1" == "install" || "$1" == "i" ]]; then
		if [[ -f "tools/check-package-ages/check-package-ages.js" ]]; then
			node tools/check-package-ages/check-package-ages.js "$@"
		else
			command pnpm "$@"
		fi
	else
		command pnpm "$@"
	fi
}
