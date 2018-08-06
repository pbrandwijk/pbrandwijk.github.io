---
layout: post
title:  "Making a custom keyboard layout"
date:   2017-10-05 12:00:00 +0200
tags:   linux keyboard xkb i3
---
*For more comfortable typing I use the Dvorak keyboard layout instead of Qwerty. However, I also prefer to use the caps lock key, which I rarely use, as an extra back space key. And I move caps lock to Shift + Back space. In this post I explain how it is configured.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Adding custom keyboard layout
The keyboard layouts of XKB are stored under the 'symbols' folder of `/usr/share/X11/xkb/`.

Add the following snippet to `/usr/share/X11/xkb/symbols/us` file below the "dvorak-intl" definition:
```
// Pieter Brandwijk: My own custom layout based on Dvorak international with dead keys.
partial alphanumeric_keys
    xkb_symbols "dvorak-intl-swap-caps" {

    include "us(dvorak-intl)"

    name[Group1]="English (Dvorak, intl. swap Caps Lock)";

    // Replace Caps_Lock with BackSpace
    key <CAPS> { [ BackSpace            ] };
};
```

After this, you have to add a variant for the us layout to `/usr/share/X11/xkb/rules/evdev.xml` :
```xml
<variant>
  <configItem>
    <name>dvorak-intl-swap-caps</name>
    <description>English (Dvorak, intl. swap Caps Lock)</description>
  </configItem>
</variant>
```

Add this just below the variant with the description "English (Dvorak, intl., with dead keys)"

## Alternative with xmodmap
The method above works fine when you use the standard Gnome window manager for Ubuntu. I use the i3 tiling window manager, which somehow doesn't pick up my customization. This alternate does work with i3.

You can customize a predefined layout using `xmodmap`. Place the following script in `~/.Xmodmap`
```
keycode 66 = BackSpace
keycode 22 = BackSpace Caps_Lock
clear Lock
```

This script has to be run when your window manager starts up. For i3, add the following to your i3 config file (`~/.i3/config` or `~/.config/i3/config`):
```
# Apply my custom keyboard mappings
exec xmodmap ~/.Xmodmap
```

## Additional commands

### Gnome Tweak tool
If you use Gnome, the Gnome tweak tool allows you to do configurations that you won't find in the standard settings.
```console
pieter@ubuntu:~$ sudo apt install gnome-tweak-tool
```

## Switching the keyboard layout on the commmand line
If your GUI has no option to switch keyboard layout, you can use the following to do it with the command line:
```console
pieter@ubuntu:~$ setxkbmap -layout us -variant dvorak-intl-swap-caps
pieter@ubuntu:~$ setxkbmap -layout us -variant dvorak-intl
pieter@ubuntu:~$ setxkbmap -layout us -variant intl
```

Use the following to check which configuration you are currently using:

```console
pieter@ubuntu:~$ setxkbmap -query
```

## Resources
- [Custom keyboard layout definitions][ubuntu]
- [How do I remap the caps-lock key to the backspace key][askubuntu]
- [Remapping both caps lock and shiftcaps lock in xkb][stack]
- [Xmodmap clear modifier not working][stack2]
- [A simple humble but comprehensive guide to xkb for linux][medium]
- [How do I make the caps lock key a third shift key][askubuntu2]
- [Keyboard and Console HOWTO][tldp]
- [xmodmap Map Delete to Shift+BackSpace][archlinux]
- [CapsLock Remap Howto][noah]
- [How to apply xmodmap permanently][xmodmap]
- [XKB Configuration Files][char]

[stack]: https://unix.stackexchange.com/questions/90089/remapping-both-caps-lock-and-shiftcaps-lock-in-xkb
[stack2]: https://unix.stackexchange.com/questions/202930/xmodmap-clear-modifier-not-working
[medium]: https://medium.com/@damko/a-simple-humble-but-comprehensive-guide-to-xkb-for-linux-6f1ad5e13450
[ubuntu]: https://help.ubuntu.com/community/Custom%20keyboard%20layout%20definitions?action=show&redirect=Howto%3A+Custom+keyboard+layout+definitions
[askubuntu]: https://askubuntu.com/questions/653591/how-do-i-remap-the-caps-lock-key-to-the-backspace-key
[askubuntu2]: https://askubuntu.com/questions/82837/how-do-i-make-the-caps-lock-key-a-third-shift-key/820421
[tldp]: http://tldp.org/HOWTO/Keyboard-and-Console-HOWTO-5.html
[archlinux]: https://bbs.archlinux.org/viewtopic.php?id=139169
[noah]: http://www.noah.org/wiki/CapsLock_Remap_Howto
[xmodmap]: https://askubuntu.com/questions/333897/how-to-apply-xmodmap-permanently
[char]: http://www.charvolant.org/doug/xkb/html/node5.html
