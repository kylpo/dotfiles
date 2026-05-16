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
[[ ! -e ~/.zshrc.local && ! -L ~/.zshrc.local ]] && ln -s $DIR/zshrc.local ~/.zshrc.local
# [[ ! -s ~/.ideavimrc ]] && ln -s $DIR/ideavimrc ~/.ideavimrc

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

# Symlink all folders/files in config/ to ~/.config/
for item in "$DIR"/config/*; do
  name="$(basename "$item")"
  [[ ! -s ~/.config/$name ]] && ln -s "$item" ~/.config/"$name"
done

# Symlink all scripts in bin/ to ~/.local/bin/
mkdir -p ~/.local/bin
for item in "$DIR"/bin/*; do
  name="$(basename "$item")"
  [[ ! -L ~/.local/bin/$name ]] && ln -s "$item" ~/.local/bin/"$name"
done

# Claude Code customizations: ~/.claude/{keybindings.json, hooks/*, settings.json}
mkdir -p ~/.claude/hooks

# keybindings.json: simple symlink
[[ ! -L ~/.claude/keybindings.json ]] && ln -s "$DIR/claude/keybindings.json" ~/.claude/keybindings.json

# hooks/*: loop, idempotent
for item in "$DIR"/claude/hooks/*; do
  name="$(basename "$item")"
  [[ ! -L ~/.claude/hooks/$name ]] && ln -s "$item" ~/.claude/hooks/"$name"
done

# settings.json: claude rewrites this file at runtime, so a symlink can be
# replaced by a regular file silently. Compare before linking; prompt on conflict.
SETTINGS_SRC="$DIR/claude/settings.json"
SETTINGS_DST=~/.claude/settings.json
if [[ -L "$SETTINGS_DST" ]]; then
  : # already a symlink (assume to our src) — leave it
elif [[ ! -e "$SETTINGS_DST" ]]; then
  ln -s "$SETTINGS_SRC" "$SETTINGS_DST"
elif diff -q "$SETTINGS_SRC" "$SETTINGS_DST" >/dev/null 2>&1; then
  # identical → safe to replace with symlink
  rm "$SETTINGS_DST"
  ln -s "$SETTINGS_SRC" "$SETTINGS_DST"
else
  echo
  echo "⚠️  ~/.claude/settings.json differs from $SETTINGS_SRC"
  echo "    (claude likely rewrote it via /config or /hooks since last linkify)"
  echo
  diff -u "$SETTINGS_SRC" "$SETTINGS_DST" | head -80
  echo
  if [ -t 0 ]; then
    echo "Options:"
    echo "  [s] symlink — DISCARD ~/.claude/settings.json (saved to .bak.<ts>) and link to dotfiles"
    echo "  [k] keep    — leave unlinked; copy the changes you want into $SETTINGS_SRC, then re-run linkify.sh"
    read -r -p "[s/k]: " choice
    case "$choice" in
      s|S)
        cp "$SETTINGS_DST" "$SETTINGS_DST.bak.$(date +%s)"
        rm "$SETTINGS_DST"
        ln -s "$SETTINGS_SRC" "$SETTINGS_DST"
        echo "linked. backup saved."
        ;;
      *)
        echo "skipped."
        ;;
    esac
  else
    echo "(non-interactive shell — skipped. re-run linkify.sh in a terminal to resolve.)"
  fi
fi

# if [[ "$OSTYPE" == "darwin"* ]]; then
#   [[ ! -s ~/.config/karabiner ]] && ln -s $DIR/mac/karabiner ~/.config/karabiner
#   [[ ! -s ~/.hammerspoon ]] && ln -s $DIR/mac/hammerspoon ~/.hammerspoon
# fi

#[[ ! -s ~/Library/KeyBindings ]] && mkdir ~/.Library/KeyBindings
#[[ ! -s ~/Library/KeyBindings/DefaultKeyBinding.dict ]] && ln -s $DIR/mac/DefaultKeyBinding.dict ~/Library/KeyBindings

echo "done."
