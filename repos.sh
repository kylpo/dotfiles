#!/bin/bash
set -e

PUBLIC_DIR=$HOME/github
WORK_DIR=$HOME/work/
CHRONSTRUCT_DIR=$HOME/chronstruct

echo "Cloning public repos..."

pulicRepos=(
  git@github.com:kylpo/vscode-menu-builder.git
  git@github.com:kylpo/vscode-open-related.git
  git@github.com:kylpo/vscode-find-in-files-with-selection.git
  git@github.com:kylpo/react-playbook.git
  git@github.com:kylpo/kylpo.me.git
  git@github.com:kylpo/kylpo.com.git
  git@github.com:kylpo/qmk_firmware.git
  git@github.com:Chronstruct/primitives.git
)

mkdir -p $PUBLIC_DIR && cd $PUBLIC_DIR

for repo in "${pulicRepos[@]}"; do
  git clone $repo
done

echo "Cloning private repos..."

chronstructRepos=(
  git@github.com:Chronstruct/tally-ios.git
  git@github.com:Chronstruct/tally-ios-uikit.git
  git@github.com:kylpo/chronstruct-notes.git
  git@github.com:Chronstruct/CloudKitSync.git
  git@github.com:Chronstruct/chronstruct.com.git
)

mkdir -p $CHRONSTRUCT_DIR && cd $CHRONSTRUCT_DIR

for repo in "${chronstructRepos[@]}"; do
  git clone $repo
done