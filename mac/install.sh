#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos
# and just googling 'site:github.com dotfiles NSUserKeyEquivalents'

# See https://github.com/herrbischoff/awesome-macos-command-line for some examples

# Want to find out what to write to? Make a `before` and `after` diff:
#
# defaults read > ~/Desktop/before.txt
# <MAKE YOUR PREF CHANGE>
# defaults read > ~/Desktop/after.txt
# code --diff ~/Desktop/before.txt ~/Desktop/after.txt

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX
###############################################################################

# Dark theme
# ... Disable auto-theme if set
defaults delete NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically
# ... Set theme to Dark
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

# Disable menu bar transparency
defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

# Disable Resume system-wide
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Show volume in the menu bar
defaults write com.apple.systemuiserver "NSStatusItem Visible com.apple.menuextra.volume" -int 1

# Make crash reports show up as a notification, not as a modal
defaults write com.apple.CrashReporter UseUNC 1

###############################################################################
# Sound
###############################################################################
# System alert sound
# Defaults sounds located in `/System/Library/Sounds/`; test with `afplay`
# Basso         Blow          Bottle        Frog
# Funk          Glass         Hero          Morse
# Ping          Pop           Purr          Sosumi
# Submarine     Tink
defaults write com.apple.systemsound com.apple.sound.beep.sound -string "/System/Library/Sounds/Funk.aiff"

# Play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -bool true

# Disable the sound effects on boot
sudo nvram StartupMute=%01

# Enable the sound effects on boot
# sudo nvram SystemAudioVolume=" "
# sudo nvram StartupMute=%00


###############################################################################
# Inputs
###############################################################################

echo "Configuring inputs preferences"

# Disable “natural” (touchscreen-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# enable tap-to-click for this user and for the login screen
defaults -currentHost write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Disable automatic capitalization as it’s annoying when typing code
defaults write -g NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Reduce keyboard repeat delay
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# [Needed for vim] holding a key repeats the press (prevents the Hold -> menu feature)
defaults write -g ApplePressAndHoldEnabled -bool false

# Custom substitutions
defaults write -g NSUserDictionaryReplacementItems '(
)'

###############################################################################
# Desktop, Dashboard, Spaces, Dock
###############################################################################

echo "Configuring desktop view options"

# Show item info to the right of the icons on the desktop
# /usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist

# Set desktop icons size to 20x20
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 20" ~/Library/Preferences/com.apple.finder.plist

# Set grid spacing for desktop icons to 50
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 50" ~/Library/Preferences/com.apple.finder.plist

# Set text size to 10pt
# /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:textSize 10" ~/Library/Preferences/com.apple.finder.plist

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.Dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

###############################################################################
# Printers, Screenshots
###############################################################################

echo "Configuring printers preferences"

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# default screenshots to jpg instead of png
defaults write com.apple.screencapture type jpg

###############################################################################
# Finder
###############################################################################

echo "Configuring finder options"

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

# Use list view in all Finder windows by default
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
# After configuring preferred view style, clear all `.DS_Store` files
# to ensure settings are applied for every directory
# sudo find / -name ".DS_Store" --delete
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# New window target
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
defaults write com.apple.finder NewWindowTarget -string 'PfHm'

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Opening and closing speed of Quick Look windows
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0

###############################################################################
# Updates
###############################################################################

echo "Configuring updates preferences"

# Auto install app updates [fails to write]
#defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool TRUE

# Don’t install automatically macOS updates [fails to write]
#defaults write /Library/Preferences/com.apple.commerce AutoUpdateRestartRequired -bool FALSE

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# Safari
###############################################################################

echo "Configuring safari options"

# Set DuckDuckGo as the search engine
defaults write -g NSPreferredWebServices '{
  NSWebServicesProviderWebSearch = {
    NSDefaultDisplayName = DuckDuckGo;
    NSProviderIdentifier = "com.duckduckgo";
  };
}'

# Press Tab to highlight each item on a web page
defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true

# Tell Safari to open new window links in tabs
defaults write com.apple.Safari TargetedClicksCreateTabs -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Set Safari’s home page to `about:blank` for faster loading
# defaults write com.apple.Safari HomePage -string "about:blank"

# Start with all windows from last session
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true

