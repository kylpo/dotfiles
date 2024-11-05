#!/usr/bin/env bash

./xcode/custom-xcode.sh

cp -rf ./xcode/Klaws.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Klaws.idekeybindings

killall "Xcode"

