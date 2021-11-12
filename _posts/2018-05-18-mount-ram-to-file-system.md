---
layout: post
title:  "Mount RAM to file system"
date:   2018-05-18 00:50:00 +0200
tags: linux security gpg mount
---
*In cases where you want to be sure that no trace of a file remains on your hard drive or in swap memory, you can temporarily mount a part of RAM to your file system and use that while working on the file. After the removal of the mount point, the information will not persist.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Creating a mount point for RAM
Use the following example commands to set up a mount point for a portion of your RAM:
```console
$ mkdir /tmp/gpg
$ sudo mount -t ramfs -o size=1M ramfs /tmp/gpg
$ sudo chown $(logname):$(logname) /tmp/gpg
```

In the example above, a chunk of 1MB of RAM is mounted to `/tmp/gpg`. Anything written to this directory will only persist as long as RAM is active.

## Example usage: exporting a private GPG key
Here I give an example of using the mounted RAM to export a GPG private key. The benefit of using a RAM mount is that we can be sure that no trace of the private key will linger around in memory after removing the mount. On a hard drive, even though you delete a file, the actual bytes may still be present, which in this case exposes your private GPG key to exploits.

Export the private key for `username@domain.com` to `/tmp/gpg/subkeys`:
```console
$ gpg --export-secret-subkeys username@domain.com > /tmp/gpg/subkeys
```

Now you can copy the file `/tmp/gpg/subkeys` to a safe location, like an encrypted USB. After safely storing the file, delete the original signing subkey from the keypair in our keyring and clean up the temporary file:
```console
$ gpg --delete-secret-key username@domain.com
$ sudo umount /tmp/gpg
$ rmdir /tmp/gpg
```

If at some point you need the private key again you can recreate the RAM mount like before, copy the `subkeys` file back to it from the USB and re-import the key like this:
```console
$ gpg --import /tmp/gpg/subkeys
```

## Resources
- [Creating the perfect GPG keypair][alexcabal]
- [Ramfs][debian]

[alexcabal]: https://alexcabal.com/creating-the-perfect-gpg-keypair/
[debian]: https://wiki.debian.org/ramfs
