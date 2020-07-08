---
layout: post
title:  "Managing passwords in GNOME keyring via command line"
date:   2020-07-06 08:00:00 +0200
tags:   
  - ubuntu
  - nmcli
  - openvpn
  - vpn
---
*By storing passwords in the GNOME keyring they are protected and automatically unlocked when you log in. Here is how to manage them via the command line.*

## Preliminaries
I'm using Ubuntu 20.04 with all relevant software for this post installed via `apt`.

## Issue
Sometimes you may need to use some confidential information in a public script and you need a way to protect that information. In this case you can leverage the password protection offered by the GNOME keyring, but you do need a way to access that functionality over the command line.

## Solution
Install the `libsecret-tools` package with the needed commands:
```console
$ sudo apt install libsecret-tools
```
Store the password, or actually any kind of string that you want to protect. The `label` parameter is only used for display purposes. The attribute and value are what you use to retrieve the password.
```console
$ secret-tool store --label='Readable name for password' <attribute> <value>
```
To retrieve the password, use the following:
```console
$ secret-tool lookup <attribute> <value>
```


To have a GUI overview of your keyring, you can use Passwords and Keys that is installed by default on Ubuntu.

See [here][askubuntu] an example of how to use this set up to protect your VPN password.

## Resources
- [Provide password to `nmcli con up` in terminal][askubuntu]

[askubuntu]: https://askubuntu.com/questions/774908/provide-password-to-nmcli-con-up-in-terminal-14-04#774926
