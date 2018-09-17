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

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Increasing sound quality for Bluetooth headphones/headsets
defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Set a blazingly fast keyboard repeat rate (default 2)
# macOS Sierra requires value to be 1 or greater
defaults write NSGlobalDomain KeyRepeat -int 1

# Set a shorter Delay until key repeat (default 15)
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user


###############################################################################
# Finder                                                                      #
###############################################################################

p
p "Show hidden files in Finder by default? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	defaults write com.apple.Finder AppleShowAllFiles -bool true
elif [[ $r =~ ^([nN])$ ]]; then
	defaults write com.apple.Finder AppleShowAllFiles -bool false
fi

p
p "Show dotfiles in Finder by default? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	defaults write com.apple.finder AppleShowAllFiles -bool true
elif [[ $r =~ ^([nN])$ ]]; then
	defaults write com.apple.finder AppleShowAllFiles -bool false
fi

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

# Show scrollbars when scrolling
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
# Possible values: `WhenScrolling`, `Automatic` and `Always`

# Avoid creation of .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

#Allowing text selection in Quick Look/Preview in Finder
defaults write com.apple.finder QLEnableTextSelection -bool true

# Enabling snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Show the ~/Library folder
sudo chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes


###############################################################################
# Dock and Dashboard                                                          #
###############################################################################

p
p "Disable Dashboard? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	defaults write com.apple.dashboard mcx-disabled -bool true
	# Don’t show Dashboard as a Space
	defaults write com.apple.dock dashboard-in-overlay -bool true
elif [[ $r =~ ^([nN])$ ]]; then
	defaults write com.apple.dashboard mcx-disabled -bool false
	# Show Dashboard as a Space
	defaults write com.apple.dock dashboard-in-overlay -bool false
fi

p
p "Automatically hide and show the Dock? (y/n)"
read r
if [[ $r =~ ^([yY])$ ]]; then
	defaults write com.apple.dock autohide -bool true
elif [[ $r =~ ^([nN])$ ]]; then
	defaults write com.apple.dock autohide -bool false
fi

# Set the icon size of Dock items to 30 pixels
defaults write com.apple.dock tilesize -int 30

# Enable 'suck' animation (genie, scale)
defaults write com.apple.dock mineffect -string "suck"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


###############################################################################
# Screen                                                                      #
###############################################################################

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"


###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true


###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enabling the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true

# Adding a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true


###############################################################################
# Terminal                                                                    #
###############################################################################

# Enabling UTF-8 ONLY in Terminal.app and setting the Pro theme by default
defaults write com.apple.terminal StringEncodings -array 4
defaults write com.apple.Terminal "Default Window Settings" -string "Pro"
defaults write com.apple.Terminal "Startup Window Settings" -string "Pro"

# Don’t display the annoying prompt when quitting iTerm
defaults write com.googlecode.iterm2 PromptOnQuit -bool false


###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0


###############################################################################
# General                                                                     #
###############################################################################

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

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

# Enable 'Graphite' appearance for buttons, menus and windows
defaults write NSGlobalDomain AppleAquaColorVariant -int 6

# Use Graphite Highlight Color
defaults write NSGlobalDomain AppleHighlightColor -string "0.780400 0.815700 0.858800"

# Enable dark theme
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Enable transparency menu bar
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool true

# Allow slow motion effects on OS High Sierra
defaults write com.apple.dock slow-motion-allowed -bool YES


p
p "Note that some of these changes require a restart to take effect!"
