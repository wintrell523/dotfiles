# Application and service management aliases/functions
# System updates, application launchers, and service management

# ===== System Maintenance =====
# Update all Homebrew packages and Mac App Store apps
alias update='brew update && brew upgrade -y && brew upgrade --cask -y && mas upgrade'

# ===== Shell Configuration =====
alias zshrc='cursor ~/.zshrc'
alias szshrc='source ~/.zshrc'


# ===== Brewfile Management =====
# Ensure Brewfile is only created in ~/.dotfiles directory
function bbd() {
  echo "Dumping Brewfile";
  brew bundle dump --force --file=~/.dotfiles/Brewfile;
}