---
layout:   post
title:    "Version control for STEP code"
date:     2024-10-18 22:50:00 +0200
tags:
 - Stibo STEP
 - JavaScript
 - version control
 - git
---
*STEP customizations written in JavaScript are challenging to bring under version control. The scripts are not stand-alone code, but are tightly knitted to the STEP configuration items, which are managed by STEP.*

## Introduction

Coming to develop code for STEP as a software engineer is pain. There, I said it.

STEP offers elementary version control natively in the application in the form of revisions of a configuration item. This is however not really suitable for the requirements of version control for a code base.

## Requirements of version control

Some requirements for version control in the context of STEP development:

- Connect changes to code to requirements documentation
- Reproduce when changes were introduced
- Allow simultaneous development of changes on the same script

## Where can the code be found?

JavaScript code in STEP can be written as part of a Business Rule. In the case of a Business Action they can be a JavaScript operation. In the case of a Business Condition they can be a .... In the case of a Business Function they can be a .... For all three of these JavaScript can also be used for the Applies if. Lastly for a Business Library, JavaScript can be used as ....

## How to structure it?


## Resources
- [How to mount smb share on ubuntu 18.04][askubuntu]
- [How to Mount Windows Share on Linux using CIFS][linuxize]
- [Linux NFS mount entry in fstab with example][linuxopsys]
- [How to set up an NFS mount on Ubuntu][digitalocean]

[askubuntu]: https://askubuntu.com/questions/1050460/how-to-mount-smb-share-on-ubuntu-18-04
[linuxize]: https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
[linuxopsys]: https://linuxopsys.com/topics/linux-nfs-mount-entry-in-fstab-with-example
[digitalocean]: https://www.digitalocean.com/community/tutorials/how-to-set-up-an-nfs-mount-on-ubuntu-20-04
