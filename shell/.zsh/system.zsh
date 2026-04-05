# System utilities and navigation aliases/functions
# Core system operations, file navigation, and utilities

# ===== Enhanced System Commands =====
alias ls='eza -lah --git --icons'
alias eza='eza -lah --git'
alias cat='bat'
alias cls='clear'
alias grep='grep --color=auto'
alias t='tail -f'
alias h='history'
alias hgrep='fc -El 0 | grep'
alias p='ps -f'

# ===== Safe File Operations =====
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# ===== Disk Usage =====
alias dud='du -d 1 -h'
alias ff='find . -type f -name'

# ===== Global Pipe Shortcuts =====
# Usage: cmd G pattern, cmd H, cmd T, etc.
alias -g G='| grep'
alias -g H='| head'
alias -g T='| tail'
alias -g L='| less'
alias -g LL='2>&1 | less'
alias -g NE='2>/dev/null'
alias -g NUL='>/dev/null 2>&1'

# ===== Colored Man Pages (via bat) =====
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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