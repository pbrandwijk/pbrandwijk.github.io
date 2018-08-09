---
layout: post
title:  "Find largest folders in file system"
date:   2018-05-20 16:50:00 +0200
tags: linux bash du
---
*In cases where you want to see which folders on your file system take up the most space. This is interesting information when for example you want to clean up some storage space.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Commands to find the largest folders on your file system
Find the top 15 largest folders in my home dir:
```console
$ du -am /home/$USER | sort -n -r | head -n 15
```

Only search in hidden folders:
```console
$ du -am /home/$USER/.??* | sort -n -r | head -n 15
```

Exclude any folder with "thunderbird" in its path:
```console
$ du -am /home/$USER/.??* | grep -v "thunderbird" | sort -n -r | head -n 15
```

## Resources
- [Bash shell display only hidden dot files][cyber]
- [Bashref][gnu]

[cyber]: https://www.cyberciti.biz/faq/bash-shell-display-only-hidden-dot-files/
[gnu]: https://www.gnu.org/software/bash/manual/bashref.html#Pattern-Matching
