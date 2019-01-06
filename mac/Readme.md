# Mac Setup

## Karabiner-Elements
- [list of key codes and modifiers · Issue \#925 · tekezo/Karabiner\-Elements ·
  GitHub](https://github.com/tekezo/Karabiner-Elements/issues/925)
- [karabiner\.json Reference Manual \- Karabiner \- Software for
  macOS](https://pqrs.org/osx/karabiner/json.html#from-event-definition-modifiers-list)
- [Manual \- Karabiner \- Software for macOS](https://pqrs.org/osx/karabiner/document.html#eventviewer)
- [Karabiner\-Elements complex\_modifications
  rules](https://pqrs.org/osx/karabiner/complex_modifications/#emulation-modes)

## And custom Mac shortcuts
- [How to customize Google Chrome keyboard shortcuts? \- Super
  User](https://superuser.com/questions/497526/how-to-customize-google-chrome-keyboard-shortcuts)
- [macos \- How to create custom Keyboard Shortcuts? \- Ask
  Different](https://apple.stackexchange.com/questions/174977/how-to-create-custom-keyboard-shortcuts/174979#174979)

## Xcode custom shortcuts
in `/Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Versions/A/Resources/IDETextKeyBindingSet.plist` (use
`sudo`), add
```xml
    <key>Custom</key>
    <dict>
        <key>Move Down 20</key>
        <string>moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, moveDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:, scrollLineDown:</string>
        <key>Move Up 20</key>
        <string>moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, moveUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:, scrollLineUp:</string>
        <key>Insert Newline Above</key>
        <string>moveUp:, moveToEndOfLine:, insertNewline:</string>
        <key>Join</key>
        <string>moveToEndOfLine:, moveWordRightAndModifySelection:, moveWordLeftAndModifySelection:, delete:</string>
    </dict>

```
for more, see
- [xcode4 \- Multiple\-line cursor movements in XCode 4 \- Stack Overflow](https://stackoverflow.com/questions/9224849/multiple-line-cursor-movements-in-xcode-4)
- [xcode4 \- Xcode duplicate line \- Stack Overflow](https://stackoverflow.com/questions/10266170/xcode-duplicate-line)
- [Open a new line below current line in Xcode \- Stack Overflow](https://stackoverflow.com/questions/3691166/open-a-new-line-below-current-line-in-xcode)
