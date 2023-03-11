---
layout:   post
title:    Fix ExpressVPN settings with NetworkManager
date:     2023-03-11 22:00:00 +0200
tags:     
 - ubuntu
 - vpn
 - networkmanager
 - openvpn
---
*Fix for an issue I had on my fresh Ubuntu 22.10 installation where the VPN set up did not work.*

## Situation
In my post {% post_url 2020-07-05-using-nmcli-to-connect-to-vpn %} I explain how to set up your VPN with `nmcli` using a `ovpn` file. After I upgraded to Ubuntu 22.10, this approach did not seem to work anymore. I could set up the VPN connection, but as soon I attempt to connect, the connection would fail with an unspecified error.

## Solution
First attempt was to re-read the instructions given by ExpressVPN for manual setup on Ubuntu. Turns out that after importing the `ovpn` file, there are still some adjustments to make, like setting the Gateway port and the Data compression. Also I had to change the TLS mode to TLS-Auth and set the key file to a file provided by ExpressVPN. After following these instructions it still did not work and it still did not provide any useful error.

Then I tried to connect to the VPN directly via `openvpn` instead of NetworkManager's `nmcli`, I got the following error:
```console
$ openvpn --config <ovpn file>
Options error: Unrecognized option or missing or extra parameter(s) in my.ovpn:22: keysize (2.6_git)
```
After searching online I found that this error is given because the config file defines a property `keysize`, which is removed since OpenVPN 2.6.
```console
$ sudo cat /etc/NetworkManager/system-connections/<vpn name>.nmconnection
...
keysize 256
...
```
There are no longer any cyphers that use this property, so it has been removed. You can either remove it directly in the config file, remove it from the `ovpn` file before importing, or open the GUI of NetworkManager (Settings -> Network) and uncheck the setting under Identity -> Advanced.

After this change I was able to connect to the VPN. The keysize property did not cause issues on my Ubuntu 22.04 installation, because that uses OpenVPN 2.5.5 where this property still exists. What I do not understand is why the VPN worked perfectly on 22.04 without the additional settings as provided by ExpressVPN.

## Resources
- [OpenVPN giving an error][superuser]
- [Deprecated Options in OpenVPN][openvpn]

[superuser]: https://superuser.com/questions/1385043/openvpn-giving-an-error-options-error-unrecognized-option-or-missing-or-extra
[openvpn]: https://community.openvpn.net/openvpn/wiki/DeprecatedOptions#a--keysize
