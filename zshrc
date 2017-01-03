#--------------------------------------------------
# oh-my-zsh
#--------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="hyperzsh"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# plugins=(git brew)
# plugins=(tmux)

source $ZSH/oh-my-zsh.sh

source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


#--------------------------------------------------
# exports
#--------------------------------------------------

# https://twitter.com/ariabuckles/status/772209060506587136
export PATH=$HOME/bin:$HOME/opt/bin:$PATH:./node_modules/.bin
export PATH=$PATH:$HOME/.yarn/bin

export ANDROID_HOME=~/Library/Android/sdk
export PATH=${PATH}:${ANDROID_HOME}/tools
export PATH=${PATH}:${ANDROID_HOME}/platform-tools

# export MYVIMRC='~/.config/nvim/init.vim'
# export EDITOR=nvim
export NVM_DIR=$HOME/.nvm

export MYVIMRC='~/.vim/init.vim'
export EDITOR=vim
# export FZF_DEFAULT_COMMAND='ag -g ""'   # Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'   # Setting ag as the default source for fzf


#--------------------------------------------------
# sourcing
#--------------------------------------------------
source $(brew --prefix nvm)/nvm.sh
. `brew --prefix`/etc/profile.d/z.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


#--------------------------------------------------
# commands
#--------------------------------------------------

alias gs='git status'
alias gd='git diff'
alias gpu='git push'
alias gpl='git pull'
alias gco='git checkout '
alias clone='hub clone'

alias start='yarn start'
alias run='yarn run'
alias build='yarn run build'
alias clean='yarn run clean'

alias up='cd ..'
alias up2='cd ../..'
alias up3='cd ../../..'
alias up4='cd ../../../..'
alias up5='cd ../../../../..'

alias fix="git diff --name-only | uniq | xargs mvim"
alias weather="curl -4 wttr.in"

alias rm=trash

alias t=tmux

# convenience aliases for editing configs
alias ev='vim ~/.vimrc'
alias et='vim ~/.tmux.conf'
alias ez='vim ~/.zshrc'

# Make CTRL-Z background things and unbackground them.
# from wincent https://github.com/wincent/wincent/commit/30b502d811fbf4ca058db3a6f006aaecab68f6b7
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg


cd () {
  builtin cd $@ && ls -aG
}

