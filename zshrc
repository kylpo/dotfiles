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

export MYVIMRC='~/.config/nvim/init.vim'
export EDITOR=nvim
# export FZF_DEFAULT_COMMAND='ag -g ""'   # Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'   # Setting ag as the default source for fzf

export NVM_DIR=~/.nvm


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
alias gpu='git push'
alias gpl='git pull'
alias gco='git checkout '

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

# open nvim
v () {
  if [ $# -eq 0 ]
  then
    # open current directory
    nvim .
  else
    # open argument
    nvim $1
  fi
}


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
