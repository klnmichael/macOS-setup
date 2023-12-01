#!/bin/bash

p() {
	printf "$1""\n"
}

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> ~/.zprofile
eval $(/opt/homebrew/bin/brew shellenv)

xcode-select --intall

brew install git

brew install wget

p "Install PHP & MySQL? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	brew install php
	brew install composer
	brew install mysql
fi

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash

brew install zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp .zshrc ~/.zshrc

# Apps
apps=(
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
