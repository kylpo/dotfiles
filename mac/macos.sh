#!/usr/bin/env bash

# ~/.macos — https://mths.be/macos
# and just googling 'site:github.com dotfiles NSUserKeyEquivalents'

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
sudo nvram SystemAudioVolume=" "

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

# Disable system-wide spell check
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

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
chflags nohidden /Volumes

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
# TextEdit
###############################################################################

# Open to blank document (instead of file picker)
# NOTE: I have not yet verified that this works
defaults write http://com.apple.TextEdit NSShowAppCentricOpenPanelInsteadOfUntitledFile -bool false

# Disable "Smart" features
defaults write com.apple.TextEdit SmartDashes -bool false
defaults write com.apple.TextEdit SmartQuotes -bool false
defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool false

# Add ".txt" extensions to plain text files
defaults write com.apple.TextEdit AddExtensionToNewPlainTextFiles -bool false

# Hide Ruler
defaults write com.apple.TextEdit ShowRuler -bool false

###############################################################################
# Xcode
###############################################################################

# Show xcode build times
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# ---------------------------
# Keybinds
# ---------------------------

# System Keys (symbolichotkeys)
#
# Use `Key Codes` app from Many Tricks + this SO thread: https://stackoverflow.com/questions/21878482/.
# Search for domains with `defaults domains | grep google`, for example.
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
# Print yours with: `/usr/libexec/PlistBuddy -c "Print :AppleSymbolicHotKeys" ~/Library/Preferences/com.apple.symbolichotkeys.plist`

# Mission Control: Ctrl + d
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
        <integer>100</integer>
        <integer>2</integer>
        <integer>262144</integer>
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
        <integer>100</integer>
        <integer>2</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Show Desktop: Ctrl + l
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
        <integer>108</integer>
        <integer>37</integer>
        <integer>262144</integer>
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
        <integer>108</integer>
        <integer>37</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
" 

# Show Spotlight: Ctrl + a
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
        <integer>97</integer>
        <integer>0</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Show Spotlight (Files): Ctrl + Shift + a
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
        <integer>97</integer>
        <integer>0</integer>
        <integer>393216</integer>
      </array>
    </dict>
  </dict>
"

# Toggle Notifications: Ctrl + h
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
        <integer>104</integer>
        <integer>4</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Move Space Left: Ctrl + m
# Note: No idea what 80 does (Ctrl + Shift + m)
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
        <integer>109</integer>
        <integer>46</integer>
        <integer>262144</integer>
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
        <integer>109</integer>
        <integer>46</integer>
        <integer>393216</integer>
      </array>
    </dict>
  </dict>
"

# Move Space Right: Ctrl + w
# Note: No idea what 82 does (Ctrl + Shift + w)
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
        <integer>119</integer>
        <integer>13</integer>
        <integer>262144</integer>
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
        <integer>119</integer>
        <integer>13</integer>
        <integer>393216</integer>
      </array>
    </dict>
  </dict>
"

# Screenshot Area: Ctrl + w
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
        <integer>98</integer>
        <integer>11</integer>
        <integer>262144</integer>
      </array>
    </dict>
  </dict>
"

# Screenshot Area to Clipboard: Ctrl + Shift + w
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
        <integer>98</integer>
        <integer>11</integer>
        <integer>393216</integer>
      </array>
    </dict>
  </dict>
"

# modifier key legend:
#  @ = command
#  ^ = control
#  ~ = option
#  $ = shift
#
# \033 = ASCII Escape character
# \U0020 = Spacebar
# \U0000 = disabled
#
# A menu item of `Format->Indentation->Increase` in System Preferences is stored as `\033Format\033Indentation\033Incease`

# TODO: use backup function from https://github.com/netj/dotfiles/blob/master/Mac/NSUserKeyEquivalents.sh ?

# Global
# ------
# Change tabs
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Next Tab"       "^\U0020"
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Next Tab"            "^\U0020"
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Next Tab"     "^\U0020"
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Previous Tab"   "^o"
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select Previous Tab" "^o"
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Previous Tab"        "^o"
# New tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab"      '^t'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab at End"      '^$\U0020'
# Close tab
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Tab" '^$o'
# Reopen tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Last Closed Tab" '^$t'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Closed Tab" '^$t'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Undo Close Tab" '^$t'
# Tab expose
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Tab Overview" '^$d'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Exposé all Tabs" '^$d'
# Move tab
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Move Tab to New Window" '^$n'
# New window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Window"      '^n'
# Close window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Window" '^$r'
# Lock Screen
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Lock Screen" '^$l'
# Cut/Copy/Paste
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Cut" '@v'
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Copy" '@h'
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Paste" '@p'
# defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Paste and Match Style" '@$p'
# Undo/Redo
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Undo" '@u'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Redo" '@$u'
# Select
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select All" '@$a'
# Open
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Open File..." "\U0000"
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Open Location..." '@o'
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Open File..." "\U0000"
defaults write com.google.Chrome NSUserKeyEquivalents -dict-add "Open Location..." '@o'
# History
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Back" '@m'
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Forward" '@h'

# DISABLES
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Minimize" "\U0000"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Print" "\U0000"

# Mail 
# ----
# add the keyboard shortcut ⌘ + Enter to send an email in Mail.app
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "\033Message\033Send" "@↩"
# add ⌘ + D to archive messages
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "\033Message\033Archive" "@d"
defaults write com.apple.mail NSUserKeyEquivalents -dict-add "\033Message\033Send Again" "\U0000"

# Finder
# ------
# defaults write com.apple.finder NSUserKeyEquivalents -dict-add "\033File\033Quick Look" "@\U0020"


# com.apple.mail.plist also lives in ~/Library/Containers. See https://discussions.apple.com/thread/7539914.
# TODO: add try/catch here. Echo that you need to give program Full Disk Access: https://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/
# sudo /usr/libexec/PlistBuddy                                               \
#     -c "Delete :NSUserKeyEquivalents"                           \
#     -c "Add    :NSUserKeyEquivalents:Archive       string '@d'" \
#     -c "Add    :NSUserKeyEquivalents:Send       string '@↩'" \
#     ~/Library/Containers/com.apple.mail/Data/Library/Preferences/com.apple.mail.plist
   
echo "Global keys:"
defaults read NSGlobalDomain NSUserKeyEquivalents

echo "Safari keys:"
defaults read com.apple.Safari NSUserKeyEquivalents

echo "Mail keys:"
defaults read com.apple.mail NSUserKeyEquivalents

echo "Finder keys:"
defaults read com.apple.finder NSUserKeyEquivalents

echo "OS X defaults written. Note that some of these changes require a logout/restart to take effect."