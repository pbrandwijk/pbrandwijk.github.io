---
layout: post
title:  "Using nmcli to connect to VPN"
date:   2020-07-05 23:00:00 +0200
tags:   
  - ubuntu
  - nmcli
  - openvpn
  - vpn
---
*Ubuntu uses NetworkManager to handle your network connections, including any VPNs. This post explains how to set it up using the command line.*

## Preliminaries
I'm using Ubuntu 20.04 with all relevant software for this post installed via `apt`. The VPN client used is `openvpn` via `nmcli`.

## Issue
Set up VPN connections via the command line so that connections can be scripted.

## Solution
Download the `.ovpn` files you need from your VPN provider. Username and password will be missing in this config. Get them from your account and note them down. Below here they will be referred to as `VPNPASS` and `VPNUSER`.

Create a private file with your password:
```console
$ echo "vpn.secrets.password:VPNPASS" > /my/vpn/password/file
$ chmod 600 /my/vpn/password/file
```
Import the VPN configuration and add your username to it:
```console
$ sudo nmcli connection import type openvpn file my/vpn/VPNID.ovpn
$ sudo nmcli con mod VPNID vpn.user-name VPNUSER
```
Then you need to specify the password file when starting the VPN (notice `sudo` is not needed here):
```console
$ nmcli con up id usa-newyork passwd-file /my/vpn/password/file
```
Alternatively, you can set the password in the same way as the username:
```console
$ sudo nmcli con mod VPNID vpn.secrets "password=VPNPASS"
```
Another way to handle the password is by using the GNOME keyring. See [this post]({% post_url 2020-07-06-managing-passwords-in-gnome-keyring-via-command-line %}) for details on using the GNOME keyring on the command line and [here](https://askubuntu.com/a/1203627) for how to set this up with `nmcli`.

Some extra commands that may be useful:
```console
$ nmcli con                          # Get an overview of all available VPNs via NetworkManager
$ sudo cat /etc/NetworkManager/system-connections/VPNID.nmconnection  # Review the configuration
$ nmcli con down id VPNID            # Deactivate the VPN
$ nmcli c show --active | grep vpn   # See if any VPN connections are active
```

See [this post]({% post_url 2023-03-11-fix-expressvpn-settings-with-networkmanager %}) for an update on setting up the VPN on Ubuntu 22.10.


## Resources
- [How to save vpn passwords with networkmanger][askubuntu1]
- [How can I get networkmanager to autoconnect][askubuntu2]
- [Provide password to nmcli con up in terminal][askubuntu3]
- [Modifying username of VPN connection via nmcli][redhat]

[askubuntu1]: https://askubuntu.com/questions/444866/how-to-save-vpn-passwords-with-networkmanger-for-nmcli#556069
[askubuntu2]: https://askubuntu.com/questions/231126/how-can-i-get-networkmanager-to-autoconnect-to-a-openconnect-vpn-via-nmcli-witho
[askubuntu3]: https://askubuntu.com/questions/774908/provide-password-to-nmcli-con-up-in-terminal-14-04#774926
[redhat]: https://bugzilla.redhat.com/show_bug.cgi?id=1060460
