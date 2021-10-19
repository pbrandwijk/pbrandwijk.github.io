---
layout: post
title:  "My initial Ubuntu setup"
date:   2020-07-03 18:00:00 +0200
tags:   
  - ubuntu
---
*I like to do a fresh install of my operating system every once in a while, as a cleaning up action. In this post I describe the actions I take to set up the system according to my preferences.*

## Preliminaries
I'm using Ubuntu 20.04 as my OS on an HP Pavilion laptop with an NVIDIA GeForce GTX 1050 graphics card. I'm assuming in this post that the installation was successful, and the system is operating as it should be.

## Firewall
The Uncomplicated Firewall `ufw` comes preinstalled, but is turned off by default. My configuration:
```console
$ sudo apt install gufw     # Install a GUI for ufw
$ sudo ufw allow ssh/tcp    # Allow connections over ssh
$ sudo ufw logging on       # Enable logging
$ sudo ufw enable           # Turn on ufw
$ sudo ufw status           # Print the status and active rules
```

## i3
I like using `i3` as my tiling window manager. To get a nice background wallpaper I also install `feh`.
```console
$ sudo apt install i3 feh
```
To get the wallpaper at the start up of a user session, make sure to add the `feh` command to `~/.profile`.
```shell
# Set the background wallpaper - intended for sessions with i3
feh --randomize --bg-fill ~/Pictures/wallpapers/*
```
Be aware that if there are any issues with loading the background you will get an ugly error at the start of your session. 

## Utilities
Install all the below utilities via `apt`:
```console
$ sudo apt install git curl vim zsh tmux pass gnuplot mc feh rxvt-unicode gnome-tweaks p7zip-full p7zip-rar httpie seahorse calcurse htop qalc
```

If you want to allow ssh connections, also install openssh-server:
```console
$ sudo apt install openssh-server
$ sudo vim /etc/ssh/ssh_config     # Set X11Forwarding yes and X11UseLocalhost no
$ systemctl restart sshd
```

## Dotfiles
I keep as many as possible configuration (dot) files in a separate folder managed with git version control. This is tidier and allows easy portability. For this to work you do need to reference these files in the location that is expected by the respective program.

## Oh my Zsh
This makes the shell look a lot better. Make sure you have `curl`, `zsh` and `git` installed first. If you already have a `.zshrc` file, it will be backed up and then overwritten.
```console
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
You will be asked if you want to make `zsh` your default shell. Pick Yes.

## Jekyll
I prefer installing `jekyll` via `gem`, than via `apt`, as that gives a more recent version. Make sure that you have the `RUBY_HOME` environment variable set and that `RUBY_HOME/bin` is on your `PATH`:
```console
$ sudo apt install ruby-full build-essential zlib1g-dev
$ gem install jekyll jekyll-tidy jekyll-feed bundler
```

For `gem`, make sure you have `~/.gemrc` set up with at least the following settings:
```text
:gemdir:
    - ~/.gem/ruby
install: --user-install
```

## Ledger
Ledger CLI and hledger are great tools to manage your accounting needs. Make sure that you have the `LEDGER_FILE`, `LEDGER_INIT` and `LEDGER_PRICE_DB` environment variables set up:
```console
$ sudo apt install ledger hledger
```

## Docker
```console
$ sudo snap install docker
$ sudo groupadd docker
$ sudo usermod -aG docker $USER
```

## Java
As I am a Java developer, I like to have a recent JDK installed:
```console
$ sudo apt install default-jdk -y
```

## IntelliJ
```console
$ sudo snap install intellij-idea-ultimate --classic
```

## Latex
My favorite desktop publishing program.
```console
$ sudo apt install texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra
```

## Haskell
As one of my favorite languages, I also make sure to have Haskell ready. The easiest and quickest way is:
```console
$ sudo apt install haskell-platform
```
For a more scalable solution, have a look at [stack][stack].

## Visual Studio Codium
The open soure (and tracker free) version of VS Code.
```console
$ snap install codium
```

## Flatpak
Flatpak allows you to install more recent versions of software and more control over the permissions of the software. Here I use it to install GIMP.
```console
$ sudo apt install flatpak
$ flatpak remote-add flathub https://dl.flathub.org/repo/flathub.flatpakrepo
$ flatpak update
$ flatpak install flathub org.gimp.GIMP
$ flatpak install flathub org.audacityteam.Audacity
$ flatpak install flathub com.obsproject.Studio
$ flatpak install flathub com.calibre_ebook.calibre
$ flatpak install flathub com.jetbrains.IntelliJ-IDEA-Community  # Gives problems due to file system restrictions, better install via snap
$ flatpak install flathub com.github.tchx84.Flatseal             # Manage permissions of Flatpak apps
```

For IntelliJ, you may need to add a permission to access the JDK on your system. I did this by adding `/usr/lib/jvm` to the file permissions via Flatseal.

## VPN
Download the `.ovpn` files from your VPN provider for the connections that you want to add. Import them and set up the user name and password as described in [this post]({% post_url 2020-07-05-using-nmcli-to-connect-to-vpn %}).

Then add the automatic activation of a VPN connection at the start of a user session to `~/.profile`:
```shell
# Check if any VPN is active via NetworkManager.
if [[ $(nmcli c show --active | grep vpn) ]]; then
  echo "VPN already active"
else
  # Check if any VPN configutation exists
  if [[ $(nmcli c show | grep vpn) ]]; then
    # Connect to the first one on the list
    nmcli con up id $(nmcli c show | grep vpn | awk '{ print $1 }' | head -n 1) passwd-file ~/.vpncreds
  else
    echo "No VPNs available via NetworkManager"
  fi
fi
```

## Disable tracker
Ubuntu by default has the `tracker` service enabled, which indexes files on your hard drive to make them easily searchable. However, in my experience this process often takes up 100% of the CPU. Also I don't really need this function, so I disable it.
```console
$ gsettings set org.freedesktop.Tracker.Miner.Files enable-monitors false
$ gsettings set org.freedesktop.Tracker.Miner.Files ignored-files "['*']"
$ gsettings set org.freedesktop.Tracker.Miner.Files crawling-interval -2
$ sudo pkill tracker
$ rm -rf ~/.cache/tracker
$ rm -rf ~/.local/share/tracker
```

## Resources
- [The Haskell Tool Stack][stack]

[stack]: https://docs.haskellstack.org/en/stable/README/