# Setup new window and tab behvior
# 0: Homepage
# 1: Empty Page
# 2: Same Page
# 3: Bookmarks
# 4: Top Sites
defaults write com.apple.Safari NewTabBehavior -int 1
defaults write com.apple.Safari NewWindowBehavior -int 1

# Hide Safari’s sidebar in Top Sites
defaults write com.apple.Safari ShowSidebarInTopSites -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# show the status bar at the bottom (see URL on hover)
defaults write com.apple.Safari ShowStatusBar -bool true

# Website use of location services:
# 0: Deny without prompting
# 1: Prompt for each website once each day
# 2: Prompt for each website one time only
defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 2

# Ask websites not to track me
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Allow websites to check if Apple Pay is set up
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2ApplePayCapabilityDisclosureAllowed -bool true

###############################################################################
# Mail
###############################################################################

echo "Configuring mail options"

# Display emails in threaded mode, sorted by date (oldest at the top)
defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedDescending" -string "yes"
defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"

# Sort messages in thread from oldest to newest
defaults write com.apple.mail ConversationViewSortDescending -int 0

###############################################################################
# Music
###############################################################################

echo "Configuring Music options"

# Disable playback notifications
defaults write com.apple.Music userWantsPlaybackNotifications -int 0

###############################################################################
# TextEdit
###############################################################################

# Open to blank document (instead of file picker)
# NOTE: I have not yet verified that this works
defaults write com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

# Disable "Smart" features
defaults write com.apple.TextEdit SmartDashes -bool false
defaults write com.apple.TextEdit SmartQuotes -bool false
defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool false

# Add ".txt" extensions to plain text files
defaults write com.apple.TextEdit AddExtensionToNewPlainTextFiles -bool false

# Hide Ruler
defaults write com.apple.TextEdit ShowRuler -bool false

###############################################################################
###############################################################################
#
# External Apps
#
###############################################################################
###############################################################################

# Install brew (if not already installed)
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing brew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi;

# Check if the installation was ok
# brew doctor | grep 'Your system is ready to brew' &> /dev/null
# if [ $? != 0 ]; then
#   echo "An error ocurred and brew cannot be installed... exiting now"
#   exit
# fi

echo "Preparing to install apps... (may take a while)"

# Update homebrew and any installed formulae
brew update
brew upgrade

###############################################################################
# CLI Tools
###############################################################################

echo "Installing CLI Tools..."

brew install mas                  # interface for the Mac App Store
brew install the_silver_searcher  # alternative to ack maybe faster
brew install wget                 # similar to curl
brew install speedtest_cli        # test internet bandwidth using speedtest.net
brew install ssh-copy-id          # install your public key in a remote machine's authorized_keys
brew install rename               # rename files easy
brew install htop                 # better top replacement
brew install tree                 # display full directory hierarchy
brew install pstree               # display running processes as a tree
#brew install pv                   # show progress bar in pipelines
brew install iftop                # show network usage (similar to top)
# brew install unrar                # decompress rar files
#brew install dockutil             # manage dock items from the terminal
#brew install gpg                  # free implementation of the OpenPGP
#brew install thefuck		  # correct previous console command
#brew install sshrc		  # sources the .sshrc file after logging in remotely
brew install yarn
brew install z
brew install zsh
brew install trash
#brew install vim
brew install neovim
brew install bash-completion
brew install ffmpeg
brew install fzf
brew install git
brew install git-extras
brew install git-flow
brew install git-lfs
brew install ranger

###############################################################################
# Quicklook
###############################################################################

echo "Installing Quicklook plugins..."

# brew install qlmarkdown        # preview Markdown files
brew install qlimagesize       # image dimensions
# brew install qlstephen         # preview plain text files without a extension
# brew cask install qlcolorcode       # preview source code with syntax highlight
brew install quicklook-json    # preview JSON files
#brew cask install quicklook-csv     # preview CSV files
#brew cask install qlprettypatch     # preview diffs
#brew cask install betterzipql       # preview archives [does not exist?]

# Enable text selection in QuickLook views.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

###############################################################################
# Menubar
###############################################################################

echo "Installing Menubar Apps..."

brew install itsycal
brew install menumeters

###############################################################################
# Mac App Store Apps
###############################################################################

echo "Installing Mac Store Apps..."

# This command will not allow you to install an app for the first time: it must
# already be in the Purchased tab of the App Store.

