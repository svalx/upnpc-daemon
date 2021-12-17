# upnpc-daemon
A simple systemd daemon for redirecting ports on UPnP-enabled
routers to localhost using miniupnpc.
____

## Overview
Sometimes it is required to have some ports open to the outside
without having admin access to the router. Some software can do it for
yourself, but most require third-party tools. The upnpc-daemon is designed
for this task.

## Contents
The upnpc-daemon contain following files:
 - *src/upnpc-daemon.service.in* - oneshot systemd service unit template
 - *src/Makefile.in*             - constant part of package Makefile
 - *upnpc-daemon.timer*          - timer to start upnpc-daemon.service
 - *upnpc-redirect*              - a bash script called by upnpc-daemon.service
 - *examples/ports.conf*         - drop-in file for the upnpc-daemon.service
 - *examples/schedule.conf*      - drop-in file for the upnpc-daemon.timer
 - *VERSION*                     - this file cotaine a version number of package
 - *CHANGELOG.md*                - all notable changes to this project
 - *INSTALL.md*                  - installation instructions
 - *COPYING*                     - GNU GPL
 - *configure*                   - configure script
 - *README.md*                   - this file
 - *tools/install-sh*            - shell version of install utility 
 - *tools/mkinstalldirs*         - standard tool for create directories by
                                   installdirs target of Makefile

## Requirements
For redirect ports by upnpc-daemon you need:
 - UPnP-enabled router
 - Linux distribution with systemd
 - MiniUPnPc - http://miniupnp.free.fr/
 - Bash 4.2 or higher

## Installation
See INSTALL.md. This file also contain a Upgrade and Uninstall sections.

## Configuration
After files installation you need to specify a ports for redirecting.
This can be done by `# systemctl edit upnpc-daemon.service`, or by editing
the a drop-in files supplied with the package. Drop-in files are installing
to examples subdir under package docdir, when enabled by configure, and
contains a configuration examples:
*/usr/local/share/doc/packages/upnpc-daemon/examples*
Configure script also receives an *--enable-dropins* option for installing
drop-in files to appropriated systemd directories:
*/etc/systemd/system/upnpc-daemon.{service,timer}.d*.  
**ports.conf** is a point for set ports needs be opening. Environment variables
must follow the naming and numbering order exactly, do not use next var numbers
with not defined previous - it will be cause of stopping processing.  
There is a possibility to adjust the update interval in **schedule.conf**,
default it set to 9 min since my test router has a 10-minute removal period
for unused redirects. You can `# systemctl edit upnpc-daemon.timer` instead.  
Execute `# systemctl daemon-reload` after editing drop-in files to apply the
changes. Enable systemd timer by executing
`# systemctl enable --now upnpc-daemon.timer`. That's all.  
Now you can check ports redirecting. For debugging, you can first of all
check the output of upnpc-daemon unit like `# journalctl -r --unit=upnpc-daemon`
Don't forget about firewall configuration if it applicable.

## Distribution
For get a latest version `$ git clone git@github.com:svalx/upnpc-daemon.git`  
openSUSE/SLE and CentOS/RHEL/OL 8 rpm packages can be found in [Open Build Service]
(https://software.opensuse.org/package/upnpc-daemon)

## Limitations
 - Not all routers can redirect ports from privileged range
(0 - 1023) by UPnP. At least miniupnpd 2.2.3 failed such an attempt
with code 718 (ConflictInMappingEntry).
 - IPv6 redirecting not implemented yet.
 - Can't remove old redirections after configurations change or host shutdown.
 - Can't redirect ports to other then localhost internal addresses.
 - Already occupied and redirected ports are not checked before redirection
attempting and it may be failed with code 718 (ConflictInMappingEntry).

## Contribution
All comments, patches or pull requests are welcome. It would be great to
remove some restrictions from the section above.

## License
See COPYING file.

## Author
Copyright (C) 2021 Alexey Svistunov <svalx@svalx.net>
