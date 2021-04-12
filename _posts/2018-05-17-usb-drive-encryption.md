---
layout: post
title:  "USB drive encryption"
date:   2018-05-17 19:00:00 +0200
categories: encryption luks
---
*On a recent Ubuntu distribution it is quite straightforward to encrypt a USB drive. To do this, you need to reformat the drive using the `LUKS` file system.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Format the drive using Disk Utility
Plug the USB drive into your system. Backup any data on it that you want to keep, because the whole disk will be erased. Open the standard application Disks. Now select the USB drive. Remove the current partition and replace it with a new one. Choose the ext4 format with LUKS and choose a password.

After creating the partition you now have an encrypted USB drive. Keep in mind that this drive can only be used on operating systems that support LUKS. That means that currently you can use it only on Linux.

## Unlocking and mounting via command line
You can use the following commands to manage the encrypted USB from the command line.

```console
$ udisksctl unlock -b /dev/<device file>
$ udisksctl mount -b /dev/mapper/<device id>
$ udisksctl unmount -b /dev/<device generated file>
$ udisksctl lock -b /dev/<device file>
$ udisksctl power-off -b /dev/<device file>
```

## Finding the device file
There are many files under `/dev`, but your encrypted USB drive partition is likely called something like `sdb2`. The following commands can help you to find the correct device file:

```console
$ sudo lsblk -e7     # The e7 option filters out loop devices
$ sudo fdisk -l
```

After unlocking, you will get an output like `Unlocked /dev/sdb2 as /dev/dm-0`. Remember this `dm-0` file, as you will need it to unmount the device later. Also, the device id needed to mount the device via `/dev/mapper` is not given. It will be something like `luks-` followed by a long code.

## Resources
- GUI: [How to encrypt external devices?][askubuntu]
- Command line: [Establish your online identity using GnuPG][saminiir]
- [Mount encrypted volumes from command line][askubuntu2]
- [Safely remove using command line][askubuntu3]
- [List disks on Ubuntu][linuxhint]

[askubuntu]: https://askubuntu.com/questions/500981/how-to-encrypt-external-devices
[askubuntu2]: https://askubuntu.com/questions/63594/mount-encrypted-volumes-from-command-line
[askubuntu3]: https://askubuntu.com/questions/381108/safely-remove-using-command-line
[saminiir]: http://www.saminiir.com/establish-cryptographic-identity-using-gnupg/
[linuxhint]: https://linuxhint.com/list_disks_ubuntu/
