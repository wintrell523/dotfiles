# Load exports first (needed for tools and PATH)
[[ -f ~/.zsh/.exports ]] && source ~/.zsh/.exports

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Load antidote plugin manager
source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh

# Generate static plugin file from .zsh_plugins.txt when it is outdated
zsh_plugins=~/.zsh/.zsh_plugins
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <${zsh_plugins}.txt >|${zsh_plugins}.zsh
fi
source ${zsh_plugins}.zsh


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


# pnpm
export PNPM_HOME="/Users/wintrell/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
