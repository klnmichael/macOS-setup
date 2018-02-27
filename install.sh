#!/bin/bash

p() {
	printf "$1""\n"
}


p "Installing Homebrew. Follow the instructions..."

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew install caskroom/cask/brew-cask

brew install node

brew tap homebrew/php
brew install php71
brew install composer

sudo chown -R `whoami`:admin /user/local/bin
sudo chown -R `whoami`:admin /user/local/share
brew install bash

# Apps
apps=(
	adobe-creative-cloud
	atom
	cyberduck
	dropbox
	iterm2
	slack
	spotify
	google-drive-file-stream
	google-chrome
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup
brew cask cleanup
