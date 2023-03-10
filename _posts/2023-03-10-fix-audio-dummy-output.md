---
layout:   post
title:    Fix audio dummy output
date:     2023-03-10 23:00:00 +0200
tags:     
 - ubuntu
 - audio
 - pulseaudio
---
*Fix for an issue I had on my laptop where audio output and mic input did not work.*

## Situation
I had this on Ubuntu 22.04, with pulseaudio. The on board speakers and mic did not work. System settings reported "dummy output".

## Solution
Stop pulseaudio with `pulseaudio -k`.

Add the following line to end of the file `/etc/modprobe.d/alsa-base.conf`:
```
options snd_hda_intel dmic_detect=0
```

Restart the system.
