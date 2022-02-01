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

# ---------------------------
# iTerm2
# ---------------------------
# "Minimal" look
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

echo "Done installing apps!"

###############################################################################
###############################################################################
#
# Hotkeys
#
###############################################################################
###############################################################################

# System Keys (symbolichotkeys)
#
# Use `Key Codes` app from Many Tricks + this SO thread: https://stackoverflow.com/questions/21878482/.
#
# Using `defaults`:
#   Search for domains with `defaults domains | tr ',' '\n' | grep google`, for example.
#   https://www.shell-tips.com/mac/defaults/
#   https://pawelgrzybek.com/change-macos-user-preferences-via-command-line/
#
# Also a big thanks to https://github.com/tiiiecherle/osx_install_config/blob/master/11_system_and_app_preferences/11c_macos_preferences_11.sh
#
# Action IDs: https://web.archive.org/web/20141112224103/http://hintsforums.macworld.com/showthread.php?t=114785
#
# parameter 1: Unicode of the character (or 65535 - hex 0xFFFF - for non-ASCII characters).
# parameter 2: Key Code for the character.
# parameter 3: MODS
#   0=>"No modifier"
#   131072=>"Shift"
#   262144=>"Control"
#   524288=>"Option"
#   1048576=>"Command"
#   393216=>"Shift + Control"
#   655360=>"Shift + Option"
#   1179648=>"Shift + Command"
#   786432=>"Control + Option"
#   1310720=>"Control + Command"
#   1572864=>"Option + Command"
#   917504=>"Shift + Control + Option"
#   1441792=>"Shift + Control + Command"
#   1703936=>"Shift + Option + Command"
#   1835008=>"Control + Option + Command"
#   1966080=>"Shift + Control + Option + Command"
#
# Print yours with:
#   /usr/libexec/PlistBuddy -c "Print :AppleSymbolicHotKeys" ~/Library/Preferences/com.apple.symbolichotkeys.plist

CONTROL="262144"
SHIFT_CONTROL="393216"

UNICODE_A="97"
UNICODE_B="98"
UNICODE_C="99"
UNICODE_D="100"
UNICODE_E="101"
UNICODE_F="102"
UNICODE_G="103"
UNICODE_H="104"
UNICODE_I="105"
UNICODE_J="106"
UNICODE_K="107"
UNICODE_L="108"
UNICODE_M="109"
UNICODE_N="110"
UNICODE_O="111"
UNICODE_P="112"
UNICODE_Q="113"
UNICODE_R="114"
UNICODE_S="115"
UNICODE_T="116"
UNICODE_U="117"
UNICODE_V="118"
UNICODE_W="119"
UNICODE_X="120"
UNICODE_Y="121"
UNICODE_Z="122"
KEY_A="0"
KEY_B="11"
KEY_C="8"
KEY_D="2"
KEY_E="14"
KEY_F="3"
KEY_G="5"
KEY_H="4"
KEY_I="34"
KEY_J="38"
KEY_K="40"
KEY_L="37"
KEY_M="46"
KEY_N="45"
KEY_O="31"
KEY_P="35"
KEY_Q="12"
KEY_R="15"
KEY_S="1"
KEY_T="17"
KEY_U="32"
KEY_V="9"
KEY_W="13"
KEY_X="7"
KEY_Y="16"
KEY_Z="6"

# Mission Control
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_W}</integer>
        <integer>${KEY_W}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 34 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_W}</integer>
        <integer>${KEY_W}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Show Desktop
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 36 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_L}</integer>
        <integer>${KEY_L}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 37 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_L}</integer>
        <integer>${KEY_L}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
" 

