---
layout: post
title:  "Installing NVIDIA graphics driver"
date:   2018-10-11 23:30:00 +0200
tags:   
  - linux
  - ubuntu
  - driver
  - nvidia
  - graphics card
---
*What I did to solve an issue with my graphics driver.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS on an HP Pavilion laptop with an NVIDIA GeForce GTX 1050 graphics card.

## Issue
When installing Ubuntu screen freezes very quickly after boot. Both from USB and later from hard drive. A quick workaround was to press `e` in GRUB2 boot menu and add `nomodeset` after the `splash` option on the line that says `linux`. This had to be repeated at every boot.

## Solution
The correct driver for the graphics card was missing. I looked up the correct driver at the NVIDIA web site, in this case driver number 390, and executed in terminal:
```console
$ sudo apt install nvidia-driver-390
$ nvidia-settings
```

The command `nvidia-settings` will give an error and say driver is not loaded if you do this immediately after install. For this to work you must first reboot the system. Then the driver will be loaded and the issue should be solved.
