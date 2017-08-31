# Win32 apps (not in the app store)
First, install [Chocolatey](https://chocolatey.org/install) via `Command Prompt` in `Administrator` mode.

![https://www.howtogeek.com/194041/how-to-open-the-command-prompt-as-administrator-in-windows-8.1/](https://www.howtogeek.com/wp-content/uploads/2017/05/xcpa_4.png.pagespeed.gp+jp+jw+pj+ws+js+rj+rp+rw+ri+cp+md.ic.L3C1Xpdujf.png)

After it is installed, auto-confirm installing with this config:

`choco feature enable -n allowGlobalConfirmation`

Now, install all of you win32 apps that you can (while still in `Admin Command Prompt`)
```sh
choco install googlechrome
choco install visualstudiocode
choco install wox
choco install autohotkey
choco install winxcorners
choco install divvy
choco install sharpkeys
```

# Apps from the Store (should auto-install)