# Show Spotlight
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 64 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_A}</integer>
        <integer>${KEY_A}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Show Spotlight (Files)
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 65 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_A}</integer>
        <integer>${KEY_A}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Toggle Notifications
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 163 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_D}</integer>
        <integer>${KEY_D}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Move Space Left
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 79 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_M}</integer>
        <integer>${KEY_M}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 80 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_M}</integer>
        <integer>${KEY_M}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Move Space Right
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 81 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_Y}</integer>
        <integer>${KEY_Y}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 82 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_Y}</integer>
        <integer>${KEY_Y}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Screenshot Area
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 30 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_B}</integer>
        <integer>${KEY_B}</integer>
        <integer>${CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Screenshot Area to Clipboard
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 31 "
  <dict>
    <key>enabled</key>
    <true/>
    <key>value</key>
    <dict>
      <key>type</key>
      <string>standard</string>
      <key>parameters</key>
      <array>
        <integer>${UNICODE_B}</integer>
        <integer>${KEY_B}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Move focus to next window in application - DISABLED
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 27 "
  <dict>
    <key>enabled</key>
    <false/>
  </dict>
"

# Application windows - DISABLED
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 33 "
  <dict>
    <key>enabled</key>
    <false/>
  </dict>
"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 35 "
  <dict>
    <key>enabled</key>
    <false/>
  </dict>
"
# Turn Dock Hiding On/Off - DISABLED
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 52 "
  <dict>
    <key>enabled</key>
    <false/>
  </dict>
"

# A menu item of `Format->Indentation->Increase` in System Preferences is stored as `\033Format\033Indentation\033Incease`
#
# \033 = ASCII Escape character

CMD="@"
CTRL="^"
OPT="~"
SHIFT="$"
UP='\U2191'
DOWN='\U2193'
LEFT='\U2190'
RIGHT='\U2192'
SPACE='\U0020'
DISABLED='\U0000'

Chrome="com.google.Chrome"   # bundleIdentifier /Applications/Google\ Chrome.app
Mail="com.apple.mail"        # bundleIdentifier /System/Applications/Mail.app
Safari="com.apple.Safari"    # bundleIdentifier /Applications/Safari.app

bundleIds=(NSGlobalDomain "$Chrome" "$Mail" "$Safari")

# Reset keys
for bundleId in "${bundleIds[@]}"; do
  defaults write "$bundleId" NSUserKeyEquivalents -dict
done

# Global
# ------
# Change tabs
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Next Tab"       "${CTRL}n"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Next Tab"            "${CTRL}n"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Next Tab"     "${CTRL}n"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Previous Tab"   "${CTRL}o"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Previous Tab" "${CTRL}o"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Previous Tab"        "${CTRL}o"
# New tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab"             "${CTRL}c"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab at End"      "${CTRL}${SHIFT}n"
# Close tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Tab"           "${CTRL}${SHIFT}o"
# Reopen tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Last Closed Tab" "${CTRL}${SHIFT}t"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Closed Tab"   "${CTRL}${SHIFT}t"
# defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Undo Close Tab" '^$t'
# Tab expose
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Tab Overview"   "${CTRL}${SHIFT}m"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Exposé all Tabs"     "${CTRL}${SHIFT}m"
# Move tab
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Move Tab to New Window"   "${CTRL}${SHIFT}h"
# New window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Window"          "${CTRL}r"
# Close window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Window"        "${CTRL}${SHIFT}r"
# Lock Screen
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Lock Screen"         "${CTRL}${SHIFT}l"
# Select
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select All"          "${CMD}${SHIFT}e"
# Open
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Open File..."             "${DISABLED}"
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Open Location..."         "${CMD}o"
defaults write "$Chrome" NSUserKeyEquivalents -dict-add "Open File..."             "${DISABLED}"
defaults write "$Chrome" NSUserKeyEquivalents -dict-add "Open Location..."         "${CMD}o"
# History
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Back"                "${CMD}m"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Forward"             "${CMD}y"

# DISABLES
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Minimize"            "${DISABLED}"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Print"               "${DISABLED}"

# QUIT
# ----
update_quit_keybind() {
  for absoluteFile in "$1"*.app; do
    bundleId=$(mdls -name kMDItemCFBundleIdentifier -raw "$absoluteFile")
    file="${absoluteFile##*/}"
    name="${file%%.*}"

    # Overrides (where Quit command does not match its app name)
    if [[ $name == "1Password 7" ]]
    then
      name="1Password"
    elif [[ $name == "iTerm" ]]
    then
      name="iTerm2"
    elif [[ $name == "VoiceMemos" ]]
    then
      name="Voice Memos"
    elif [[ $name == "Xcode-beta" ]]
    then
      name="Xcode"
    fi
    # Did you miss one? Delete it with below's command, then add the correction here
    # `defaults delete com.apple.dt.Xcode NSUserKeyEquivalents`

    echo "[Updating Quit keybind] $bundleId ___ $name"
    defaults write "$bundleId" NSUserKeyEquivalents -dict-add "Quit $name" "${CTRL}${SHIFT}j"
  done
}

update_quit_keybind "/Applications/"
update_quit_keybind "/System/Applications/"
update_quit_keybind "/System/Applications/Utilities/"

# Chrome
# ----
# "Bookmark" interferes with "Back"
defaults write "$Chrome" NSUserKeyEquivalents -dict-add "Bookmark This Tab..."     "${DISABLED}"

# Mail 
# ----
# add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write "$Mail" NSUserKeyEquivalents -dict-add "\033Message\033Send"        "${CMD}↩"
# add ⌘ + D to archive messages
defaults write "$Mail" NSUserKeyEquivalents -dict-add "\033Message\033Archive"     "${CMD}d"
defaults write "$Mail" NSUserKeyEquivalents -dict-add "\033Message\033Send Again"  "${DISABLED}"

# com.apple.mail.plist also lives in ~/Library/Containers. See https://discussions.apple.com/thread/7539914.
# TODO: add try/catch here. Echo that you need to give program Full Disk Access: https://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/
# sudo /usr/libexec/PlistBuddy                                               \
#     -c "Delete :NSUserKeyEquivalents"                           \
#     -c "Add    :NSUserKeyEquivalents:Archive       string '@d'" \
#     -c "Add    :NSUserKeyEquivalents:Send       string '@↩'" \
#     ~/Library/Containers/com.apple.mail/Data/Library/Preferences/com.apple.mail.plist

# Finder
# ------
# defaults write com.apple.finder NSUserKeyEquivalents -dict-add "\033File\033Quick Look" "@\U0020"

# Xcode
# ------
# For more on custom commands:
# - https://stackoverflow.com/questions/10266170/xcode-duplicate-line
# - https://stackoverflow.com/questions/9224849/multiple-line-cursor-movements-in-xcode-4
# - http://www.hcs.harvard.edu/~jrus/Site/selectors.html for the available text actions. Also http://www.hcs.harvard.edu/~jrus/Site/cocoa-text.html.

# XCODE_PATH='/Applications/Xcode-beta.app/Contents/Frameworks/IDEKit.framework/Versions/A/Resources/IDETextKeyBindingSet.plist'
XCODE_PATH='/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Versions/A/Resources/IDETextKeyBindingSet.plist'

if [ -f "$XCODE_PATH" ]; then
  echo "Adding Xcode commands/hotkeys:"

  # Produced XML:
  #
  # <key>Custom</key>
  # <dict>
  #     <key>Move Down 20</key>
  #     <string>moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:</string>
  #     <key>Move Up 20</key>
  #     <string>moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:</string>
  #     <key>Insert Newline Above</key>
  #     <string>moveUp:, moveToEndOfLine:, insertNewline:</string>
  #     <key>Insert Newline Below</key>
  #     <string>moveToEndOfLine:, insertNewline:</string>
  #     <key>Join</key>
  #     <string>moveToEndOfLine:, moveWordRightAndModifySelection:, moveWordLeftAndModifySelection:, delete:</string>
  #     <key>Duplicate Current Line</key>
  #     <string>moveToBeginningOfLine:, deleteToEndOfLine:, yank:, insertNewline:, moveToBeginningOfLine:, yank:</string>
  #     <key>Delete Line</key>
  #     <string>selectLine:, deleteBackward:</string>
  # </dict>
  
  sudo /usr/libexec/PlistBuddy                                               \
    -c "Delete :Custom"\
    -c "Add    :Custom dict"\
    -c "Add    :Custom:Move\ Down\ 20 string moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:"\
    -c "Add    :Custom:Move\ Selection\ Down\ 20 string moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, moveDownAndModifySelection:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:"\
    -c "Add    :Custom:Move\ Up\ 20 string moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:"\
    -c "Add    :Custom:Move\ Selection\ Up\ 20 string moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, moveUpAndModifySelection:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:"\
    -c "Add    :Custom:Insert\ Newline\ Above string moveUp:, moveToEndOfLine:, insertNewline:"\
    -c "Add    :Custom:Insert\ Newline\ Below string moveToEndOfLine:, insertNewline:"\
    -c "Add    :Custom:Join string moveToEndOfLine:, moveWordRightAndModifySelection:, moveWordLeftAndModifySelection:, delete:"\
    -c "Add    :Custom:Duplicate\ Line string moveToBeginningOfLine:, deleteToEndOfLine:, yank:, insertNewline:, moveToBeginningOfLine:, yank:"\
    -c "Add    :Custom:Duplicate\ Lines string selectLine:, delete:, yank:, yank:"\
    -c "Add    :Custom:Duplicate\ Selection string delete:, yank:, yank:"\
    -c "Add    :Custom:Delete\ Line string selectLine:, deleteBackward:"\
    -c "Print :Custom"\
    $XCODE_PATH
else
  echo "Xcode path not found! Skipping..."
fi
   
###############################################################################
# Cleanup
###############################################################################

echo "Cleaning up..."

# This command is needed to show your keybinds in Preferences > Keyboard > Shortcuts > App Shortcuts
defaults write com.apple.universalaccess com.apple.custommenu.apps -array $(echo -e "${bundleIds[@]}")

# Report hotkeys to user
for bundleId in "${bundleIds[@]}"; do
  echo "$bundleId keys:"
  defaults read "$bundleId" NSUserKeyEquivalents
done

# Need to restart for several changes to take effect. Trackpad settings in particular.
# from https://github.com/LukeChannings/dotfiles/blob/main/install.macos
echo "Doing a soft restart of affected apps. You should restart when everything is finished."

for app in "SystemUIServer" "cfprefsd" "Finder" "Dock" "ControlStrip" "Safari" "TextEdit" "ActivityMonitor"; do
    killall $app
done

exit 0