# dotfiles for Kylpo
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
5. TODO: clone repos

iTerm2 Setup
=======

Enable `Applications in terminal may access clipboard` so tmux can save to
clipboard
- see [this thread](https://github.com/tmux/tmux/issues/592#issuecomment-255763680) for more context

Also, see these useful tweets
- [adding the .bin folder to your path so you can run CLIs without having to install them globally](https://twitter.com/ariabuckles/status/772209060506587136)
- [Badassify your terminal and shell](http://jilles.me/badassify-your-terminal-and-shell/)
