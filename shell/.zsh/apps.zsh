# Application and service management aliases/functions
# System updates, application launchers, and service management

# ===== System Maintenance =====
# Update all Homebrew packages and Mac App Store apps
alias update='brew update && brew upgrade && brew upgrade --cask && mas upgrade'

# ===== Shell Configuration =====
alias zshrc='code ~/.zshrc'
alias szshrc='source ~/.zshrc'

# ===== Application Launchers =====
# GPT/AI tools
alias chat='colima start && docker run -e OPENAI_API_KEY=$OPENAI_API_KEY -p 3000:3000 chatgpt-ui'

# ===== Brewfile Management =====
# Ensure Brewfile is only created in ~/.dotfiles directory
function bbd() {
  echo "Dumping Brewfile";
  brew bundle dump --force --describe --file=~/.dotfiles/Brewfile;
}