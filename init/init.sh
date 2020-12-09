
#!/bin/bash

pip install --user powerline-status
pip install segno # for QR codes using qr function

if [ $(uname) == "Darwin" ];then
		~/init/macos.sh
		~/init/brew.sh
		~/init/brew-cask.sh
fi