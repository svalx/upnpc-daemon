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
The upnpc-daemon containce following files:
 - *upnpc-daemon.service* - oneshot systemd service unit
 - *upnpc-redirect.sh*    - a bash script called by upnpc-daemon.service
 - *upnpc-daemon.timer*   - timer to start upnpc-daemon.service
 - *ports.conf*           - drop-in file for the upnpc-daemon.service
 - *schedule.conf*        - drop-in file for the upnpc-daemon.timer

## Requirements
For redirect ports by upnpc-daemon you need:
 - UPnP-enabled router
 - Linux distribution with systemd
 - MiniUPnPc - http://miniupnp.free.fr/
 - Bash 4.2 or higher

## Installation
Place the files in the following paths:
 - */usr/local/systemd/system/upnpc-daemon.service*
 - */usr/local/systemd/system/upnpc-daemon.timer*
 - */usr/local/systemd/system/upnpc-daemon.service.d/ports.conf*
 - */usr/local/systemd/system/upnpc-daemon.timer.d/schedule.conf*
 - */usr/local/bin/upnpc-redirect.sh*

If these directories do not exist, then they need to be created.
Note you need superuser priveleges for this and next actions.

## Configuration
After files installation you need to specify a ports for redirecting in
*/etc/systemd/system/upnpc-daemon.d/ports.conf*. This file contain some
examples. Environment variables must follow the naming and numbering
order exactly, do not use next var numbers with not defined previous -
it will be cause of stoping processing.
You can also adjust the update interval in *schedule.conf*, default it
set to 9 min since my test router has a 10-minute removal period for
unused redirects.
Execute `systemctl daemon-reload` after editing drop-in or timer files to
apply the changes.
Enable systemd timer by executing `systemctl enable --now upnpc-daemon.timer`
Now you can check ports redirecting. For debugging, you can first of all
check the output of upnpc-daemon unit like `journalctl -r --unit=upnpc-daemon`
Don't forget about firewall configuration if it applicable.

## Distribution
For get a latest version `git clone git@github.com:svalx/upnpc-daemon.git`  
openSUSE rpm packages can be found in Open Build Service at
https://build.opensuse.org/package/show/home:svalx/upnpc-daemon

## Limitations
 - Not all routers can redirect ports from privileged range
(0 - 1023) by UPnP. At least miniupnpd 2.2.3 failed such an attempt
with code 718 (ConflictInMappingEntry).
 - IPv6 redirecting not implemented yet.
 - Can't remove old redirections after configurations change or host shutdown.
 - Can't redirect ports to other then localhost internal addresses.
 - Already occupied and redirected ports are not checked before redirection
attempting and it may be failer with code 718 (ConflictInMappingEntry).

## Contribution
All comments, patches or pull requests are welcome. It would be great to
remove some restrictions from the section above.

## License
See LICENSE file.

## Author
Alexey Avistunov <svalx@svalx.net>
