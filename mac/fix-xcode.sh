#!/usr/bin/env bash

./xcode/custom-xcode.sh

cp -rf ./xcode/Klaws.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings

# Add snippets
cp -rf ./xcode/Snippets/ ~/Library/Developer/Xcode/UserData/CodeSnippets

# Add templates
sudo cp -r ./xcode/My\ SwiftUI\ View.xctemplate /Applications/Xcode.app/Contents/Developer/Library/Xcode/Templates/File\ Templates/MultiPlatform/User\ Interface

killall "Xcode"

