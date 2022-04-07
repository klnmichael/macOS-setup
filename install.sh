#!/bin/bash

p() {
	printf "$1""\n"
}


p "Installing Homebrew, a few dependencies and applications. Follow the instructions..."


# sudo visudo: Default !tty_tickets
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sudo chown -R $(whoami) $(brew --prefix)/*

brew tap caskroom/versions
brew install caskroom/cask/brew-cask

brew install wget

brew install git

brew install node

brew tap homebrew/php
brew install php72
brew install composer
brew install mysql

brew install zsh

cp .zshrc ~/.zshrc

xcode-select --intall

# Apps
apps=(
	enpass
	1password
	slack
	google-chrome
	firefox
	iterm2
	tableplus
	transmit
	figma
	adobe-creative-cloud
	blender
	spotify
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup
brew cask cleanup
