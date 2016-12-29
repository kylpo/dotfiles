# dotfiles for Kylpo

- First, homebrew packages are installed (from BrewFile)
  - Note: `mas` is also included to install from app store
- Then dotfiles are linked
- Last, nvim opens and installs plugins
- Be sure to follow steps below to finish setup

BrewFile
======
To update BrewFile, run `brew bundle dump --force'

Terminal Setup
======
```sh
#brew install z
#brew install trash

#brew install zsh
chsh -s `which zsh`

curl -L http://install.ohmyz.sh | sh
```

Install oh-my-zsh themes and plugins:
```sh
cd ~/.oh-my-zsh && git clone git://github.com/zsh-users/zsh-syntax-highlighting.git

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
