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


# Zsh history configuration
HISTFILE="${HOME}/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY       # Write timestamps to history
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt HIST_VERIFY            # Show expanded history before executing
setopt SHARE_HISTORY          # Share history across sessions

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
  set -a
  source "$HOME/.env" || true
  set +a
fi

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

