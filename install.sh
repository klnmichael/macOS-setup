#!/bin/bash

p() {
	printf "$1""\n"
}


p "Installing Homebrew, a few dependencies and applications. Follow the instructions..."


# sudo visudo: Default !tty_tickets
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)

xcode-select --intall

brew install wget

brew install git

brew install php
brew install composer
brew install mysql

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

brew install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp .zshrc ~/.zshrc

# Apps
apps=(
	enpass
	1password
	slack
	spotify
	google-chrome
	firefox
	iterm2
	visual-studio-code
	tableplus
	transmit
	figma
	blender
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew install --cask --appdir="/Applications" ${apps[@]}

brew cleanup
