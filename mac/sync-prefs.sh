#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
PREFS_DIR="$DIR/prefs"

echo "Updating preferences in $PREFS_DIR"

bundleIds=(
  com.manytricks.Moom
  com.manytricks.Witch
  com.yujitach.MenuMetersApp
  com.robinlu.mac.Tooth-Fairy
  dexterleng.vimac
  com.runningwithcrayons.Alfred-3
  com.runningwithcrayons.Alfred-Preferences-3
  # com.googlecode.iterm2
)

for bundleId in "${bundleIds[@]}"; do
  defaults export $bundleId "$PREFS_DIR/$bundleId.plist"
done

echo "Done"