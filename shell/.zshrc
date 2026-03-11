# Load exports first (needed for zplug and other tools)
[[ -f ~/.zsh/.exports ]] && source ~/.zsh/.exports

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
fi
source "${ZPLUG_HOME}/init.zsh"

# zplug plugins
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "ohmyzsh/ohmyzsh", as:plugin, use:plugins/common-aliases
zplug "ohmyzsh/ohmyzsh", as:plugin, use:plugins/colored-man-pages
zplug "djui/alias-tips"
zplug "hlissner/zsh-autopair", defer:2
zplug "romkatv/powerlevel10k", as:theme

# Install plugins if missing
if ! zplug check --verbose; then
  printf "\nInstalling missing zplug plugins...\n"
  zplug install
fi

# Load plugins
zplug load

# export ZSH="/Users/jan.urban/.oh-my-zsh"
# ZSH_THEME="powerlevel10k/powerlevel10k"
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(zsh-autosuggestions zsh-syntax-highlighting common-aliases colored-man-pages)
# plugins=(git zsh-autosuggestions common-aliases colored-man-pages)

# source $ZSH/oh-my-zsh.sh

HIST_STAMPS="dd.mm.yyyy"

# Source domain-organized configuration files
[[ -f ~/.zsh/.env ]] && source ~/.zsh/.env
[[ -f ~/.zsh/git.zsh ]] && source ~/.zsh/git.zsh
[[ -f ~/.zsh/system.zsh ]] && source ~/.zsh/system.zsh
[[ -f ~/.zsh/dev.zsh ]] && source ~/.zsh/dev.zsh
[[ -f ~/.zsh/apps.zsh ]] && source ~/.zsh/apps.zsh
[[ -f ~/.zsh/security.zsh ]] && source ~/.zsh/security.zsh
[[ -f ~/.zsh/personal.zsh ]] && source ~/.zsh/personal.zsh
[[ -f ~/.zsh/.test-aliases ]] && source ~/.zsh/.test-aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# Load environment variables from .env file
if [ -f "$HOME/.env" ]; then
  set -a                   # export every variable that gets defined
  source "$HOME/.env"
  set +a
fi

# bun completions
[ -s "/Users/wintrell/.bun/_bun" ] && source "/Users/wintrell/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"


# To customize prompt, run `p10k configure` or edit ~/.dotfiles/shell/.zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/shell/.zsh/.p10k.zsh ]] || source ~/.dotfiles/shell/.zsh/.p10k.zsh
