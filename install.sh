#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR
cd ~

# silence terminal's 'last login' message
[[ ! -s ~/.hushlogin ]] && touch ~/.hushlogin

[[ ! -s ~/.agignore ]] && ln -s $DIR/agignore ~/.agignore
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc
[[ ! -s ~/.gitconfig ]] && ln -s $DIR/gitconfig ~/.gitconfig
[[ ! -s ~/.hyperterm.js ]] && ln -s $DIR/hyperterm.js ~/.hyperterm.js

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
# [[ ! -s ~/.vimrc ]] && ln -s $DIR/vimrc ~/.vimrc
# [[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
# [[ ! -s ~/.oh-my-zsh ]] && ln -s $DIR/oh-my-zsh ~/.oh-my-zsh
# [[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc
# [[ ! -s ~/.bin ]] && ln -s $DIR/bin ~/.bin

echo -n "Linking nvim "
[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
echo "done."

#[[ ! -s ~/.config/powerline ]] && ln -s $DIR/powerline  ~/.config/powerline

echo -n "Installing plugins... "
command nvim +PlugInstall +qall
echo "done."
