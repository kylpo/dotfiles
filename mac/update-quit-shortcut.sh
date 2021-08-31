#!/bin/bash
set -e

update_quit_keybind() {
  for absoluteFile in "$1"*.app; do
    bundleId=$(mdls -name kMDItemCFBundleIdentifier -raw "$absoluteFile")
    file="${absoluteFile##*/}"
    name="${file%%.*}"

    # Overrides (where Quit command does not match its app name)
    if [[ $name == "1Password 7" ]]
    then
      name="1Password"
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
