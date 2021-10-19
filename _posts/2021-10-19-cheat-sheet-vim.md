---
layout:   post
title:    Cheat sheet Vim
date:     2021-10-19 22:00:00 +0200
tags:     
 - ubuntu
 - vim
 - cheat sheet
---
*My personal cheat sheet for using the Vim editor. Adapted for the `Dvorak` keyboard layout.*

## Normal mode

### Motions
* `w` next word
* `b` beginning of word
* `-` end of line
* `_` beginning of line
* `h` previous char
* `s` next char
* `t` next line
* `n` previous line
* `gg` start of file
* `G` end of file
* `Ctrl+o` previous cursor position
* `Ctrl+i` next cursor position

### Actions
* `.` repeat last sequence
* `r` replace one char
* `R` replace multiple chars
* `yy` copy line
* `p` paste below line
* `P` paste above line
* `c` change until end of motion
* `C` change until end of line

### Commands
* `:w` write (save) the file, but don't exit
* `:wq`, `:x` write (save) and quit
* `:q` quit (fails if there are unsaved changes)
* `:q!` quit and throw away unsaved changes

