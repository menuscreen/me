# Linux Commands

A collection of information on the various commands available in the Linux
shell and how they can be used. Includes information on the syntax of each
command, as well as examples of how to use the command in different scenarios.

## Index

* [man](#man)
* [sudo](#sudo)
* [update and upgrade](#update-and-upgrade)
* [ls](#ls)
* [hostname](#hostname)
* [pwd](#pwd)
* [cd](#cd)

[related resources](#related-resources)

## man

* `man` - manual pages display information about a command

Usage:
```bash
man <command>
# for example:
man ls
```

Basic navigation of `man` pages:
* h = help
* q = quit
* spacebar = page down 1 window
* b = page up 1 window
* / = search forward
  * `/searchword` + enter = highlights matches
  * n = next match
  * alt+u = toggle highlight

[*Jump to Index*](#index)

## sudo

* `sudo` allows permitted users to execute commands as a *superuser* or 
another user. 

Try ``man sudo`` with the basic navigation of man pages above.

[*Jump to Index*](#index)

## update and upgrade

`apt` - Advanced Packaging Tool: used for installing, upgrading, 
configuring, and removing software. Debian and debian based distributions like 
Ubuntu have `apt`. Use `apt` from the command line for interactive use, and 
use `apt-get` or `apt-cache` in scripts to help keep backward compatibility. 

* `sudo apt update` - check's for available updates to installed packages and 
dependancies - adds to what you already have.
* `sudo apt upgrade` - downloads and installs the updates for outdated 
packages adds new features/improvements and may require reconfiguring (might 
break stuff, but upgrades are generally encouraged - snapshot VMs to revert 
changes).
* `apt search ^neo` - search for packages with that start with "neo" in 
the name.  
  Note:
  > The packages in `apt` are vetted and approved by the debian and ubuntu 
  teams are safe and stable security.
* `sudo apt install neofetch` - installs neofetch package and dependencies
* `sudo apt remove neofetch` - uninstalls neofetch package
* `sudo apt autoremove neofetch` - automatically uninstalls unused package 
dependencies
* `sudo apt purge neofetch` - get rid of any remaining configuration files left
over by packages that have already been removed (does not affect home 
directory)


Analogy: (update) new socks versus new outfit (upgrade)

[*Jump to Index*](#index)

## ls

* `ls` - list directory contents
* `ls -a` - list *all* directory contents (including hidden .files)
* `ls -la` - list *all* directory contents in *long* list format

[*Jump to Index*](#index)

## hostname

* ``hostname`` - display name of host computer

[*Jump to Index*](#index)

## pwd 

* `pwd` - print working directory: the current path you are at in the 
file system

[*Jump to Index*](#index)

## cd

* `cd` - change current directory  
   
  > **Note**:  
  > Can't use in a script

```bash
# jump to current user's home folder
cd ~ 
cd
# move 'up' a directory
cd ..
# change to root directory
cd /
# alternate back and forth
cd -
```

[*Jump to Index*](#index)

### **Related resources**:

* [linuxcommand.org](https://www.google.com/search?q=linuxcommand.org)
* [explainshell.com](https://www.google.com/search?q=explainshell.com)
