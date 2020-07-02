---
layout: post
title:  "Fixing sound card issue after installing Ubuntu 20.04"
date:   2018-10-11 23:30:00 +0200
tags:   
  - linux
  - ubuntu
  - driver
  - nvidia
  - sound card
---
*After installing Ubuntu 20.04 my sound card was not detected anymore, in the system settings only Dummy output showed up. Here is what I did to solve the issue.*

## Preliminaries
I'm using Ubuntu 20.04 as my OS on an HP Pavilion laptop with an NVIDIA GeForce GTX 1050 graphics card.

## Issue
After upgrading Ubuntu from 18.04 to 20.04, the sound does not work anymore. This is a frequent issue on fresh installations, and there are many web pages with suggestions on reloading `alsa`, installing `pulseaudio` and many more. In my case, none of those solved the issue. Running `aplay -l` shows that no sound card is detected.

## Solution
When one post suggested to run `lspci -nnk | grep -A2 Audio` to confirm that I am running an intel sound driver, I found out that I actually was not. Instead of the kernel module snd_hda_intel, I was running sof-audio-pci. The solution was to disable the sof driver so that the system defaults to the intel one.

```console
$ sudo gedit /etc/default/grub
```

In this file, change `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash"` to `GRUB_CMDLINE_LINUX_DEFAULT="quiet splash snd_hda_intel.dmic_detect=0"` Then do:

```console
$ sudo update-grub
```
and restart your system.

## Resources
- [Fix no sound dummy output][linuxuprising]
- [Sound card not detected][askubuntu]

[askubuntu]: https://askubuntu.com/questions/1243369/sound-card-not-detected-ubuntu-20-04-sof-audio-pci
[linuxuprising]: https://www.linuxuprising.com/2018/06/fix-no-sound-dummy-output-issue-in.html