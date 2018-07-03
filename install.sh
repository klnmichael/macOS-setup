#!/bin/bash

p() {
	printf "$1""\n"
}


p "Installing Homebrew, a few dependencies and applications. Follow the instructions..."

# Ask for the administrator password upfront
sudo -v
# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

sudo chown -R `whoami`:admin /usr/local/bin
sudo chown -R `whoami`:admin /usr/local/share

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew tap caskroom/versions
brew install caskroom/cask/brew-cask

brew install wget

brew install git

brew install node

brew tap homebrew/php
brew install php71
brew install composer

brew install bash

wget  -O ~/.git-completion.bash "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"
wget  -O ~/.git-prompt.sh "https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"

cp .bash_profile ~/.bash_profile
cp .bashrc ~/.bashrc
cp .inputrc ~/.inputrc

xcode-select --intall

# Apps
apps=(
	atom
	iterm2
	cyberduck
	enpass
	spotify
	slack
	google-chrome
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --appdir="/Applications" ${apps[@]}

brew cleanup
brew cask cleanup
