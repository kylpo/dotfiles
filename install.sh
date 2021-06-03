#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
LINUX_DIR=$DIR/linux
MAC_DIR=$DIR/mac

tic $DIR/tmux-256color.terminfo
tic $DIR/xterm-256color.terminfo

# Linux
if [[ "$OSTYPE" == "linux-gnu" ]]; then
  # Notes on gsettings:
  # can use dconf to find Schema
  # `gsettings get org.gnome.desktop.input-sources xkb-option` to check values
  # `dconf dump /org/gnome/desktop/input-sources/` to find valid keys

  # Remap keyboard
  # gsettings set org.gnome.desktop.input-sources xkb-options "['shift:both_capslock_cancel', 'ctrl:swap_lalt_lctl_lwin', 'caps:super', 'altwin:swap_alt_win']"

  # TODO: gnome-shell extension preferences
  dconf load /org/gnome/ < $DIR/linux/gnome.bak

  # Yarn - https://yarnpkg.com/en/docs/install
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

  # Neovim
  sudo add-apt-repository ppa:neovim-ppa/stable

  sudo apt-get update && sudo apt-get install neovim gnome-sushi curl yarn neovim python-dev python-pip python3-dev python3-pip
  sudo apt install zsh

  # https://github.com/rupa/z
  wget https://raw.githubusercontent.com/rupa/z/master/z.sh -O ~/.z.sh

  . $LINUX_DIR/install-tmux.sh

# Mac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  cd $MAC_DIR
  ./install.sh
  cd $DIR

  # fix Option key in most apps
  # https://gist.github.com/cheapRoc/9670905#crash-course
  # and https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/EventOverview/TextDefaultsBindings/TextDefaultsBindings.html
  # and an overall guide to the Cocoa Text system, and what this file is: http://www.hcs.harvard.edu/~jrus/Site/cocoa-text.html
  [[ ! -s ~/Library/KeyBindings ]] && mkdir ~/Library/KeyBindings
  [[ ! -s ~/Library/KeyBindings/DefaultKeyBinding.dict ]] && cp $DIR/mac/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
fi

if [ ! -d ~/.oh-my-zsh ]; then
  echo -n "Setting up zsh... "
  # chsh -s `which zsh`
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  # git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm

  # https://github.com/tylerreckart/hyperzsh
  curl -L https://raw.githubusercontent.com/tylerreckart/hyperzsh/master/hyperzsh.zsh-theme > ~/.oh-my-zsh/themes/hyperzsh.zsh-theme
  echo "done."
fi

./linkify.sh

source ~/.zshrc

#[[ ! -s ~/.config/powerline ]] && ln -s $DIR/powerline  ~/.config/powerline

echo -n "Installing node (via n) and npm globals"
npm i -g n
echo "done."

# https://github.com/sindresorhus/fkill-cli
#npm i -g fkill-cli

# echo -n "Installing python3 libs"
# pip3 install --upgrade neovim
# echo "done."

# echo -n "Installing vim plugins... "
# command nvim +PlugInstall +UpdateRemotePlugins +qall
# echo "done."
