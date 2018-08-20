---
layout: post
title:  "Generating random numbers"
date:   2018-05-19 02:25:00 +0200
tags:   linux shell random
---
*In cases where you want to get a (pseudo) random number. This is useful for example for
generating a password or when writing a game that needs random input.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Getting a random number from the command line
The `/dev/random` file generates random output for everything you read from it.
In the followig example I use `head` to read six characters from it and pass the output
to `base64`, which turns it into more readable text:

```console
$ head -c 6 /dev/random | base64
F0Xm0bf8
```

Alternatively, if you want the output in hexadecimal format, you can use `hexdump` like so:

```console
$ head -c 32 /dev/random | hexdump -x
0000000    2372    6738    9dd8    723e    7401    bbd3    50dd    bb8e
0000010    d8db    6954    e691    448d    0055    5aae    e257    2788
```


## Resources
- [Wikipedia: /dev/random][wikipedia]

[wikipedia]: https://en.wikipedia.org/wiki//dev/random