# open vim
v () {
  if [ $# -eq 0 ]
  then
    # open current directory
    vim .
  else
    # open argument
    vim $1
  fi
}

# Anonymous function to avoid leaking NBSP variable.
# see https://www.youtube.com/watch?v=uglorjY0Ntg
function () {
  if [[ -n "$TMUX" ]]; then
    # Note use a non-breaking space at the end of the prompt because we can use it as
    # a find pattern to jump back in tmux.
    local NBSP=' '
    export PS1="$PS1$NBSP"
    export ZLE_RPROMPT_INDENT=0
  fi
}

# # Colors taken from @wincent
# ##
#
# BASE16_CONFIG=~/.vim/.base16
#
# # Takes a hex color in the form of "RRGGBB" and outputs its luma (0-255, where
# # 0 is black and 255 is white).
# #
# # Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colors
# luma() {
#   local COLOR_HEX=$1
#
#   if [ -z "$COLOR_HEX" ]; then
#     echo "Missing argument hex color (RRGGBB)"
#     return 1
#   fi
#
#   # Extract hex channels from background color (RRGGBB).
#   local COLOR_HEX_RED=$(echo "$COLOR_HEX" | cut -c 1-2)
#   local COLOR_HEX_GREEN=$(echo "$COLOR_HEX" | cut -c 3-4)
#   local COLOR_HEX_BLUE=$(echo "$COLOR_HEX" | cut -c 5-6)
#
#   # Convert hex colors to decimal.
#   local COLOR_DEC_RED=$((16#$COLOR_HEX_RED))
#   local COLOR_DEC_GREEN=$((16#$COLOR_HEX_GREEN))
#   local COLOR_DEC_BLUE=$((16#$COLOR_HEX_BLUE))
#
#   # Calculate perceived brightness of background per ITU-R BT.709
#   # https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
#   # http://stackoverflow.com/a/12043228/18986
#   local COLOR_LUMA_RED=$((0.2126 * $COLOR_DEC_RED))
#   local COLOR_LUMA_GREEN=$((0.7152 * $COLOR_DEC_GREEN))
#   local COLOR_LUMA_BLUE=$((0.0722 * $COLOR_DEC_BLUE))
#
#   local COLOR_LUMA=$(($COLOR_LUMA_RED + $COLOR_LUMA_GREEN + $COLOR_LUMA_BLUE))
#
#   echo "$COLOR_LUMA"
# }
#
# color() {
#   local SCHEME="$1"
#   local BASE16_DIR=~/.zsh/base16-shell/scripts
#
#   if [ $# -eq 0 ]; then
#     if [ -s "$BASE16_CONFIG" ]; then
#       cat ~/.vim/.base16
#       return
#     else
#       SCHEME=help
#     fi
#   fi
#
#   case "$SCHEME" in
#   help)
#     echo 'color [tomorrow-night|ocean|grayscale-light|...]'
#     echo
#     echo 'Available schemes:'
#     color ls
#     ;;
#   ls)
#     find "$BASE16_DIR" -name 'base16-*.sh' | \
#       sed -E 's|.+/base16-||' | \
#       sed -E 's/\.sh//' | \
#       column
#       ;;
#   *)
#     FILE="$BASE16_DIR/base16-$SCHEME.sh"
#     if [[ -e "$FILE" ]]; then
#       local BG=$(grep color_background= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
#       local LUMA=$(luma "$BG")
#       local LIGHT=$((LUMA > 127.5))
#       local BACKGROUND=dark
#       if [ "$LIGHT" -eq 1 ]; then
#         BACKGROUND=light
#       fi
#
#       echo "$SCHEME" >! "$BASE16_CONFIG"
#       echo "$BACKGROUND" >> "$BASE16_CONFIG"
#       sh "$FILE"
#
#       if [ -n "$TMUX" ]; then
#         local CC=$(grep color18= "$FILE" | cut -d \" -f2 | sed -e 's#/##g')
#         if [ -n "$BG" -a -n "$CC" ]; then
#           echo "$BG"
#           echo "$CC"
#           command tmux set -a window-active-style "bg=#$BG"
#           command tmux set -a window-style "bg=#$CC"
#           command tmux set -g pane-active-border-bg "#$CC"
#           command tmux set -g pane-border-bg "#$CC"
#         fi
#       fi
#     else
#       echo "Scheme '$SCHEME' not found in $BASE16_DIR"
#       return 1
#     fi
#     ;;
#   esac
#
# }
#
# function () {
#   if [[ -s "$BASE16_CONFIG" ]]; then
#     local SCHEME=$(head -1 "$BASE16_CONFIG")
#     local BACKGROUND=$(sed -n -e '2 p' "$BASE16_CONFIG")
#     if [ "$BACKGROUND" != 'dark' -a "$BACKGROUND" != 'light' ]; then
#       echo "warning: unknown background type in $BASE16_CONFIG"
#     fi
#     color "$SCHEME"
#   else
#     # Default.
#     color tomorrow-night
#   fi
# }


# function ranger-cd {
#   tempfile='/tmp/chosendir'
#   ranger --choosedir="$tempfile" "${@:-$(pwd)}"
#   test -f "$tempfile" &&
#   if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
#     cd -- "$(cat "$tempfile")"
#   fi
#   rm -f -- "$tempfile"
# }

# This binds Ctrl-O to ranger-cd:
# bind '"\C-o":"ranger-cd\C-m"'

# OPAM configuration
. /Users/kylepoole/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval $(opam config env)

