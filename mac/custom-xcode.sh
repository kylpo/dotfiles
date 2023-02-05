#!/bin/bash
set -e

#
# Documentation on available commands: https://developer.apple.com/documentation/appkit/nsstandardkeybindingresponding
#

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

echo "Done"