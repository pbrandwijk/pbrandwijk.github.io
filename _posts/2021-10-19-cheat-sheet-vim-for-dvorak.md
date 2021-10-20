---
layout:   post
title:    Cheat sheet Vim for Dvorak
date:     2021-10-19 22:00:00 +0200
tags:     
 - ubuntu
 - vim
 - cheat sheet
 - dvorak
---
*My personal cheat sheet for using the Vim editor. [Adapted](#dvorak-remap) for the `Dvorak` keyboard layout.*

## Normal mode

| Motion key | Effect |
| --- | --- |
| <kbd><strong>w</strong></kbd> | Next word |
| <kbd><strong>e</strong></kbd> | End of word or end of next word |
| <kbd><strong>b</strong></kbd> | Beginning of word or previous word |
| <kbd><strong>-</strong></kbd> | End of line |
| <kbd><strong>_</strong></kbd> | Beginning of line |
| <kbd><strong>h</strong></kbd> | Previous character |
| <kbd><strong>s</strong></kbd> | Next character |
| <kbd><strong>t</strong></kbd> | Next line |
| <kbd><strong>n</strong></kbd> | Previous line |
| <kbd><strong>/</strong></kbd> | Forward search |
| <kbd><strong>?</strong></kbd> | Backward search |
| <kbd><strong>l</strong></kbd> | Next search match |
| <kbd><strong>L</strong></kbd> | Previous search match |
| <kbd><strong>gg</strong></kbd> | Start of file |
| <kbd><strong>G</strong></kbd> | End of file |
| <kbd><strong>Num-G</strong></kbd> | Go to line number |
| <kbd><strong>Ctrl+o</strong></kbd> | Previous cursor position |
| <kbd><strong>Ctrl+i</strong></kbd> | Next cursor position |
| | |

| Action key | Effect |
| --- | --- |
| <kbd><strong>.</strong></kbd> | Repeat last sequence |
| <kbd><strong>x</strong></kbd> | Delete character under cursor |
| <kbd><strong>r</strong></kbd> | Replace character under cursor |
| <kbd><strong>R</strong></kbd> | Replace multiple characters |
| <kbd><strong>p</strong></kbd> | Paste below current line |
| <kbd><strong>P</strong></kbd> | Paste above current line |
| <kbd><strong>d-Motion</strong></kbd> | Delete until motion |
| <kbd><strong>y-Motion</strong></kbd> | Copy until motion |
| <kbd><strong>d-Motion</strong></kbd> | Delete until motion |
| <kbd><strong>c-Motion</strong></kbd> | Change until motion |
| <kbd><strong>C</strong></kbd> | Change until end of line |
| <kbd><strong>u</strong></kbd> | Undo last sequence |
| <kbd><strong>Ctrl+r</strong></kbd> | Redo last undone sequence |
| <kbd><strong>U</strong></kbd> | Undo all sequences on line |
| | |

### Commands
* `:w` write (save) the file, but don't exit
* `:wq`, `:x` write (save) and quit
* `:q` quit (fails if there are unsaved changes)
* `:q!` quit and throw away unsaved changes

## Dvorak remap

| Qwerty | Dvorak |
| --- | --- |
| <kbd><strong>h</strong></kbd> | <kbd><strong>h</strong></kbd> |
| <kbd><strong>j</strong></kbd> | <kbd><strong>t</strong></kbd> |
| <kbd><strong>k</strong></kbd> | <kbd><strong>n</strong></kbd> |
| <kbd><strong>l</strong></kbd> | <kbd><strong>s</strong></kbd> |
| <kbd><strong>t</strong></kbd> | <kbd><strong>j</strong></kbd> |
| <kbd><strong>n</strong></kbd> | <kbd><strong>l</strong></kbd> |
| <kbd><strong>s</strong></kbd> | <kbd><strong>k</strong></kbd> |
| <kbd><strong>T</strong></kbd> | <kbd><strong>J</strong></kbd> |
| <kbd><strong>N</strong></kbd> | <kbd><strong>L</strong></kbd> |
| <kbd><strong>S</strong></kbd> | <kbd><strong>K</strong></kbd> |
| <kbd><strong>J</strong></kbd> | <kbd><strong>T</strong></kbd> |
| <kbd><strong>L</strong></kbd> | <kbd><strong>N</strong></kbd> |
| <kbd><strong>K</strong></kbd> | <kbd><strong>S</strong></kbd> |
| <kbd><strong>$</strong></kbd> | <kbd><strong>-</strong></kbd> |
| <kbd><strong>^</strong></kbd> | <kbd><strong>_</strong></kbd> |
