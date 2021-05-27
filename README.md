# dotfiles for Kylpo
- first, install [Homebrew](https://brew.sh/)
- then `./install.sh`
  - First, homebrew packages are installed (from BrewFile)
    - Note: `mas` is also included to install from app store
  - Then dotfiles are linked
  - Last, nvim opens and installs plugins

1. Open `App Store` and sign in
2. Open a terminal. Input the following:

```sh
# Install xcode's CLI tools
xcode-select --install

mkdir ~/github && cd ~/github
git clone git@github.com:kylpo/dotfiles.git && cd dotfiles

# Install Homebrew (https://brew.sh/)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# ...and add it to your path
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

./install.sh
```

3. Sign in to 1Password
4. Add computer to Github
  - [Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
  - https://github.com/settings/ssh/new


BrewFile
======
To update BrewFile, run `brew bundle dump --force'

Terminal Setup
======
```sh
chsh -s `which zsh`

curl -L http://install.ohmyz.sh | sh
```

Install oh-my-zsh themes and plugins:
```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/lukechilds/zsh-nvm ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-nvm

cd /tmp && git clone https://github.com/tylerreckart/hyperzsh
cd hyperzsh && cp -R hyperzsh.zsh-theme ~/.oh-my-zsh/themes/hyperzsh.zsh-theme
```

[Set terminal vim as default "app" for code files Finder](https://www.youtube.com/watch?v=DBUuhvS8nZ8&feature=youtu.be)

iTerm2 Setup
=======

Enable `Applications in terminal may access clipboard` so tmux can save to
clipboard
- see [this
  thread](https://github.com/tmux/tmux/issues/592#issuecomment-255763680) for more context

Also, see these useful tweets
- [adding the .bin folder to your path so you can run CLIs without having to install them globally](https://twitter.com/ariabuckles/status/772209060506587136)
- `brew install trash && echo "alias rm=trash" >> ~/.zshrc` from [@tmcw](https://twitter.com/tmcw/status/784466696308400128)
- `brew cask install qlmarkdown` from [@MrRio](https://twitter.com/MrRio/status/784841830991007744)
- [Badassify your terminal and shell](http://jilles.me/badassify-your-terminal-and-shell/)
