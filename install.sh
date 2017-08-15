#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR

tic $DIR/tmux-256color.terminfo
tic $DIR/xterm-256color.terminfo

# brew bundle

echo -n "Installing npm globals"
npm i -g pomo
npm i -g import-js

# https://github.com/sindresorhus/fkill-cli
npm i -g fkill-cli
echo "done."

echo -n "Installing python3 libs"
pip3 install --upgrade neovim
echo "done."

# echo -n "Setting up zsh... "
# # chsh -s `which zsh`
#
# curl -L http://install.ohmyz.sh | sh
# echo "done."

cd ~

# fix Option key in most apps
# https://gist.github.com/cheapRoc/9670905#crash-course
# and https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/EventOverview/TextDefaultsBindings/TextDefaultsBindings.html
[[ ! -s ~/Library/KeyBindings/DefaultKeyBinding.dict ]] && cp $DIR/DefaultKeyBinding ~/Library/KeyBindings/DefaultKeyBinding.dict

# silence terminal's 'last login' message
[[ ! -s ~/.hushlogin ]] && touch ~/.hushlogin

[[ ! -s ~/.agignore ]] && ln -s $DIR/agignore ~/.agignore
[[ ! -s ~/.zsh ]] && ln -s $DIR/zsh ~/.zsh
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc
[[ ! -s ~/.gitconfig ]] && ln -s $DIR/gitconfig ~/.gitconfig
[[ ! -s ~/.hyperterm.js ]] && ln -s $DIR/hyperterm.js ~/.hyperterm.js

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
[[ ! -s ~/.vimrc ]] && ln -s $DIR/vim/init.vim ~/.vimrc
[[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
# [[ ! -s ~/tmux-256color.terminfo ]] && ln -s $DIR/tmux-256color.terminfo ~/tmux-256color.terminfo


# [[ ! -s ~/.oh-my-zsh ]] && ln -s $DIR/oh-my-zsh ~/.oh-my-zsh
# [[ ! -s ~/.bin ]] && ln -s $DIR/bin ~/.bin

echo -n "Linking nvim "
[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
echo "done."

#[[ ! -s ~/.config/powerline ]] && ln -s $DIR/powerline  ~/.config/powerline


echo -n "Installing vim plugins... "
# command vim +PlugInstall +qall
command nvim +PlugInstall +UpdateRemotePlugins +qall
echo "done."
