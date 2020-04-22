---
layout:   post
title:    "Cheat sheet i3 for Dvorak"
date:     2018-10-12 10:20:00 +0200
tags:     ubuntu i3 dvorak "cheat sheet"
---
## i3 Window Manager Cheat Sheet for Dvorak
I could not find a cheat sheet for i3 based on the Dvorak keyboard layout, so I made my own.

`$mod` refers to the modifier key (alt by default)

## General
* `startx i3` start i3 from command line
* `$mod+Enter` open a terminal
* `$mod+e` open dmenu (text based program launcher)
* `$mod+shift+p` restart i3 in place
* `$mod+shift+j` reload config file
* `$mod+shift+dead_acute` kill window (does normal close if supported)
* `$mod+shift+period` exit i3 (logs you out of your X session)

## Workspaces
* `$mod+<number 1-0>` change to workspace _number_
* `$mod+Shift+<number 1-0>` move container to workspace _number_

## Windows
* `$mod+<direction key>` change window focus to _direction_
* `$mod+<h,t,n or s>` change window focus
* `$mod+Shift+<direction key>` move focused window to _direction_
* `$mod+Shift+<h,t,n or s>` move focused window
* `$mod+o` stacked layout
* `$mod+comma` tabbed layout
* `$mod+period` vertical and horizontal layout (switches to and between them)
* `$mod+d` horizontal split
* `$mod+k` vertical split
* `$mod+u` toggle fullscreen
* `$mod+Shift+space` toggle floating
* `$mod+space` toggle focus between tiling and floating windows
* `$mod+a` focus on the parent window

## Resize window
* `$mon+p` enter resize mode
  * `<direction key>` resize window in _direction_
  * `h` resize shrink width 10 px or 10 ppt
  * `t` resize grow height 10 px or 10 ppt
  * `n` resize shrink height 10 px or 10 ppt
  * `s` resize grow width 10 px or 10 ppt
* `Enter` or `Escape` exit resize mode

## Resources
- [Jeff Paine gist][jeffpaine]

[jeffpaine]: https://gist.github.com/JeffPaine/cbdf57c3721546b14113#file-i3-cheat-sheet-md
