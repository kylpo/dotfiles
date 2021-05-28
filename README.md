# dotfiles for Kylpo
- Open `App Store` and sign in
- Set desktop wallpaper to `Black`
- `Preferences` > `Security & Privacy` > `General`
  - Require password after `5 seconds` after sleep on screen saver begins
- Add computer to Github
  - [Generating a new SSH key and adding it to the ssh-agent - GitHub Docs](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
  - https://github.com/settings/ssh/new
- Open a terminal. Input the following:

```sh
# Install xcode's CLI tools
xcode-select --install

mkdir ~/github && cd ~/github
git clone git@github.com:kylpo/dotfiles.git && cd dotfiles

# Make an initial backup
./backup.sh

# `caffeinate -s` to keep the Mac awake while it is plugged into AC power
caffeinate -s ./install.sh
```

1. `./repos.sh`
2. Sign in to 1Password
3. Add `Internet Accounts`
4. Set up `VSCode`'s `Settings Sync`

iTerm2 Setup
=======

Enable `Applications in terminal may access clipboard` so tmux can save to
clipboard
- see [this thread](https://github.com/tmux/tmux/issues/592#issuecomment-255763680) for more context

Also, see these useful tweets
- [adding the .bin folder to your path so you can run CLIs without having to install them globally](https://twitter.com/ariabuckles/status/772209060506587136)
- [Badassify your terminal and shell](http://jilles.me/badassify-your-terminal-and-shell/)
