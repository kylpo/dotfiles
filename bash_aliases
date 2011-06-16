#Networks
alias server_ssh='ssh 192.168.1.106'
alias servernfs='sudo mount -t nfs4 -o proto=tcp,port=2049 192.168.1.106:/ /Volumes/'

#Navigation
alias desktop="cd ~/Desktop"
alias dropbox="cd ~/Dropbox"
alias spider="cd ~/spideroak"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias proj='cd ~/Dropbox/school/netsys/hw\ \&\ projects/poolek_pa4_csci4273/'
alias hack='cd ~/Dropbox/school/hack/'
alias pl='cd ~/Dropbox/school/prog_lang/'
alias unix='cd ~/Dropbox/school/unix/'

alias mvn='~/.apache-maven-2.2.1/bin/mvn'

# some ls aliases
alias l='ls -l'
alias la='ls -A'
alias ll='ls -alF'
alias llh='ls -alh'
alias lls='ls -lSr' #sort by size
alias llsh='ls -lSrh' #sort by size
alias latr='ls -latr'

alias 8='rvm use 1.8.7'
alias 9='rvm use 1.9.2'

#from jtxx000 http://www.reddit.com/r/emacs/comments/hd3jm/from_my_bashrc_jump_to_emacss_current_directory/
#cd to dir of current emacs buffer; SO cool!
#alias jm='cd $(emacsclient -e "(with-current-buffer (window-buffer (frame-selected-window)) (expand-file-name default-directory))" | '"sed -E 's/(^\")|(\"$)//g')"
#alias jm='cd $(emacsclient -e "(with-current-buffer (window-buffer (frame-selected-window)) default-directory)" | '"sed -E 's/(^\")|(\"$)//g')"


####COMMANDS
alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 700='chmod 700'
alias 755='chmod 755'
alias 777='chmod 777'
alias encrypt='openssl enc -whirlpool -a -salt -in'
alias decrypt='openssl enc -whirlpool -d -salt -in'
alias mountedinfo='df -hT'
alias wget='wget --server-response --progress=bar'
alias psa='ps axo "user,pid,ppid,%cpu,%mem,tty,stime,state,command"'
alias irc="echo -n \$'\e]0;irc\a'; ssh -t zerowidth-tunnel TERM=screen screen -U -x i"
alias TAGS='find . | xargs ctags -a -e -f TAGS'
alias rrtags='ctags-exuberant -a -e -f TAGS --tag-relative -R app lib vendor'
alias g='grep -in'
alias sp='spec -cfs -Du'
alias spb='spec -bcfs -Du'
# Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

####OS Specific
OSNAME=`uname`
if [ "$OSNAME" = "Linux" ]; then
  alias px='psa | grep -v "grep" | grep'
  alias d='du --max-depth=1'
  alias df='df -T'
  alias md5str='unset HISTFILE && echo -n "str: " && read x && echo -n "$x" | md5sum'
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi
  if [ -e /etc/redhat-release ]; then
    alias pkg_add='sudo yum install'
    alias pkg_search='yum search'
    alias pkg_remove='sudo yum remove'
  fi
  if [ -e /etc/debian_version ]; then
    alias pkg_add='sudo apt-get install'
    alias pkg_search='apt-cache search'
    alias pkg_remove='sudo apt-get remove'
  fi

  #mine
  alias invert='xcalib -invert -alter'
  alias o='xdg-open'
  #alias x2m='killall xmonad-i386-linux && metacity &'
  #alias m2x='killall metacity && xmonad &'
  alias ec='emacsclient -c -nw'
  alias dropb='~/.dropbox-dist/dropboxd'
  alias lock='xscreensaver-command -lock'
  alias bak='rsync -arz --max-size='100k' ~/ /mnt/kp/bak/nb'
  #from http://gotbletu.blogspot.com/2011/04/auto-get-missing-launchpad-gpg-ppa-keys.html
  alias autokey='sudo apt-get update 2> /tmp/keymissing; for key in $(grep "NO_PUBKEY" /tmp/keymissing |sed "s/.*NO_PUBKEY //"); do echo -e "\nProcessing key: $key"; gpg --keyserver pool.sks-keyservers.net --recv $key && gpg --export --armor $key | sudo apt-key add -; done'
elif [ "$OSNAME" = "Darwin" ] || [ "$OSNAME" = "FreeBSD" ]; then
  alias df='df -lh'
  alias ls='ls -G'
  alias d='du -d 1'
  alias socksoff='networksetup -setsocksfirewallproxystate Airport off'
  alias sockson='networksetup -setsocksfirewallproxystate Airport on'
  alias bootmode_64bit='sudo systemsetup -setkernelbootarchitecture x86_64'
  alias bootmode_32bit='sudo systemsetup -setkernelbootarchitecture i386'
  alias md5str='unset HISTFILE && echo -n "str: " && read x && echo -n "$x" | md5'

  #mine
  alias mv='mv -nv'
  alias gs='growlnotify -s -m'
  alias e='mvim'
  alias et='mvim --remote-tab'
  alias gx="gitx --all"
  alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
fi

alias syn='synergyc 192.168.1.107'
alias synschool='synergys --config ~/etc/synergySchool.conf'
alias synswork='synergys --config ~/etc/synergyWork.conf'
alias synshome='synergys --config ~/etc/synergyHome.conf'
alias btm='google calendar add "btm today"'
alias journal='vim ~/journal/`date +%y%m%d.txt`'

##Info
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
  echo #
  echo Pullups
  echo 25 min anki
  echo Situps \(5m\)
  echo 25 min anki
  echo Pushups \(5m\)
  echo 25 min anki
  echo Pullups \(5m\)
  echo 25 min anki
  echo Situps \(5m\)
  echo 25 min anki
  echo Pushups \(5m\)
  echo #
'
