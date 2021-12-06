# Antigen
[[ -f ~/.zsh/.antigen.zsh ]] && source ~/.zsh/.antigen.zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source other files
[[ -f ~/.zsh/.aliases ]] && source ~/.zsh/.aliases
[[ -f ~/.zsh/.functions ]] && source ~/.zsh/.functions

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.zsh/{path,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# THEFUCK alias
# https://github.com/nvbn/thefuck
eval "$(thefuck --alias)"

# PGP config
# because of https://github.com/keybase/keybase-issues/issues/2798
export GPG_TTY=$(tty)

export EDITOR=vim

# export PATH
# gradle and maven managed by sdkman
# export PATH=/opt/maven/apache-maven-3.6.3/bin:$PATH
# export PATH=$PATH:/opt/gradle/gradle-6.8.1/bin
export PATH=$PATH:/Users/wintrell/scripts
export PATH=$PATH:/opt/homebrew/bin/brew
export PATH=$PATH:~/opt/terraform

# DigitalOcen token
export TF_VAR_do_token=e4f37a7a84103f506f9a8b217fdbe83441876e415e01b4c697f4f8ed057066d6
export TF_VAR_pvt_key="~/.ssh/terraform"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/.p10k.zsh ]] || source ~/.zsh/.p10k.zsh
export PATH="/opt/homebrew/opt/node@16/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/wintrell/.sdkman"
[[ -s "/Users/wintrell/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/wintrell/.sdkman/bin/sdkman-init.sh"