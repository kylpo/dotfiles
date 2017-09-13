#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR

# Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # see https://askubuntu.com/questions/420527/how-to-dump-all-the-manully-altered-gsettings-keys
  dconf dump /org/gnome/ > $DIR/linux/gnome.bak

  # if something goes wrong, reset wtih `dconf reset -f /org/gnome/`


# Mac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  brew bundle dump --force --file=$DIR/mac/Brewfile

else
  # Unknown.
fi
