# Kylpo's mac config

`Add descriptions of files/folders here`

## Updating prefs

Want to find out what to write to? Make a `before` and `after` diff:

```sh
defaults read > ~/Desktop/before.txt
# <MAKE YOUR PREF CHANGE>
defaults read > ~/Desktop/after.txt
code --diff ~/Desktop/before.txt ~/Desktop/after.txt
```

Cleanup with `rm ~/Desktop/before.txt ~/Desktop/after.txt`

## Disable clicking Desktop behavior

![](https://photos5.appleinsider.com/gallery/56898-115712-001-Turn-off-setting-xl.jpg)

from https://appleinsider.com/inside/macos-sonoma/tips/tip-how-to-turn-off-macos-sonomas-click-to-reveal-desktop

## Xcode
### Hotkeys

Symlinking my hotkeys did not work (it just replaces the file when you make future keybind edits). So, you'll need to manually copy the file back and forth when making edits.

```bash
# Copy hotkeys to dotfiles
cp -rf ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings ./xcode/Klaws.idekeybindings

# Update xcode with dotfiles' hotkeys
cp -rf ./xcode/Klaws.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings
```

### Custom file templates

```sh
sudo cp -r ./xcode/My\ SwiftUI\ View.xctemplate /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/MultiPlatform/User\ Interface
```

See https://www.kodeco.com/26582967-xcode-project-and-file-templates/page/2?page=4#toc-anchor-016 for help

### Custom snippets
```bash
# Copy snppets to dotfiles
~/Library/Developer/Xcode/UserData/CodeSnippets
cp -rf ~/Library/Developer/Xcode/UserData/CodeSnippets ./xcode/Snippets/

# Update xcode with snippets
cp -rf ./xcode/Snippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets
```


## Other folks' mac config
- https://github.com/mathiasbynens/dotfiles/blob/master/.osx
- https://github.com/LukeChannings/dotfiles/blob/main/install.macos
