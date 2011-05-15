#Networks
alias server_ssh='ssh 192.168.1.106'
alias servernfs='sudo mount -t nfs4 -o proto=tcp,port=2049 192.168.1.106:/ /Volumes/'

#Navigation
alias desktop="cd ~/Desktop"
alias dropbox="cd ~/Dropbox"
alias spider="cd ~/spideroak"
alias ...='cd ../..'
alias ....='cd ../../..'

# some ls aliases
alias ls='ls -FG' #color
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias latr='ls -latr'

alias 8='rvm use 1.8.7'
alias 9='rvm use 1.9.2'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias mv='mv -nv'
alias vi='vim'
alias irc="echo -n \$'\e]0;irc\a'; ssh -t zerowidth-tunnel TERM=screen screen -U -x i"
alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient -n'
alias TAGS='find . | xargs ctags -a -e -f TAGS'
alias g='grep -in'
alias gs='growlnotify -s -m'
alias e='mvim'
alias et='mvim --remote-tab'
alias gx="gitx --all"

alias sp='spec -cfs -Du'
alias spb='spec -bcfs -Du'
