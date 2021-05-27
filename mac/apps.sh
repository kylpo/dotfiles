#!/usr/bin/env bash

# Originally from https://github.com/albertoqa/dotfiles/blob/master/bin/brew.sh
#
# IMPORTANT:
# Install Xcode before running this script.

# agree to xcode license and install command line tools
# sudo xcodebuild -license
# sudo xcode-select --install

# Install brew (if not already installed)
if ! command -v brew >/dev/null 2>&1; then
  echo "Installing brew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi;

# Check if the installation was ok
brew doctor | grep 'Your system is ready to brew' &> /dev/null
if [ $? != 0 ]; then
  echo "An error ocurred and brew cannot be installed... exiting now"
  exit
fi

# Update homebrew and any installed formulae
brew update
brew upgrade

###############################################################################
# CLI Tools
###############################################################################

echo "Installing CLI Tools..."

brew install mas                  # interface for the Mac App Store
brew install the_silver_searcher  # alternative to ack maybe faster
brew install wget                 # similar to curl
brew install speedtest_cli        # test internet bandwidth using speedtest.net
brew install ssh-copy-id          # install your public key in a remote machine's authorized_keys
brew install rename               # rename files easy
brew install htop                 # better top replacement
brew install tree                 # display full directory hierarchy
brew install pstree               # display running processes as a tree
#brew install pv                   # show progress bar in pipelines
brew install iftop                # show network usage (similar to top)
# brew install unrar                # decompress rar files
#brew install dockutil             # manage dock items from the terminal
#brew install gpg                  # free implementation of the OpenPGP
#brew install thefuck		  # correct previous console command
#brew install sshrc		  # sources the .sshrc file after logging in remotely
brew install yarn
brew install z
brew install zsh
brew install trash
#brew install vim
brew install neovim
brew install bash-completion
brew install ffmpeg
brew install fzf
brew install git
brew install git-extras
brew install git-flow
brew install git-lfs
brew install ranger

###############################################################################
# Quicklook
###############################################################################

echo "Installing Quicklook plugins..."

brew install qlmarkdown        # preview Markdown files
brew install qlimagesize       # image dimensions
brew install qlstephen         # preview plain text files without a extension
# brew cask install qlcolorcode       # preview source code with syntax highlight
brew install quicklook-json    # preview JSON files
#brew cask install quicklook-csv     # preview CSV files
#brew cask install qlprettypatch     # preview diffs
#brew cask install betterzipql       # preview archives [does not exist?]

# Enable text selection in QuickLook views.
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

###############################################################################
# Menubar
###############################################################################

echo "Installing Menubar Apps..."

brew install itsycal
brew install menumeters

###############################################################################
# Mac App Store Apps
###############################################################################

echo "Installing Mac Store Apps..."

# This command will not allow you to install an app for the first time: it must
# already be in the Purchased tab of the App Store.

mas install 557168941	  # Tweetbot
mas install 419330170	  # Moom
mas install 803453959   # Slack
mas install 1475897096  # Jira Cloud by Atlassian 
mas install 1191449274  # ToothFairy - easy bluetooth audio toggles
mas install 1333542190  # 1Password 7 - Password Manager
mas install 1461845568  # Gifox 2 - gif screen recorder

mas install 497799835   # Xcode
# agree to xcode license
sudo xcodebuild -license accept

###############################################################################
# Misc Apps
###############################################################################

echo "Installing Misc Apps..."

brew install hammerspoon
brew install google-chrome

###############################################################################
# Development
###############################################################################

echo "Installing Development stuff..."

# Install python (macOS version is outdated) and python3
# Both are compatibles and this way you can test the code in both
# brew install python python3

# update pip and setuptools
# pip install --upgrade pip setuptools
# pip3 install --upgrade pip setuptools wheel

brew install iterm2  # Better terminal than Terminal
brew install dash    # Offline programming docs
brew install visual-studio-code

## QMK stuff
#brew install --cask qmk-toolbox
#brew install qmk/qmk/qmk

###############################################################################
# Cleanup
###############################################################################

echo "Cleaning up..."

brew cleanup

###############################################################################
# Prefs
###############################################################################

echo "Importing App preferences..."

DIR="$( cd "$( dirname "$0" )" && pwd )"

for plist in "$DIR/prefs/"*; do
    # Remove file path
    fileName=${plist##*/}

    # Remove file extension
    domain=${fileName%.*}
    
    echo "defaults import $domain $plist"
    defaults import $domain $plist
  done

# ---------------------------
# XCode
# ---------------------------
# find more of these with commands from https://twitter.com/j4n0/status/1173370217239666688 (though it doesn't find all of them).
#   `strings /Applications/Xcode.app/Contents/Frameworks/IDEKit.framework/Versions/A/IDEKit | grep -E '^IDE[[:alpha:]]+$' | grep -E '(Animation|Disable|Enable|Disable|Show|Speed)' | sort`

# Show project build times in the activity viewer
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Add file Counterparts (see https://twitter.com/peterfriese/status/1364544309878534144)
defaults write com.apple.dt.Xcode IDEAdditionalCounterpartSuffixes -array-add "ViewModel" "View" "Screen"

# If you use the rename refactoring in Xcode a lot, you can save some time by skipping the code folding animation
defaults write com.apple.dt.Xcode CodeFoldingAnimationSpeed -int 0

# ---------------------------
# iTerm2
# ---------------------------
# "Minimal" look
defaults write com.googlecode.iterm2 TabStyleWithAutomaticOption -int 5

echo "Done installing apps!"