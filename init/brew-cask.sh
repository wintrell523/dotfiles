#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

#brew install --cask alfred
#brew install --cask flux
brew install --cask iterm2
#brew install --cask tor-browser
#brew install --cask brave-browser
#brew install --cask onionshare
#ln -s /Applications/OnionShare.app/Contents/MacOS/onionshare ~/.bin/
#brew install --cask vlc
#brew install --cask spectacle
#brew install --cask disk-inventory-x
brew install --cask licecap
brew install --cask appcleaner
brew install --cask handbrake
brew install --cask the-unarchiver
brew install --cask java
brew install --cask mark-text
brew install --cask keybase
brew install --cask vimr
#brew install --cask dozer
brew install --cask lens
brew install --cask maccy
brew install --cask visual-studio-code

# quicklook plugins
brew install --cask qlmarkdown
brew install --cask quicklook-json
brew install --cask qlprettypatch
brew install --cask quicklook-csv
brew install --cask webpquicklook
brew install --cask qlcolorcode
brew install --cask suspicious-package

# fonts
brew tap homebrew/cask-fonts
brew install --cask font-inconsolata
brew install --cask font-fira-code
brew install --cask font-hack

#brew install --cask webtorrent
brew install --cask transmission