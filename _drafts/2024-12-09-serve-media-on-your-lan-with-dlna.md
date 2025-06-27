---
layout:   post
title:    "Serve media on your LAN with DLNA"
date:     2024-12-09 22:30:00 +0200
tags:
 - dlna
 - linux
 - minidlna
 - ubuntu
---
*I want a simple way to host media from a system in my network to other systems, most notably my TV or Bluray device.*

## Introduction

For a long time I thought you either needs a sort of "full feature" media server to host media on your network, or you need a lot of networking, tunneling, etc to get some results. But recently I discovered DLNA, which allows for a simple solution based on an open protocol and open source implementation named `minidlna`.



Keep in mind that by installing `minidlna` there is immediately a root daemon service created with its config in `/etc/minidlna.conf` and files in `/var/lib/minidlna`.

```console
sudo apt install minidlna
sudo service minidlna stop
sudo update-rc.d minidlna disable
```


## Resources
- [How to mount smb share on ubuntu 18.04][askubuntu]
- [How to Mount Windows Share on Linux using CIFS][linuxize]
- [Linux NFS mount entry in fstab with example][linuxopsys]
- [How to set up an NFS mount on Ubuntu][digitalocean]

[askubuntu]: https://askubuntu.com/questions/1050460/how-to-mount-smb-share-on-ubuntu-18-04
[linuxize]: https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
[linuxopsys]: https://linuxopsys.com/topics/linux-nfs-mount-entry-in-fstab-with-example
[digitalocean]: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04
