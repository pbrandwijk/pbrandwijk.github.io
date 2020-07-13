---
layout: post
title:  "Linux shell cheat sheet"
date:   2020-07-10 08:00:00 +0200
tags:   
  - ubuntu
  - nmcli
  - openvpn
  - vpn
---
*Useful commands to use in the shell. They should be available on any Linux shell.*

## Commands
To write a new command using your preferred editor, press `ctrl`+`x`+`e` from the shell. Useful for creating multiline commands.

Edit the last command in your preferred editor.
```console
$ fc
```
Re-execute the last command. In the second version as `sudo`.
```console
$ !!
$ sudo !!
```
Create a temporary file system in RAM. Gone after restart or unmount, useful for fast IO or confidential data.
```console
$ mkdir -p /mnt/ram
$ mount -t tmpfs tmpfs /mnt/ram -o size=8192M
```
Write files to RAM. As above, gone after restart.
```console
$ cd /dev/shm
$ echo "Any kind of data" > file
```