# Git aliases and functions
# All git-related commands consolidated in one place

# ===== Basic Git Operations =====
alias gf='git fetch -p'
alias gc='git commit'
function gcm() { git commit -m "$1"; }
function gcme() { git commit --allow-empty -m "$1"; }
alias gaa='git add .'
alias ga='git add'
alias gs='git status'

# ===== Push/Pull Operations =====
alias gpu='git push'
alias gpf='git push -f'
alias pul='git fetch -p && git pull --rebase'
alias gpsup='git push --set-upstream origin $(git_current_branch)'

# ===== Branch Operations =====
alias gsw='git switch'
function gnb() { git checkout -b "$1"; }
function gdel() { git branch -D "$@"; }
alias gbr='git branch --format="%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(contents:subject) %(color:green)(%(committerdate:relative)) [%(authorname)]" --sort=-committerdate'

# ===== Worktree Operations =====
alias gwl='git worktree list'
function gwa() { local dir="${1//\//-}"; git worktree add -b "$1" "../$dir" && cd "../$dir" && git push --set-upstream origin "$1"; }
function gwc() { local dir="${1//\//-}"; git worktree add "../$dir" "$1" && cd "../$dir"; }
function gwr() { git worktree remove "../${1//\//-}"; }

# ===== Stash Operations =====
alias gsh='git stash'
alias gsp='git stash pop'

# ===== History & Log Operations =====
alias glg='git log --graph --pretty=format:"%C(magenta)%h%Creset -%C(red)%d%Creset %s %C(dim green)(%cr) [%an]" --abbrev-commit -30'
alias gun='git reset HEAD~1 --mixed'
alias gca='git commit --amend'

# ===== Advanced Operations =====
alias gfr='git fetch -p && git rebase -i origin/master'
alias gfpr='git fetch && git pull && git rebase -i origin/master'
function gcp() { git cherry-pick -x "$1"; }

# ===== Git Functions =====

# Create new branch and set the upstream
function gnbp() { git checkout -b "$1"; git push --set-upstream origin "$1"; }

# Named stash operations - use gstp to push, gsa to apply
# Usage: gstp feature_name, then later: gsa feature_name
function gstp() {
    git stash push -m "zsh_stash_name_$1"
}
function gsa() {
    git stash apply $(git stash list | grep "zsh_stash_name_$1" | cut -d: -f1)
}