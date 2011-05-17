# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

######
alias syn='synergyc 192.168.1.107'
alias synwork='synergyc 10.1.90.176'
alias whoville='https://venture1.projectlocker.com/WhozThat/whoville/svn'
alias synschool='synergys --config ~/etc/synergySchool.conf'
alias synswork='synergys --config ~/etc/synergyWork.conf'
alias synshome='synergys --config ~/etc/synergyHome.conf'
alias invert='xcalib -invert -alter'
alias o='xdg-open'
#alias x2m='killall xmonad-i386-linux && metacity &'
#alias m2x='killall metacity && xmonad &'
alias ec='emacsclient -n'
alias dropb='~/.dropbox-dist/dropboxd'
alias lock='xscreensaver-command -lock'
alias btm='google calendar add "btm today"'
alias c='clear'
alias journal='vim ~/journal/`date +%y%m%d.txt`'
alias bak='rsync -arz --max-size='100k' ~/ /mnt/kp/bak/nb'
alias rrtags='ctags-exuberant -a -e -f TAGS --tag-relative -R app lib vendor'
alias TAGS='find . | xargs ctags -a -e -f TAGS'
#from http://gotbletu.blogspot.com/2011/04/auto-get-missing-launchpad-gpg-ppa-keys.html
alias autokey='sudo apt-get update 2> /tmp/keymissing; for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //"); do echo -e "\nProcessing key: $key"; gpg --keyserver pool.sks-keyservers.net --recv $key && gpg --export --armor $key | sudo apt-key add -; done'

#Info
alias gcl='
echo #
echo btm = Brush Teeth Morning
echo btn  = Brush Teeth Night
echo Anki = 2h Anki or adding to anki
echo Journal = Journal
echo bboa = Big Book of Answers
echo wfm = Wash Face Morning
echo wfn = Wash Face Night
echo 1aday = 1ADay
echo #
'
alias ankiorder='
echo Pullups
echo 25 min anki
echo Situps (5m)
echo 25 min anki
echo Pushups (5m)
echo 25 min anki
echo Pullups (5m)
echo 25 min anki
echo Situps (5m)
echo 25 min anki
echo Pushups (5m)
'
#Navigation
alias proj='cd ~/Dropbox/school/netsys/hw\ \&\ projects/poolek_pa4_csci4273/'
alias mvn='~/.apache-maven-2.2.1/bin/mvn'
alias pl='cd ~/Dropbox/school/prin_pro_lang/'
alias hack='cd ~/Dropbox/school/hack/'
alias pl='cd ~/Dropbox/school/prog_lang/'
alias unix='cd ~/Dropbox/school/unix/'
alias awm='cd ~/.config/awesome/'
alias ...='cd ../..'
alias ....='cd ../../..'

#Networks
alias unixssh='ssh kp@128.138.202.105'
alias elra-01='ssh poolek@elra-01.cs.colorado.edu'
alias server_ssh='ssh 192.168.1.106'
alias servernfs='sudo mount -t nfs4 -o proto=tcp,port=2049 192.168.1.106:/ /mnt'
alias moxie='ssh poolek@moxie.cs.colorado.edu'

PATH=$PATH:/home/kp/Dropbox/scripts/
export PATH

# Added by autojump install.sh
source /etc/profile.d/autojump.bash

#RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
