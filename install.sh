#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"
echo $DIR

tic $DIR/tmux-256color.terminfo
tic $DIR/xterm-256color.terminfo

brew bundle

cd ~

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

# echo -n "Linking nvim "
# [[ ! -s ~/.config ]] && mkdir ~/.config
# [[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
# echo "done."

#[[ ! -s ~/.config/powerline ]] && ln -s $DIR/powerline  ~/.config/powerline

echo -n "Installing vim plugins... "
command vim +PlugInstall +qall
echo "done."
