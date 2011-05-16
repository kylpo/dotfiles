export PATH=/usr/local/bin:$PATH:~/work/git_support/bin
export CI_EMAIL=kyle@collectiveintellect.com
export PGDATA=/usr/local/var/postgres/
# colorized grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
  source `brew --prefix git`/etc/bash_completion.d/git-completion.bash #git tab-completion
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.dotfiles/bash_aliases ]; then
  . ~/.dotfiles/bash_aliases
fi

if [ -f ~/.dotfiles/bash_aliases_secret ]; then
  . ~/.dotfiles/bash_aliases_secret
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
function gemdir() {
cd `rvm gemdir`/gems
}

function d() {
if [ -n "$1" ]; then
  if [ -d "$1" ]; then
    pushd $1 >/dev/null
    ctags -R
    # mvim --servername $(basename $(pwd)) --remote-silent .
    mvim .
    popd >/dev/null
  else
    echo "$1 is not a directory"
  fi
else
  ctags -R
  # mvim --servername $(basename $(pwd)) --remote-silent .
  mvim .
  # echo "specify a directory to edit"
fi
}

pkill() {
  if [ -z "$1" ]; then
    echo "Usage: pkill [process name]"
    return 1
  fi

  local pid
  pid=$(p $1 | awk '{ print $1 }')

  if [ -n "$pid" ]; then
    echo -n "Killing \"$1\" (process $pid)..."
    kill -9 $pid
    echo "done."
  else
    echo "Process \"$1\" not found."
  fi
}

# sweetness from tim pease:
p() {
  if [ -n "$1" ]; then
    ps -O ppid -U $USER | grep -i "$1" | grep -v grep
  else
    ps -O ppid -U $USER
  fi
}

# via mojombo http://gist.github.com/180587
function psg {
ps wwwaux | egrep "($1|%CPU)" | grep -v grep
}

function ssh-setup {
cat ~/.ssh/id_rsa.pub | ssh $1 'cat - >> ~/.ssh/authorized_keys'
}

#for the prompt colors
TEXT_BLACK='\[\e[0;30m\]' # Black - Regular
TEXT_RED='\[\e[0;31m\]' # Red
TEXT_GREEN='\[\e[0;32m\]' # Green
TEXT_YELLOW='\[\e[0;33m\]' # Yellow
TEXT_BLUE='\[\e[0;34m\]' # Blue
TEXT_PURPLE='\[\e[0;35m\]' # Purple
TEXT_CYAN='\[\e[0;36m\]' # Cyan
TEXT_WHITE='\[\e[0;37m\]' # White
TEXT_RESET='\[\e[0m\]' # Text Reset

previous_exit_status() {
  if [ $1 -eq 0 ]; then
    # HEAVY ROUND-TIPPED RIGHTWARDS ARROW
    echo -n "▸"
    # echo -n "➜"
    #echo -n "•"
    # echo -n "⧫"
  else
    # HEAVY BALLOT X
    echo -n "${TEXT_RED}✘${TEXT_RESET}"
  fi
}

# good bits are all via git-completion.bash from git.
# using custom function to allow for colors instead of the
# GIT_PS1_SHOWDIRTYSTATE
# GIT_PS1_SHOWSTASHSTATE
# GIT_PS1_SHOWUNTRACKEDFILES
# environment variables.
git_dirty_flag() {
  if [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then

    # modifications of tracked files
    # git diff-files --no-ext-diff --ignore-submodules --exit-code --quiet \
      # now, from __git_ps1:
    git diff --no-ext-diff --ignore-submodules --quiet --exit-code \
      || echo -n "${TEXT_YELLOW}*${TEXT_RESET}"

    # staged hunks
    if git rev-parse --quiet --verify HEAD >/dev/null; then
      git diff-index --no-ext-diff --ignore-submodules --cached --exit-code HEAD --quiet \
        || echo -n "${TEXT_GREEN}+${TEXT_RESET}"
    fi

    # untracked files
    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      echo -n "${TEXT_CYAN}?${TEXT_RESET}"
    fi

    # stashed changes
    git rev-parse --verify refs/stash >/dev/null 2>&1 && echo -n "${TEXT_PURPLE}\$${TEXT_RESET}"
  fi
}

if [[ $TERM_PROGRAM == 'iTerm.app' ]]; then
  # 0 means both tab and window, 1 is tab, 2 is window
  # see:
  # http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss4.3
  # http://www.mit.edu/afs/athena/system/x11r4/src/mit/clients/xterm/ctlseq2.txt via
  # http://ubuntuforums.org/archive/index.php/t-448614.html
  TAB_NAME='\[\e]1;\w\a\]'
  WINDOW_NAME='\[\e]2;\u@\h:\w\a\]'
else
  TAB_NAME=''
  WINDOW_NAME=''
fi

set_prompt(){
  previous=$?;
  PS1="${TAB_NAME}${WINDOW_NAME}$(rvm-prompt v s g) ${TEXT_GREEN}\w${TEXT_RESET}$(__git_ps1)$(git_dirty_flag) $(previous_exit_status $previous) "
}
PROMPT_COMMAND=set_prompt

# a     black
# b     red
# c     green
# d     brown
# e     blue
# f     magenta
# g     cyan
# h     light grey
# A     bold black, usually shows up as dark grey
# B     bold red
# C     bold green
# D     bold brown, usually shows up as yellow
# E     bold blue
# F     bold magenta
# G     bold cyan
# H     bold light grey; looks like bright white
# x     default foreground or background
# directory -----\
  # symlink        +-\
  # socket         +-+-\
  # pipe           +-+-+-\
  # executable     +-+-+-+-\
  # block special  +-+-+-+-+-\
  # char special   +-+-+-+-+-+-\
  # suid           +-+-+-+-+-+-+-\
  # setguid        +-+-+-+-+-+-+-+-\
  # write+sticky/  +-+-+-+-+-+-+-+-+-\
  # write-sticky/  +-+-+-+-+-+-+-+-+-+-\
  #                v v v v v v v v v v v
export LSCOLORS="gxfxcxdxbxegedabagacad"
# default: "exfxcxdxbxegedabagacad"

# export TERM_BLACK="\[\e[30;1m\]"
# export TERM_RED="\[\e[31;1m\]"
# export TERM_GREEN="\[\e[32;1m\]"
# export TERM_YELLOW="\[\e[33;1m\]"
# export TERM_BLUE="\[\e[34;1m\]"
# export TERM_MAGENTA="\[\e[35;1m\]"
# export TERM_CYAN="\[\e[36;1m\]"
# export TERM_WHITE="\[\e[37;1m\]"
# export TERM_RESET="\[\e[0m\]"

# export PS1="${TERM_RED}\u${TERM_WHITE}@${TERM_YELLOW}\h${TERM_WHITE}:${TERM_GREEN}\w ${TERM_WHITE}%${TERM_RESET} "
# export PS2="> "
# export PS3="#? "
# export PS4="+"

# export LSCOLORS="no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"

##
# Your previous /Users/kp/.bash_profile file was backed up as /Users/kp/.bash_profile.macports-saved_2011-05-16_at_08:17:56
##

# MacPorts Installer addition on 2011-05-16_at_08:17:56: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

