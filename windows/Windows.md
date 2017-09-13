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
choco install divvy
choco install sharpkeys
```

Download and install the ones that aren't in Chocolatey:
- [Win10 Widgets \- Widgets for Windows 10](http://win10widgets.com/)
- [win\-10\-virtual\-desktop\-enhancer](https://github.com/sdias/win-10-virtual-desktop-enhancer/blob/master/docs/settings.md#keyboard-shortcuts)
- [WinXCorners — Hot Corners for Windows 10 \| codigobit apps](http://apps.codigobit.info/2015/10/winxcorners-hot-corners-for-windows-10.html)
- [eXtra Buttons: utility buttons in the title of the window](http://www.xtrabuttons.com/)


# Apps from the Store (should auto-install)
- [QuickLook](https://www.microsoft.com/en-us/store/p/quicklook/9nv4bs3l1h4s?ocid=badge&rtc=1)
