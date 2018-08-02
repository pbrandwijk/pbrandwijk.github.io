---
layout: post
title:  "Customizing the i3 window manager"
date:   2018-07-28 12:00:00 +0200
categories: linux i3
---
*If you use i3 as your window manager, you may have trouble configuring some specific keys for volume control, brightness control and media player controls. This post shows you how to customize your i3 window manager.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS. As keyboard layout I use Dvorak (us international with dead key) and I use `xmodmap` to turn the caps lock key into BackSpace and give the caps lock function to Shift + BackSpace. See [this post][pb2]. Also, you need `i3` installed with:

```shell
pieter@ubuntu:~$ sudo apt install i3
```

## Configure i3
To change the configuration of i3, copy `/etc/i3/config` to `~/.i3/config` (or `~/.config/i3/config` if you like the XDG directory scheme) and edit it. Creating a custom config file for i3 overwrites the entire config of `/etc/i3/config`, that's why you need to copy it. I recommend making you additions to the bottom of this file.

```shell
pieter@ubuntu:~$ cp /etc/i3/config ~/.i3/config
```

### Apply xmodmap bindings on i3 start up
If you have a `~/.Xmodmap` file, add the following to your i3 config file so that the bindings are applied at i3 start up:
```
# Bindings added by [your name] :

# Apply my custom keyboard mappings
exec xmodmap ~/.Xmodmap
```

### Volume control
You may need to check first to which XF86 keyboard symbols the volume controls on your keyboard bind. You can use the commands in the Additional commands section below.

Add the audio controls to your i3 config file:
```
# Pulse Audio controls
bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume 0 +5% #increase sound volume
bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume 0 -5% #decrease sound volume
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle # mute sound
```

### Backlight control
For the below configuration to work, you need xbacklight installed and working. See [this post][pb1].

Add the backlight controls to your i3 config file:
```
# Sreen brightness controls
bindsym XF86MonBrightnessUp exec xbacklight -inc 10 # increase screen brightness
bindsym XF86MonBrightnessDown exec xbacklight -dec 10 # decrease screen brightness
```

### Media player controls
Add the media player controls to your i3 config file:
```
# Media player controls
bindsym XF86AudioPlay exec playerctl play
bindsym XF86AudioPause exec playerctl pause
bindsym XF86AudioNext exec playerctl next
bindsym XF86AudioPrev exec playerctl previous
```

### Changing your keyboard layouts
Keep in mind that when you switch your keyboard layout, you may also want to update your i3 configuration so that your bindings stay on the same keys. i3 offers the command `i3-config-wizard` to do this automatically. But keep in mind that this changes the configuration in `/etc/i3/config`, but not your custom configuration file. If you change your keyboard layout often, you may want to store various versions of your i3 config file for easy switching.

## Additional commands

### Getting current bindings
Use this command to get an overview of to which respective XF86 keyboard symbol each key on your keyboard binds:
```shell
pieter@ubuntu:~$ xmodmap -pke
```

### Analysing input events
All events (including mouse):
```shell
pieter@ubuntu:~$ xev
```

Only keyboard:
```shell
pieter@ubuntu:~$ xev -event keyboard
```

## Resources
- [Control backlight and brightness via command line][pb1]
- [Making a custom keyboard layout][pb2]
- [i3 userguide][i3]
- [Enabling multimedia keys][i3wm]

[pb1]: {{ site.baseurl }}{% post_url 2018-07-24-control-backlight-and-brightness %}
[pb2]: {{ site.baseurl }}{% post_url 2017-10-05-making-a-custom-keyboard-layout %}
[i3]: https://i3wm.org/docs/userguide.html
[i3wm]: https://faq.i3wm.org/question/3747/enabling-multimedia-keys.1.html
