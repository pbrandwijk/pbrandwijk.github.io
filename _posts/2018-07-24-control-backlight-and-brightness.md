---
layout: post
title:  "Control backlight and brightness via command line"
date:   2018-05-28 23:30:00 +0200
tags:   linux i3
---
*If you use i3 or a similar tool as your window manager, you may have trouble adjusting your screen's backlight and brightness settings. This post shows you how to control them from the command line.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS. You may need to install `xbacklight` and `xrandr`.

## Setting the backlight
Relevant files for the backlight are stored under `/sys/class/backlight`. You can use the following commands to control the backlight:

```console
$ xbacklight -get
$ xbacklight -set 50
$ xbacklight -dec 10
$ xbacklight -inc 10
```

If you get an error message saying "no outputs have backlight properties", you may need to use `sudo` to create a file `/etc/X11/xorg.conf` with the following content:

```console
$ cat /etc/X11/xorg.conf
Section "Device"
Identifier "Card0"
Driver  "intel"
Option  "Backlight"  "intel_backlight"
EndSection
```

## Setting the brightness
Find out the name of your screen device with `xrandr` or `xrandr --verbose`:

```console
$ xrandr --verbose
Screen 0: minimum 8 x 8, current 1600 x 900, maximum 32767 x 32767
eDP1 connected primary 1600x900+0+0 (0x48) normal (normal left inverted right x axis y axis) 390mm x 220mm
	Identifier: 0x43
	Timestamp:  20352854
	Subpixel:   unknown
	Gamma:      1.0:1.0:1.0
	Brightness: 1.0
...
```

Note that by adding the file `/etc/X11/xorg.conf` as described above, the name of the screen device may have changed. Mine changed from `eDP-1` to `eDP1`. If I remove `/etc/X11/xorg.conf` it changes back to `eDP-1` again.

Use the following commands to control the screen brightness:
```console
$ xrandr --output eDP1 --brightness 1.7
$ xrandr --output eDP1 --brightness 0.6
$ xrandr --output eDP1 --brightness -0.6
```

The `xrandr` tool has some other options you can play with too.
```console
$ xrandr --output eDP1 --gamma 2:2:1
$ xrandr --output eDP1 --gamma 1:1:1
$ xrandr --output eDP1 --reflect x
$ xrandr --output eDP1 --reflect normal
$ xrandr --output eDP1 --rotate left
$ xrandr --output eDP1 --reflect normal
$ xrandr --output eDP1 --rotate right
$ xrandr --output eDP1 --rotate normal
$ xrandr --output eDP1 --reflect x
$ xrandr --output eDP1 --reflect normal
```


## Resources
- [xbacklight produces “no outputs have backlight property”][ubuntuforums]
- [Set bindings in i3 to control keyboard backlight][stackexchange]
- [How to Configure Screen Brightness in Ubuntu][maketecheasier]
- [How to control backlight by terminal command][stackoverflow]
- [How to Find Hardware Devices in Ubuntu Linux with lshw][chrisjean]

[ubuntuforums]: https://askubuntu.com/questions/938876/xbacklight-produces-no-outputs-have-backlight-property-and-brightness-buttons
[stackexchange]: https://unix.stackexchange.com/questions/260409/set-bindings-in-i3-to-control-keyboard-backlight
[maketecheasier]: https://www.maketecheasier.com/configure-screen-brightness-in-ubuntu/
[stackoverflow]: https://stackoverflow.com/questions/25588367/how-to-control-backlight-by-terminal-command
[chrisjean]: https://chrisjean.com/how-to-find-hardware-devices-in-ubuntu-with-lshw/
