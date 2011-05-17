#mostly taken from http://pastebin.com/sVw8guUE
#and https://github.com/aniero/dotfiles/blob/master/bash_profile

####PATHS
export PATH=/usr/local/bin:$PATH:~/work/git_support/bin:~/Dropbox/scripts/
export PGDATA=/usr/local/var/postgres/
# colorized grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='1;33'

. ~/.dotfiles/secrets # api keys etc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

####ALIASES
if [ -f ~/.dotfiles/bash_aliases ]; then
  . ~/.dotfiles/bash_aliases
fi

if [ -f ~/.dotfiles/bash_aliases_secret ]; then
  . ~/.dotfiles/bash_aliases_secret
fi

####CONFIG
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

####SCRIPTS
mk() { eval ${1:-MKPWD}=\"`pwd`\"; }
rt() { eval cd \"\$${1:-MKPWD}\";pwd; }
str2hex() { echo -n "str: " && read x && echo -n "$x" |xxd -c 256 -p |sed 's/0a//1'|awk '{print $1}';}
maxcrypt() { echo -n "str: " && read x && echo -n "$x"|openssl dgst -sha512 |openssl dgst -ripemd160;}
netinfo() { /sbin/ifconfig|grep "inet"|grep -v "inet6"|awk '{print $1" "$2" "$3" "$4}'|grep -v "127.0.0.1";}

####FUNCTIONS
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

####PROMPT
TEXT_BLACK='\[\e[0;30m\]' # Black - Regular
TEXT_RED='\e[0;31m' # Red
TEXT_GREEN='\e[0;32m' # Green
TEXT_YELLOW='\[\e[0;33m\]' # Yellow
TEXT_BLUE='\[\e[0;34m\]' # Blue
TEXT_PURPLE='\[\e[0;35m\]' # Purple
TEXT_CYAN='\[\e[0;36m\]' # Cyan
TEXT_WHITE='\[\e[0;37m\]' # White
TEXT_RESET='\[\e[0m\]' # Text Reset
#BLACK='\e[0;30m'
#BLUE='\e[0;34m'
#GREEN='\e[0;32m'
#CYAN='\e[0;36m'
#PURPLE='\e[0;35m'
#BROWN='\e[0;33m'
TEXT_LIGHTGRAY='\e[0;37m'
#TEXT_DARKGRAY='\e[1;30m'
#LIGHTBLUE='\e[1;34m'
#LIGHTGREEN='\e[1;32m'
#LIGHTCYAN='\e[1;36m'
#LIGHTRED='\e[1;31m'
#LIGHTPURPLE='\e[1;35m'
#YELLOW='\e[1;33m'
#WHITE='\e[1;37m'
#NC='\e[0m'
NORMAL="\[\033[0m\]"
WHITE="\[\033[0;37;40m\]"
MAGENTA="\[\033[0;43;40m\]"
BRIGHTBLUE="\[\033[0;31;40m\]"
BRIGHTWHITE="\[\033[1;37;40m\]"
BRIGHTMAGENTA="\[\033[0;33;40m\]"

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

if [[ $TERM_PROGRAM == 'iTerm.app' || $TERM == 'xterm' ]]; then
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
  #check if root user
  if [ $UID -eq 0 ] ; then
    SYM='ROOT'
  else
    SYM=''
  fi

   P1="${MAGENTA}${SYM}${TEXT_RESET}${TAB_NAME}${WINDOW_NAME}$(rvm-prompt v s g) "
   P2="${TEXT_GREEN}\w${TEXT_RESET}$(__git_ps1)$(git_dirty_flag) $(previous_exit_status $previous) "
   PS1="${P1}${P2}"
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

export LS_COLORS="no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:"
#LS_COLORS=rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:


################COLORS

#### OS SPECIFIC
OSNAME=`uname`
if [ "$OSNAME" = "Darwin" ] || [ "$OSNAME" = "FreeBSD" ]; then
  echo -n "Today: " && date +'%A %B %e'
  echo -n "Networks: "; netinfo
  echo -n "Kernel: " `uname -smr`; echo ""
  echo  ""; df -lh

  if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
    source `brew --prefix git`/etc/bash_completion.d/git-completion.bash #git tab-completion
  fi

  # MacPorts Installer addition on 2011-05-16_at_08:17:56: adding an appropriate PATH variable for use with MacPorts.
  export PATH=/opt/local/bin:/opt/local/sbin:$PATH
  # Finished adapting your PATH environment variable for use with MacPorts.

elif [ "$OSNAME" = "Linux" ]; then
  echo -ne "${TEXT_RED}Today: ${TEXT_LIGHTGRAY}" && date +'%A %B %e'
  echo -ne "${TEXT_RED}Load: ${TEXT_LIGHTGRAY}"; uptime|awk -F, '{print $4" "$5" "$6}'|awk -F: '{print $2}'
  echo -ne "${TEXT_RED}Uptime: ${TEXT_LIGHTGRAY}"; uptime|awk -F, '{print $1}'|awk '{print $3" "$4}'
  echo -ne "${TEXT_RED}Networks: ${TEXT_LIGHTGRAY}"; netinfo
  echo -ne "${TEXT_RED}Kernel: ${TEXT_LIGHTGRAY}" `uname -smr`; echo ""
  echo -e "${TEXT_LIGHTGRAY}"; df -lhT

  # Added by autojump install.sh
  source /etc/profile.d/autojump.bash
fi

