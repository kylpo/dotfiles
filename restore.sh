#!/bin/bash
set -e

BACKUP_DIR="$HOME/backup"
PREFS_DIR="$BACKUP_DIR/prefs"

# Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  echo "Not implemented"

# Mac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "Importing preferences from $PREFS_DIR"

  for plist in "$PREFS_DIR/"*; do
    # Remove file path
    fileName=${plist##*/}

    # Remove file extension
    domain=${fileName%.*}
    
    defaults import $domain $plist
  done
fi
