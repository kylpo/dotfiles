# dotfiles for Kylpo
- Open `App Store` and sign in
- `Preferences`
  - \> `Desktop & Screensaver` 
    - Set desktop wallpaper to `Black`
  - \> `Security & Privacy` > `General`
    - Require password after `5 seconds` after sleep on screen saver begins
  - \> `Security & Privacy` > `Privacy` > `Full Disk Access`
    - Add `Terminal`
    - This is critical for updating certain prefs like Safari and universalaccess.
- [Add computer to Github](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
```sh
ssh-keygen -t ed25519 -C "2kylepoole@gmail.com"

# When you're prompted to "Enter a file in which to save the key," press Enter.

# Input a password

eval "$(ssh-agent -s)"

echo "Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519" > ~/.ssh/config

ssh-add -K ~/.ssh/id_ed25519

# Input password

pbcopy < ~/.ssh/id_ed25519.pub

open https://github.com/settings/ssh/new

# Input `Title` like: "Macbook Air"
# Paste key into `Key`
```

- Run install
```sh
# Install xcode's CLI tools
xcode-select --install

mkdir ~/github && cd ~/github
git clone git@github.com:kylpo/dotfiles.git && cd dotfiles

# Make an initial backup
./backup.sh

# `caffeinate -s` to keep the Mac awake while it is plugged into AC power
caffeinate -s ./install.sh

./repos.sh
```

- Sign in to `1Password`
- Add `Internet Accounts`
- Set up `VSCode`
  - `Settings Sync`
  - `Command Palette`: "install `code` command"
- Set up `iTerm`
  - Import profile: `dotfiles/mac/iterm/Klaws.json`
  - Set it to `Default`
  - Give iTerm Full Disk Access
  - `Preferences` \> `Security & Privacy` > `Privacy` > `Full Disk Access`

## Tasks to perform on a new machine
- Listen to `Music`
- Build/Test kylpo.com
- Build/Test iOS app
- Open Chronstruct Email + Drive
- Set up Notes workspace
- Compile custom QMK firmware (and transfer it to a keyboard)