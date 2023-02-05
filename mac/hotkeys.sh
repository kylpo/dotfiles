#!/usr/bin/env bash

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
        <integer>${UNICODE_M}</integer>
        <integer>${KEY_M}</integer>
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
        <integer>${UNICODE_M}</integer>
        <integer>${KEY_M}</integer>
        <integer>${SHIFT_CONTROL}</integer>
      </array>
    </dict>
  </dict>
"

# Show Desktop
# defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 36 "
#   <dict>
#     <key>enabled</key>
#     <true/>
#     <key>value</key>
#     <dict>
#       <key>type</key>
#       <string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>${UNICODE_D}</integer>
#         <integer>${KEY_D}</integer>
#         <integer>${CONTROL}</integer>
#       </array>
#     </dict>
#   </dict>
# "
# defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 37 "
#   <dict>
#     <key>enabled</key>
#     <true/>
#     <key>value</key>
#     <dict>
#       <key>type</key>
#       <string>standard</string>
#       <key>parameters</key>
#       <array>
#         <integer>${UNICODE_D}</integer>
#         <integer>${KEY_D}</integer>
#         <integer>${SHIFT_CONTROL}</integer>
#       </array>
#     </dict>
#   </dict>
# " 

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
        <integer>${UNICODE_Y}</integer>
        <integer>${KEY_Y}</integer>
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
        <integer>${UNICODE_S}</integer>
        <integer>${KEY_S}</integer>
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
        <integer>${UNICODE_S}</integer>
        <integer>${KEY_S}</integer>
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
        <integer>${UNICODE_W}</integer>
        <integer>${KEY_W}</integer>
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
        <integer>${UNICODE_W}</integer>
        <integer>${KEY_W}</integer>
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
        <integer>${UNICODE_Q}</integer>
        <integer>${KEY_Q}</integer>
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
        <integer>${UNICODE_Q}</integer>
        <integer>${KEY_Q}</integer>
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
DELETE='\U007F'
BACKSPACE='\U0008'
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
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab"             "${CTRL}l"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Tab at End"      "${CTRL}${SHIFT}n"
# Close tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Tab"           "${CTRL}${SHIFT}o"
# Reopen tab
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Last Closed Tab" "${CTRL}${SHIFT}l"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Reopen Closed Tab"   "${CTRL}${SHIFT}l"
# defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Undo Close Tab" '^$t'
# Tab expose
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Show Tab Overview"   "${CTRL}${SHIFT}m"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Exposé all Tabs"     "${CTRL}${SHIFT}m"
# Move tab
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Move Tab to New Window"   "${CTRL}${SHIFT}r"
# New window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "New Window"          "${CTRL}g"
# Close window
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Close Window"        "${CTRL}${SHIFT}g"
# Lock Screen
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Lock Screen"         "${CTRL}${SHIFT}d"
# Select
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Select All"          "${CMD}${SHIFT}e"
# Open
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Open File..."             "${DISABLED}"
defaults write "$Safari" NSUserKeyEquivalents -dict-add "Open Location..."         "${CMD}o"
defaults write "$Chrome" NSUserKeyEquivalents -dict-add "Open File..."             "${DISABLED}"
defaults write "$Chrome" NSUserKeyEquivalents -dict-add "Open Location..."         "${CMD}o"
# History
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Back"                "${CMD}s"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Forward"             "${CMD}w"

# DISABLES
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Minimize"            "${DISABLED}"
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Print"               "${DISABLED}"

# QUIT
# ----
defaults write NSGlobalDomain NSUserKeyEquivalents -dict-add "Quit"               "${CTRL}${SHIFT}j"

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
defaults write com.apple.finder NSUserKeyEquivalents -dict-add 'Move to Trash' "${DELETE}"

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

# This command is needed to show your keybinds in Preferences > Keyboard > Shortcuts > App Shortcuts
defaults write com.apple.universalaccess com.apple.custommenu.apps -array $(echo -e "${bundleIds[@]}")

# Report hotkeys to user
for bundleId in "${bundleIds[@]}"; do
  echo "$bundleId keys:"
  defaults read "$bundleId" NSUserKeyEquivalents
done

exit 0