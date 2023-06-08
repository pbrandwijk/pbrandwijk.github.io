---
layout:   post
title:    "Mount NAS share with nfs or cifs"
date:     2023-06-09 00:30:00 +0200
tags:     
 - linux
 - NAS
 - nfs
 - cifs
 - smb
---
*Mount a shared drive from your Network Attached Storage (NAS) device on your linux system*

## Preliminaries
I'm using Ubuntu 23.04 as my OS. The NAS is connected to the LAN and can be reached via its IP address.

## NFS
The `nfs` protocol is the native protocol for file sharing on unix. A possible downside is that authentication is done based on IP address, and not via a user account as `cifs` has. If that is not an issue and `nfs` is supported, then this should be the preferred protocol.

#### Enable NFS on the NAS
Some NAS devices do not enable `nfs` by default, so you may have to enable it first. You likely then also have to enable it on the specific share that you want to use it on. Here there also will be an option to define which IP addresses should be granted access and whether or not write access is allowed.

#### Install required libraries on client
Install the following package:
```console
$ sudo apt install nfs-common
```

#### Create the folder for the mount
Create the folder that the share should be mounted to and make sure it is owned by yourself and not root:
```console
$ mkdir /mnt/nfsshare
```

#### Manually mount the network share
Check that everything works by creating the mount manually:
```console
$ sudo mount <host ip>:/nfs/share /mnt/nfsshare
```

#### Add the mount to the fstab
If everything works and you would like to automatically mount at startup, add the mount to the fstab:
```console
$ sudoedit /etc/fstab
```
```
<host ip>:/nfs/share            /mnt/nfsshare  nfs   rw,hard,intr,noexec,nosuid,rsize=8192,wsize=8192,timeo=14      0       0
```


## CIFS
The `cifs` protocol is geared towards Windows systems, but can be used by unix too. It is the most widely supported protocol and as mentioned above, authentication is done based on username and password.

#### Create user account on the NAS
Make sure that you have a user account set up on the host to access the share. You need the username, password and the domain name.

#### Install required libraries on client
To be able to use the `cifs` protocol, install the following package:
```console
$ sudo apt install cifs-utils
```

#### Create the folder for the mount
Create the folder that the share should be mounted to and make sure it is owned by yourself and not root:
```console
$ mkdir /mnt/cifsshare
```

### Manually mount the network share
Check that everything works by creating the mount manually:
```console
$ sudo mount -t cifs -o username=<user>,password=<password>,domain=<domain name>.rw,vers=3.0 //<host ip>/share /mnt/cifsshare
```

#### Add the mount to the fstab
If everything works and you would like to automatically mount at startup, you can add the mount to the fstab. For this you do need to create a file with the user credentials first:
```console
$ sudoedit /etc/nas-credentials
$ sudo chown root: /etc/nas-credentials
$ sudo chmod 600 /etc/nas-credentials
```
Content of `nas-credentials`:
```
username=<user>
password=<password>
domain=<domain name>
```

After this, you can add the share to `fstab`:
```console
$ sudoedit /etc/fstab
```
```
//<host ip>/share               /mnt/cifsshare  cifs   credentials=/etc/mycloud-credentials,file_mode=0755,dir_mode=0755,uid=<user>,gid=<user>     0       0
```

## Unmounting a network share
```console
$ sudo umount /mnt/share
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
