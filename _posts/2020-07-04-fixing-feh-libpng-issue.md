---
layout: post
title:  "Fixing feh libpng issue"
date:   2020-07-04 09:30:00 +0200
tags:   
  - ubuntu
  - feh
  - i3
  - wallpaper
  - png
---
*Using `feh` can give an ugly error when your PNG files are not fully compliant. Here is how to solve it.*

## Preliminaries
I'm using Ubuntu 20.04 with all relevant software for this post installed via `apt`.

## Issue
I use `feh` to set my background wallpaper for `i3` sessions. Sometimes this gives the following error: 
```text
libpng warning: iCCP: known incorrect sRGB profile*
```
This happens when `feh` tries to load an PNG image using the 1.6 version of `libpng`, which treats this warning as an error. 

## Solution
The way to solve it is to clean up the violating part in the PNG file. You can do this via the console using tools from ImageMagick.

```console
$ cd /path/to/wallpapers           # Go to the wallpapers folder
$ convert -list format | grep PNG  # Confirm that ImageMagick uses libpng16
$ convert in.png out.png           # Create a new file with the cleaned up image
$ mogrify *.png                    # Overwrite all .png files with the cleaned up version
```

To check which PNG files violate the rules you can install and run `pngcrush`:
```console
$ sudo apt install pngcrush
$ pngcrush -n -q *.png
```

## Resources
- [libpng warning: iCCP: known incorrect sRGB profile][stackoverflow]

[stackoverflow]: https://stackoverflow.com/questions/22745076/libpng-warning-iccp-known-incorrect-srgb-profile

