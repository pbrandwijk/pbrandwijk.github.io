---
layout: post
title:  "Shredding files with sensitive data"
date:   2018-05-18 13:25:00 +0200
categories: linux security shred gpg
---
*In cases where you want to be sure that no trace of a file remains on your hard drive or in swap memory, you can `shred` or `srm` a file instead of the normal `rm`. Shredding a file means it gets overwritten several times with random data, so no trace of the original file remains.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Shredding a file with sensitive data
The following example shows how to shred a file on your hard drive:
```console
$ echo This is sensitive data > data.txt
$ shred -u data.txt
```

Optionally, put the following in `~/.bash_aliases`. The added options assure that the file is overwritten 10 times with random data and with zeros the last time.
```
# Shorthand for securely shredding files and deleting them
alias shred='shred -uz --iterations=10'
```

You can also install `srm`, which is a program with similar functionality:
```console
$ sudo apt install secure-delete
$ echo This is sensitive data > data.txt
$ srm data.txt
```

## Resources
- [Wikipedia: Shred_(Unix)][wikipedia]
- [Establish your online identity using GnuPG][saminiir]

[wikipedia]: https://en.wikipedia.org/wiki/Shred_(Unix)
[saminiir]: http://www.saminiir.com/establish-cryptographic-identity-using-gnupg/
