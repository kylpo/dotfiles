#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

echo "Linking dotfiles..."

cd ~

# silence terminal's 'last login' message
[[ ! -s ~/.hushlogin ]] && touch ~/.hushlogin

[[ ! -s ~/.agignore ]] && ln -s $DIR/agignore ~/.agignore
[[ ! -s ~/.zsh ]] && ln -s $DIR/zsh ~/.zsh
[[ ! -s ~/.zshrc ]] && ln -s $DIR/zshrc ~/.zshrc
[[ ! -s ~/.ideavimrc ]] && ln -s $DIR/ideavimrc ~/.ideavimrc

# Check if file exists and is a symlink
if [[ ! -L ~/.zshrc ]]; then
  rm ~/.zshrc
  ln -s $DIR/zshrc ~/.zshrc
fi

[[ ! -s ~/.gitconfig ]] && ln -s $DIR/gitconfig ~/.gitconfig
# [[ ! -s ~/.hyperterm.js ]] && ln -s $DIR/hyperterm.js ~/.hyperterm.js

[[ ! -s ~/.vim ]] && ln -s $DIR/vim ~/.vim
[[ ! -s ~/.vimrc ]] && ln -s $DIR/vim/init.vim ~/.vimrc
[[ ! -s ~/.tmux.conf ]] && ln -s $DIR/tmux.conf ~/.tmux.conf
# [[ ! -s ~/tmux-256color.terminfo ]] && ln -s $DIR/tmux-256color.terminfo ~/tmux-256color.terminfo

# [[ ! -s ~/.oh-my-zsh ]] && ln -s $DIR/oh-my-zsh ~/.oh-my-zsh
# [[ ! -s ~/.bin ]] && ln -s $DIR/bin ~/.bin

[[ ! -s ~/.config ]] && mkdir ~/.config
[[ ! -s ~/.config/nvim ]] && ln -s $DIR/nvim ~/.config/nvim
[[ ! -s ~/.config/karabiner ]] && ln -s $DIR/mac/karabiner ~/.config/karabiner

#[[ ! -s ~/Library/KeyBindings ]] && mkdir ~/.Library/KeyBindings
#[[ ! -s ~/Library/KeyBindings/DefaultKeyBinding.dict ]] && ln -s $DIR/mac/DefaultKeyBinding.dict ~/Library/KeyBindings

echo "done."
