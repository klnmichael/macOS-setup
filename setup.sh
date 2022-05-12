#!/bin/bash

p() {
	printf "$1""\n"
}


p "/*-------------------------------------------*/"
p "|                                             |"
p "|        DO NOT RUN THIS SCRIPT BLINDLY       |"
p "|         YOU'LL PROBABLY REGRET IT...        |"
p "|                                             |"
p "|              READ IT THOROUGHLY             |"
p "|         AND EDIT TO SUIT YOUR NEEDS         |"
p "|                                             |"
p "/*-------------------------------------------*/"
p
p
p "Continue? (y/n)"
read r
if ! [[ $r =~ ^([yY])$ ]]; then
	exit;
fi


# sudo visudo: Default !tty_tickets
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


p
p "Changing UI/UX settings... Please wait!"


### General

# Appearance
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Accent color
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# Highlight Color
defaults write NSGlobalDomain AppleHighlightColor -string "0.780400 0.815700 0.858800"

# Show scroll bars (`WhenScrolling`, `Automatic` and `Always`)
defaults write NSGlobalDomain AppleShowScrollBars -string "Automatic"

# Click in the scrollbar to
defaults write NSGlobalDomain AppleScrollerPagingBehavior -bool true


### Dock

# Size
defaults write com.apple.dock tilesize -int 32

# Prevent the Dock from changing size
defaults write com.apple.dock size-immutable -bool true

# Magnification
defaults write com.apple.dock magnification -bool false

# Minimize windows using
defaults write com.apple.dock mineffect -string "suck"

# Minimize windows into their application icon
defaults write com.apple.dock minimize-to-application -bool true

# Animate opening applications
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

p
p "Automatically hide and show the Dock? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	defaults write com.apple.dock autohide -bool true
elif [[ $r =~ ^([nN])$ ]]; then
	defaults write com.apple.dock autohide -bool false
fi

# Show indicators for open applications
defaults write com.apple.dock show-process-indicators -bool true

# Show recent applications in Dock
defaults write com.apple.dock show-recents -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


### Finder

# Set Desktop as the default location for new Finder windows
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder > Preferences > Show wraning before removing from iCloud Drive
defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions in Finder by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Set sidebar icon size to small
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1

# Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

# Use column view in all Finder windows
defaults write com.apple.finder FXPreferredViewStyle Clmv

# Avoid creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Allowing text selection in Quick Look/Preview in Finder
defaults write com.apple.finder QLEnableTextSelection -bool true

# Show the ~/Library folder
sudo chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes


### Trackpad, mouse, keyboard

# Enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate (default 2)
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat (default 15)
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false


## System

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Show file icon in title bar without delay
defaults write -g NSToolbarTitleViewRolloverDelay -float 0

# Allow slow motion effects
defaults write com.apple.dock slow-motion-allowed -bool true


### Safari

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enabling the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Adding a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


p
p "Note that some of these changes require a restart to take effect!"