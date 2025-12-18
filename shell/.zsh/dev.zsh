# Development tools and language-specific aliases/functions
# Programming languages, package managers, and development utilities

# ===== Language Aliases =====
alias python=python3
alias py=python3

# ===== Package Managers =====
alias y=yarn
alias npm=pnpm

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