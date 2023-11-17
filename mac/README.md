# Kylpo's mac config

`Add descriptions of files/folders here`

## Xcode hotkeys

Symlinking my hotkeys did not work (it just replaces the file when you make future keybind edits). So, you'll need to manually copy the file back and forth when making edits.

```bash
# Copy hotkeys to dotfiles
cp -rf ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings ./xcode/Klaws.idekeybindings

# Update xcode with dotfiles' hotkeys
cp -rf ./xcode/Klaws.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings
```

## Other folks' mac config
- https://github.com/mathiasbynens/dotfiles/blob/master/.osx
- https://github.com/LukeChannings/dotfiles/blob/main/install.macos
