# System utilities and navigation aliases/functions
# Core system operations, file navigation, and utilities

# ===== Enhanced System Commands =====
alias ls='eza -lah --git --icons'
alias eza='eza -lah --git'
alias cat='bat'
alias cls='clear'

# ===== Navigation Shortcuts =====
alias ..='cd ..'         # Go up one directory
alias ...='cd ../..'     # Go up two directories
alias ....='cd ../../..' # Go up three directories

# ===== Directory & File Operations =====
alias mkdir='mkdir -p'

# ===== Network Utilities =====
# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# ===== Tree Command Fallback =====
# Tree
if (( ! $+commands[tree] )); then
  alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
fi

# ===== Utility Functions =====

# Create directory and cd into it
function mkcd() { mkdir "$@" && cd "$@"; }

# File size utility with cross-platform compatibility
function fs() {
	if du -b /dev/null > /dev/null 2>&1; then
		local arg=-sbh;
	else
		local arg=-sh;
	fi
	if [[ -n "$@" ]]; then
		du $arg -- "$@";
	else
		du $arg .[^.]* ./*;
	fi;
}

# Enhanced tree with sensible defaults
# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
	tree -aC -I '.git|node_modules|.yarn' --dirsfirst "$@" | less -FRNX;
}