---
layout: post
title:  "Installing Jekyll from gem"
date:   2018-05-19 02:50:00 +0200
tags:   linux jekyll ruby gem
---
*In case you need the latest version of Jekyll, you will need to install it manually using
Ruby and Ruby gems. This post explains how.*

## Preliminaries
I'm using Ubuntu 18.04 as my OS.

## Install Ruby and C++ compile tools
You will need a few dependencies installed on your system in order for the gem to be
able to compile. Install them with the following command:
```console
$ sudo apt install ruby ruby-dev make gcc g++
```

Then create a config file for your gems in your home folder:
```console
$ touch ~/.gemrc
```

Put the following in `~/.gemrc`:
```
:gemdir:
    - ~/.gem/ruby
install: --user-install
```

Also, be sure to add the Ruby bin folder to your PATH variable in `~/.bash_profile`, like in this snippet:
```
# Add ruby home, defined in ~/.gemrc
RUBY_HOME="~/.gem/ruby/2.5.0"
# Add ruby bin to path
PATH="$PATH:$RUBY_HOME/bin"
```

## Install Jekyll
Use `gem` to install the latest version of Jekyll:
```console
$ gem install jekyll
```

Keep in mind that the `.gem` folder now contains compiled code dedicated to your current system. If you want to move to another system you cannot simply copy this folder to your new home folder. You will have to remove the `.gem` folder and recompile (reinstall) the gems.

## Resources
- [Error while executing gem][stack]

[stack]: https://stackoverflow.com/questions/18599889/error-while-executing-gem-gemfilepermissionerror
