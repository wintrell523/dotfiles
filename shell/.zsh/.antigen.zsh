source /opt/homebrew/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen theme romkatv/powerlevel10k

antigen bundle <<EOBUNDLES
	# Terminal stuff
	git
	zsh-users/zsh-syntax-highlighting
	zsh-users/zsh-history-substring-search
	zsh-users/zsh-autosuggestions
	zsh-users/common-aliases
	zsh-users/colored-man-pages
	z
EOBUNDLES

antigen apply