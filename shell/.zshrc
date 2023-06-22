# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


export ZSH="/Users/jan.urban/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(zsh-autosuggestions zsh-syntax-highlighting common-aliases colored-man-pages)
# plugins=(git zsh-autosuggestions common-aliases colored-man-pages)

source $ZSH/oh-my-zsh.sh


# THEFUCK alias
# https://github.com/nvbn/thefuck
eval "$(thefuck --alias)"

HIST_STAMPS="dd.mm.yyyy"

# PGP config
# because of https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

export EDITOR=vim

export LT_USERNAME="***REMOVED***"
export LT_ACCESS_KEY="***REMOVED***"
export BROWSER_STACK_USERNAME="***REMOVED***"
export BROWSER_STACK_ACCESS_KEY="***REMOVED***"
export E2E_API_PUBLIC_KEY="***REMOVED***"
export E2E_API_SECRET="***REMOVED***"
export E2E_EXPERIMENTS_API_PUBLIC_KEY="***REMOVED***"
export E2E_EXPERIMENTS_API_SECRET="***REMOVED***"
export OPENAI_API_KEY="sk-***REMOVED***"

# export PATH
# gradle and maven managed by sdkman
# export PATH=/opt/maven/apache-maven-3.6.3/bin:$PATH
# export PATH=$PATH:/opt/gradle/gradle-6.8.1/bin
export PATH=$PATH:/opt/homebrew/bin/brew
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# Source other files
[[ -f ~/.zsh/.aliases ]] && source ~/.zsh/.aliases
[[ -f ~/.zsh/.functions ]] && source ~/.zsh/.functions

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh

