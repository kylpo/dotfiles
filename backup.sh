#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

BACKUP_DIR="$HOME/backup"
PREFS_DIR="$BACKUP_DIR/prefs"

# Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # https://askubuntu.com/questions/420527/how-to-dump-all-the-manully-altered-gsettings-keys
  dconf dump /org/gnome/ > $BACKUP_DIR/gnome.bak

  # if something goes wrong, reset wtih `dconf reset -f /org/gnome/`

# Mac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Backing up preferences to $PREFS_DIR"

  # Make the prefs dir (and parents) if it doesn't already exist
  mkdir -p $PREFS_DIR

  # Put domains into an array
  IFS=", " domains=(`defaults domains`)

  # Loop over domains and export their .plist
  for i in ${domains[@]}; do
    defaults export $i "$PREFS_DIR/$i.plist"
  done

  echo "Generating hotkeys backup..."

  [[ -f $DIR/mac/backup-hotkeys.sh ]] && . $DIR/mac/backup-hotkeys.sh
fi
