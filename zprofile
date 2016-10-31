alias gs='git status'
alias gps='git push'
alias gpl='git pull'
alias gco='git checkout '

alias start='npm start'

alias up='cd ..'
alias up2='cd ../..'
alias up3='cd ../../..'
alias up4='cd ../../../..'
alias up5='cd ../../../../..'

alias fix="git diff --name-only | uniq | xargs mvim"
alias weather="curl -4 wttr.in"

alias rm=trash

cd () {
  builtin cd $@ && ls -aG
}


# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_45.jdk/Contents/Home/
# export JBOSS_HOME=/usr/local/opt/wildfly-as/libexec
# export PATH=${PATH}:${JBOSS_HOME}/bin

# https://twitter.com/ariabuckles/status/772209060506587136
export PATH=$HOME/bin:$HOME/opt/bin:$PATH:./node_modules/.bin



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

export ANDROID_HOME=/usr/local/opt/android-sdk

export NVM_DIR=~/.nvm
  source $(brew --prefix nvm)/nvm.sh