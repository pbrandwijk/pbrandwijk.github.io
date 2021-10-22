---
layout:   post
title:    Replay terminal sessions
date:     2021-10-22 20:20:00 +0200
tags:   
 - script  
 - scriptreplay
 - unix
 - terminal
 - shell
---
*Showing you how to record and replay a terminal session using the common utilities `script` and `scriptreplay`.*

## Recording a terminal session
Most likely you will have the `script` utility installed already. Start recording like this (pick any file names you like):

```console
$ script --timing=timing.txt script.txt
```
Now use your terminal as normally to execute the commands you want to record. When done, hit <kbd><strong>Ctrl+D</strong></kbd> or give the command `exit` as final command.

## Replaying the session
Once recorded, replaying the session with `scriptreplay` is very similar:

```console
$ scriptreplay --timing=timing.txt script.txt
```
Keep in mind that this does not actually execute the commands it is just a visual representation of the session you had. Both the commands and output are fixed and do not change anything on your system anymore.

## Example
![Scriptreplay](/images/gifs/scriptreplay.gif){:class="img-responsive"}

## Resources
- [How to record and replay linux terminal sessions][tecmint]

[tecmint]: https://www.tecmint.com/record-and-replay-linux-terminal-session-commands-using-script/
