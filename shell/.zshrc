# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load zplug
export ZPLUG_HOME="${HOME}/.zplug"
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

# PGP config
# because of https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

export EDITOR=vim

# export PATH
# gradle and maven managed by sdkman
# export PATH=/opt/maven/apache-maven-3.6.3/bin:$PATH
# export PATH=$PATH:/opt/gradle/gradle-6.8.1/bin
export PATH="/opt/homebrew/bin/brew:$PATH"
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
export NODE_OPTIONS="--max-old-space-size=8192"

# Source other files
[[ -f ~/.zsh/.aliases ]] && source ~/.zsh/.aliases
[[ -f ~/.zsh/.functions ]] && source ~/.zsh/.functions
[[ -f ~/.zsh/.test-aliases ]] && source ~/.zsh/.test-aliases

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

# Load environment variables from .env file
if [ -f "$HOME/.env" ]; then
  set -a                   # export every variable that gets defined
  source "$HOME/.env"
  set +a
fi