
#!/bin/bash

pip install --user powerline-status
pip install segno # for QR codes using qr function

if [ $(uname) == "Darwin" ];then
		~/dotfiles/init/macos.sh
		~/dotfiles/init/brew.sh
		~/dotfiles/init/brew-cask.sh
fi