---
layout: post
title:  "Linux shell cheat sheet"
date:   2020-07-10 08:00:00 +0200
tags:   
  - ubuntu
  - linux
  - bash
  - terminal
---
*Useful commands to use in the shell. They should be available on any Linux shell.*

## Commands
To write a new command using your preferred editor, press `ctrl`+`x`+`e` from the shell. Useful for creating multiline commands.

Edit the last command in your preferred editor.
```console
$ fc
```

Re-execute the last command. In the second version as `sudo`.
```console
$ !!
$ sudo !!
```

Create a temporary file system in RAM. Gone after restart or unmount, useful for fast IO or confidential data.
```console
$ mkdir -p /mnt/ram
$ mount -t tmpfs tmpfs /mnt/ram -o size=8192M
```

Write files to RAM. As above, gone after restart.
```console
$ cd /dev/shm
$ echo "Any kind of data" > file
```

Networking
```console
$ curl ifconfig.me              # Show your public IP address
$ nmap -sP 192.168.1.1/24       # Show the IPs of all devices connected to the router (192.168.1.1/24 is the gateway/mask)
$ ip addr show                  # Show information of all local network devices
$ ss -tunlp                     # Show all open ports on the system and the executable
$ iperf3 -s -f m                # Run the server for a network performance test
$ iperf3 -c 192.168.1.16 -f m   # Run a network performance test from a client machine
$ ssh -X user@domain            # Run ssh with X11 forwarding
$ rfkill list                   # List all wireless devices (incl Bluetooth)
$ hcitool dev                   # List all local Bluetooth devices and their address
```

Services and processes
```console
$ service --status-all          # Show the status of all known services
$ systemctl status mpd          # Show the status of a specific service
$ systemctl stop mpd            # Stop a service
$ systemctl disable mpd         # Disable a service
$ systemctl suspend             # Suspend the system
$ pgrep mpd                     # Find the PID of an executable
$ pkill mpd                     # Kill an executable by name
$ killall <name>                # Kill all processes by name
$ ps -Ao pid,tt,user,fname,tmout,f,wchan # Show all processes
$ ps -e
$ ps -eF
$ ps -o pid,user,%mem,command ax | sort -b -k3 -r  # Memory usage for each process
$ sudo pmap <PID>               # Memory usage per loaded library
```

Monitoring
```console
$ upower -e                     # List all power devices
$ upower -d                     # Show all power information
$ upower -i /org/freedesktop/UPower/devices/battery_BAT1 | grep -E "state|to\ full|percentage"
$ cat /sys/class/power_supply/BAT1/capacity
$ cat /sys/class/power_supply/BAT1/status
$ lspci -v                      # List all PCI devices
$ lspci -nnk                    # List PCI devices with kernel module
$ aplay -l                      # List audio devices
$ lsmod                         # Show loaded kernel modules
```

Messaging
```console
$ notify-send -i face-wink Hello
$ zenity --title "Attention" --warning --text "Check your mail... \n\n\nSYS"
$ xmessage  "Are you sure you want to shutdown? " -buttons yes,no
```

Misc
```console
$ uname -a                      # Show full distro info
$ cat /etc/anacrontab           # View anacron jobs
$ systemctl list-timers --all   # List system service timers
$ systemctl list-sockets --all  # List system service sockets
$ systemctl list-jobs           # List running jobs
$ echo "Long output" | vim -    # Pipe command output to vim
$ env                           # Output info about the environment, like variables
$ tree -L 2 <dir>               # Output dir contents as tree with a depth of 2
$ expr 1 != 2                   # Evaluate expressions
$ echo "3.3 + 7.9 + 6.15" | bc  # Basic calculator
$ xrandr --current              # Show connected screens
$ xdg-open <file>               # Use default application for file type to open file
$ fc-list                       # Show all fonts on the system and their path
$ pdfunite a1.pdf b1.pdf c.pdf  # Join PDF documents
$ cat /etc/systemd/logind.conf  # Login settings
```

Java
```console
$ jps -l                        # Show running Java processes and their main class
$ javap <class file>            # Disassemble a Java class file 
$ /usr/lib/jvm/default-java/bin/keytool -list  $ List the keys the default keystore of the given JVM
```

SSL
```console
$ openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 # Create a new key and certificate
$ openssl x509 -noout -text -in cert.pem # Get info on the given certificate
$ echo | openssl s_client -connect pbrandwijk.com:443 | openssl x509 -noout -text # Get SSL info of given domain
$ ssh-keygen -t ed25519 -C "<user email address>" -f ~/.ssh/git_id_ed25519 # Generate an ssh keypair in .ssh
```