mas install 557168941	  # Tweetbot
mas install 419330170	  # Moom
mas install 803453959   # Slack
mas install 1475897096  # Jira Cloud by Atlassian 
mas install 1191449274  # ToothFairy - easy bluetooth audio toggles
mas install 1333542190  # 1Password 7 - Password Manager
mas install 1461845568  # Gifox 2 - gif screen recorder
mas install 1487937127  # Craft - Docs and Notes Editor

mas install 497799835   # Xcode
# agree to xcode license
sudo xcodebuild -license accept

###############################################################################
# Misc Apps
###############################################################################

echo "Installing Misc Apps..."

brew install hammerspoon
brew install google-chrome

###############################################################################
# Development
###############################################################################

echo "Installing Development stuff..."

# Install python (macOS version is outdated) and python3
# Both are compatibles and this way you can test the code in both
# brew install python python3

# update pip and setuptools
# pip install --upgrade pip setuptools
# pip3 install --upgrade pip setuptools wheel

brew install iterm2  # Better terminal than Terminal
brew install dash    # Offline programming docs
brew install visual-studio-code

## QMK stuff
brew install homebrew/cask-drivers/qmk-toolbox
# Install QMK via Rosetta: https://stackoverflow.com/questions/67098972/how-do-you-install-qmk-with-the-new-mac-m1-arm-chip
#brew install qmk/qmk/qmk

###############################################################################
# Cleanup
###############################################################################

echo "Cleaning up..."

brew cleanup

###############################################################################
# Prefs
###############################################################################

echo "Importing App preferences..."

DIR="$( cd "$( dirname "$0" )" && pwd )"

for plist in "$DIR/prefs/"*; do
    # Remove file path
    fileName=${plist##*/}

    # Remove file extension
    domain=${fileName%.*}
    
    echo "defaults import $domain $plist"
    defaults import $domain $plist
  done

# MenuMeters
# ---------------------------
MenuMeters="com.yujitach.MenuMetersApp"

defaults write "$MenuMeters" CPUAverageLowerHalfProcs -int 0
defaults write "$MenuMeters" CPUAverageMultiProcs -int 1
defaults write "$MenuMeters" CPUDisplayMode -int 2
defaults write "$MenuMeters" CPUSortByUsage -int 0
defaults write "$MenuMeters" CPUSumAllProcsPercent -int 0
defaults write "$MenuMeters" CPUTemperature -int 0
defaults write "$MenuMeters" MemDisplayMode -int 4
defaults write "$MenuMeters" NetPreferInterface -string 'primary'
defaults write "$MenuMeters" "com.ragingmenace.MenuMeterDisk" -int 0
defaults write "$MenuMeters" "com.ragingmenace.MenuMeterNet" -int 0
defaults write "$MenuMeters" migratedFromRagingMenaceToYujitach -int 1

# ---------------------------
# XCode
# ---------------------------
# find more of these with commands from https://twitter.com/j4n0/status/1173370217239666688 (though it doesn't find all of them).
#   `strings /Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Versions/A/IDEKit | grep -E '^IDE[[:alpha:]]+$' | grep -E '(Animation|Disable|Enable|Disable|Show|Speed)' | sort`

# Show project build times in the activity viewer
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Add file Counterparts (see https://twitter.com/peterfriese/status/1364544309878534144)
defaults write com.apple.dt.Xcode IDEAdditionalCounterpartSuffixes -array-add "ViewModel" "View" "Screen"

# If you use the rename refactoring in Xcode a lot, you can save some time by skipping the code folding animation
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0

# Hide Xcode Cloud upsell alerts
defaults write com.apple.dt.Xcode XcodeCloudUpsellPromptEnabled -bool false

# ---------------------------
# iTerm2
# ---------------------------
# "Minimal" look
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

echo "Done installing apps!"

###############################################################################
# Hotkeys
###############################################################################

./hotkeys.sh
   
###############################################################################
# Cleanup
###############################################################################

# Need to restart for several changes to take effect. Trackpad settings in particular.
# from https://github.com/LukeChannings/dotfiles/blob/main/install.macos
echo "Doing a soft restart of affected apps. You should restart when everything is finished."

for app in "SystemUIServer" "cfprefsd" "Finder" "Dock" "ControlStrip" "Safari" "TextEdit" "ActivityMonitor"; do
    killall $app
done

exit 0