---
layout:   post
title:    "Only allow internet access via VPN"
date:     2023-03-13 12:00:00 +0200
tags:     
 - linux
 - ufw
 - vpn
 - nmcli
 - security
---
*Describes how to make sure that internet traffic always goes through a VPN. If the VPN is down, there is no internet.*

## Preliminaries
I'm using Ubuntu 22.10 as my OS. The firewall used is the default `ufw`, see [this post]({% post_url 2020-07-03-my-initial-ubuntu-setup %}) to enable it. The VPN connections are managed via NetworkManager (`nmcli`), see [this post]({% post_url 2023-03-11-fix-expressvpn-settings-with-networkmanager %}) for details.

## Set up auto connect to VPN on startup
To automatically connect to a VPN on system startup, you have to set this on the Ethernet and/or Wi-Fi connection. You can do this by running `nm-connection-editor` (GUI) and then editing the settings of your Ethernet or Wi-Fi connection. Go to the tab General and check the `Automatically connect to VPN` box and pick a VPN connection.

## Set up auto reconnect for VPN
In case the VPN connection is dropped for some reason, you'll want to automatically reconnect. The setting `vpn.persistent` is by default set to `no`. You cannot set it via the NetworkManager GUI, so you have to set it via the command line with `nmcli`.
```console
$ sudo nmcli con mod <vpn connection name> connection.autoconnect-retries 0
$ sudo nmcli con mod <vpn connection name> vpn.persistent yes
$ sudo cat /etc/NetworkManager/system-connections/<vpn connection name>.nmconnection # Review changes
```
The setting `autoconnect-retries 0` means to retry indefinitely.

## Set up `ufw` rules
First allow incoming and outgoing connections on your LAN.
```console
$ ip a s | grep inet # Check the IP subnet address
$ sudo ufw allow in 192.168.1.0/24 # Change IP to your situation
$ sudo ufw allow out 192.168.1.0/24 # Change IP to your situation
```

Then block all incoming and outgoing connections by default.
```console
$ sudo ufw default deny outgoing
$ sudo ufw default deny incoming
```

Then allow the outgoing traffic only on the VPN connection.
```console
$ sudo ufw allow out on tun0 from any to any
```

After this we need to allow outgoing traffic to the specific VPN gateway. To find its address and the port used, check the `ovpn` file or the config of NetworkManager.
```console
$ sudo cat /etc/NetworkManager/system-connections/<vpn connection name>.nmconnection | grep "remote="
$ cat <ovpn file> | grep "remote "
```

The `ufw` rule cannot handle DNS addresses, so if your config uses a DNS address, use a tool like `ping` to get the IP address. Keep in mind there is a risk that the IP address of the VPN gateway will change at some point. You'll then have to update the rule.
```console
$ ping <vpn gateway DNS address>
```

Then add the rule to `ufw`. Make sure the port given in the rule matches the one in your config. Change to port `443` and `proto tcp` if you use TCP instead of UDP.
```console
$ sudo ufw allow out to <vpn gateway ip address> port 1195 proto udp
```

You should now be able to connect to the VPN and if you are not connected then all internet traffic should be blocked. It may take a few seconds after adding a rule before it is active. Review the settings if needed.
```console
$ sudo ufw status numbered # Show the firewall rules with numbers
$ sudo ufw delete <n> # Delete a numbered rule
```

## Resources
- [Auto reconnecting VPN in Ubuntu][stackexchange]
- [Auto reconnect to VPN on disconnect?][askubuntu]
- [Connect to VPN Automatically on Ubuntu 20.04][kifarunix]

[stackexchange]: https://unix.stackexchange.com/questions/597650/auto-reconnecting-vpn-in-ubuntu-18-04
[askubuntu]: https://askubuntu.com/questions/679059/auto-reconnect-to-vpn-on-disconnect
[kifarunix]: https://kifarunix.com/connect-to-vpn-automatically-on-ubuntu-20-04-18-04/
