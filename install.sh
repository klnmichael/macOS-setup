#!/bin/bash

p() {
    printf "$1""\n"
}
check() {
  type "$1" &> /dev/null;
}


p "Installing Xcode dev tools..."
if [ "$(check pkgutil --pkg-info=com.apple.pkg.CLTools_Executables)" ]; then
    xcode-select --install
    sleep 1
    osascript -e 'tell application "System Events"' -e 'tell process "Install Command Line Developer Tools"' -e 'keystroke return' -e 'click button "Agree" of window "License Agreement"' -e 'end tell' -e 'end tell'
fi


# p
# p "Installing XQuartz..."
# curl https://dl.bintray.com/xquartz/downloads/XQuartz-2.7.9.dmg -o /tmp/XQuartz.dmg
# open /tmp/XQuartz.dmg
# sleep 10s
# sudo installer -package /Volumes/XQuartz-2.7.9/XQuartz.pkg -target /
# hdiutil detach /Volumes/XQuartz-2.7.9


p
p "Installing ZSH..."
curl -L http://install.ohmyz.sh | sh
# zsh fix
if [[ -f /etc/zshenv ]]; then
    sudo mv /etc/{zshenv,zshrc}
fi


p
p "Installing Homebrew..."
if ! command -v brew &>/dev/null; then
    p "Installing Homebrew. Follow the instructions..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  if ! grep -qs "recommended by brew doctor" ~/.zshrc; then
      p "Put Homebrew location earlier in PATH..."
      printf '\n# recommended by brew doctor\n' >> ~/.zshrc
      printf 'export PATH="/usr/local/bin:$PATH"\n' >> ~/.zshrc
      export PATH="/usr/local/bin:$PATH"
  fi
else
    p "Homebrew is already installed!"
fi
# Homebrew OSX libraries
p "Updating brew..."
brew update

p "Installing GNU core utilities..."
brew install coreutils

p "Installing GNU find, locate, updatedb and xargs..."
brew install findutils

p "Installing the most recent verions of some OSX tools..."
brew tap homebrew/dupes
brew install homebrew/dupes/grep

p "Installing cask to install apps..."
brew tap caskroom/versions
brew install caskroom/cask/brew-cask

p "Installing Composer..."
brew install composer

p "Installing Node.js..."
brew install node

printf 'export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"' >> ~/.zshrc
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"


p "Installing Gulp..."
npm install --global gulp

p "Installing Grunt..."
npm install -g grunt-cli

p "Installing Bower..."
npm install -g bower


# Apps
apps=(
  adobe-creative-cloud
  atom
  cyberduck
  dropbox
  google-chrome
  iterm2
  skype
  slack
  vlc
  macpass
  spotify
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
brew cask install --appdir="/Applications" ${apps[@]}

# when done with cask
brew update
brew upgrade brew-cask
brew cleanup
brew cask cleanup

p "Continue to setup atom.io? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
    sh $(dirname $0)/atom.io/setup.sh
fi
