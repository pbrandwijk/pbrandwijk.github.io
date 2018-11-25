---
layout:   post
title:    "Reducing blue light with Redshift"
date:     2018-11-25 18:30:00 +0200
tags:     redshift health
featured_article:   false
---
*Blue light at night is not good for your sleep pattern and may also be hurting your eyes. In this post I explain the usage of a tool that allows you to change the color temperature of your screen over the command line.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Installation
To install Redshift, run the following command:
```console
$ sudo apt install redshift
```

There is also a GTK that you can install with the package `redshift-gtk`, but I got an error while trying to start that application and didn't investigate it further.

## Usage
To use Redshift, you need to provide it with the GPS coordinates of your location, so that the program can determine whether it is night or day. In the example below I have given the coordiates `- 52.0:5.1`, which is near the city of Utrecht in The Netherlands. To find the coordinates of your location you can use [GPS coordinates][coordinates]. The option `-t 5700:3600` specifies the color temperature between night and day.
```console
$ redshift -l 52.0:5.1 -t 5700:3600 -g 0.8 -m randr -v
```

To run Redshift in the background, you can use the following command:
```console
$ redshift -l 52.0:5.1 -t 5700:3600 -g 0.8 -m randr &
```

To print Redshift's own help message, use:
```console
$ redshift -h
```

## Resources
- [Redshift][redshift]
- [GPS coordinates][coordinates]

[redshift]: http://jonls.dk/redshift/
[coordinates]: https://www.gps-coordinates.net/
