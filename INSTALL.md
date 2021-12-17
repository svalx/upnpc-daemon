# Installation instructions
You may install upnpc-daemon in a different ways:
 - install by your Linux distribution package manager if it available (preferred way)
 - using *make* - if native package no available for your OS
 - manually - if for some reason the previous option is not suitable
____

## Installing Linux package manager
At this moment available rpm packages in [Open Build Service](https://software.opensuse.org/package/upnpc-daemon) for openSUSE Leap 15.3/SLE 15 SP3 and CentOS/RHEL/OL 8:  
### openSUSE Leap 15.3/SLE 15 SP3
    # zypper addrepo --repo https://download.opensuse.org/repositories/home:/svalx/15.3/home:svalx.repo
    # zypper install upnpc-daemon
### CentOS/RHEL/OL 8
    # dnf config-manager --add-repo https://download.opensuse.org/repositories/home:svalx/CentOS_8/home:svalx.repo
    # dnf install upnpc-daemon
## Installing by make
You need *GNU make* for this option

### Quick install

1. Unpack the archive if you have not done so already  
   `$ tar -xf upnpc-daemon-[version].tar.gz`
2. Enter to upnpc-daemon directory and run configure  
   `$ cd upnpc-daemon-[version]`  
   `$ ./configure`
3. Run make  
   `$ make`
4. Type 'make install' to install the program
   (you'll probably need superuser privileges for this action)  
   `# make install`

upnpc-daemon will be installed in */usr/local* prefix according FHS.
All needed directories will be created automatically.

### Advanced install
Some installation properties may be set by configure script:
 - install paths
 - source directories
 - softlink creation to *service* binary
 - README.md and drop-in file examples installation to a package docdir
 - systemd drop-in files installations to goal directories

**Type `./configure --help` for full usage instructions.**  
After *configure* executed, it created a *config.status* script,
that store an original configuration options and may be used for
reconfigure without any  metadata lost. *Makefile*, created by
*configure* contains some standard targets like *dist*, that can
be used for your purposes. Makefile also supports the DESTDIR
parameter, which will allow you to install the program in another
root directory like this:  
   `# make install DESTDIR=/tmp`

## Manual install
You may manually install upnpc-daemon, it's not so difficult:
1. First of all, decide in which prefix the program will be installed. By default,
   I suggest */usr/local*, and the following examples will take this into account.
2. Unpack the archive and enter to target directory:
   `$ tar -xf upnpc-daemon-[version].tar.gz`
   `$ cd upnpc-daemon-[version]`
3. Edit src/upnpc-daemon.service.in and rename it to upnpc-daemon.service 
   `$ echo ExecStart=-/usr/local/libexec/upnpc-redirect >> src/upnpc-daemon.service.in`
   `$ mv src/upnpc-daemon.service.in upnpc-daemon.service`
4. Place the files in the following paths:
   `# install -m 644 -D -t /usr/local/lib/systemd/system upnpc-daemon.service upnpc-daemon.timer`
   `# install -D -t /usr/local/libexec upnpc-redirect`
   For set a ports that need be forwarded and custom update schedule
   you can install a drop-in files (not necessary, аn another option
   for tune settings using `systemctl edit` tool):  
   `# install -m 644 -D -t /etc/systemd/system/upnpc-daemon.service.d examples/ports.conf`
   `# install -m 644 -D -t /etc/systemd/system/upnpc-daemon.timer.d examples/schedule.conf`  
   If these directories do not exist, then they need to be created. Note you'll
   probably need superuser privileges for this and next actions. 
5. Optionally, you can create a softlink */usr/local/sbin/rcupnpc-daemon* to
   */usr/sbin/service* that allows for a convenient restart of the service.
   `# ln -sf /usr/sbin/service /usr/local/sbin/rcupnpc-daemon`  
   Also you can install README.md and drop-in files examples in the
   directory tree to have usage instructions at hand:  
   `# mkdir -p /usr/local/share/doc/upnpc-daemon/examples`  
   `# install -m 644 README.md /usr/local/share/doc/upnpc-daemon`  
   `# install -m 644 examples/* /usr/local/share/doc/upnpc-daemon/examples`  
*install-sh* and *mkinstalldirs* scrips available in the *tools* subdirectory,
it can be used for safe directory creations and file installation if native
install tool not avalilable.

# Upgrade instructions
Usually you need to follow the original installation method to upgrade, but *make* and
manual methods can be mixed, although this is undesirable.

## Upgrade by Linux package manager
In this case, the package maintainer should take care of everything for you.
For example, the rpm package will save all sensitive settings and configure
systemd services.

## Upgrade by make
Not needed to uninstall upnpc-daemon for upgrade, you can safe do it by
`# make install` and don't worry about lost your settings. By default, installation
system checks your drop-in files (only they contain any settings) for a changes,
and if differences are found, those new ones creating with a '.new' suffix, that avoid
overwriting. This behavior can be changed by using *FORCE* variable when 'make install':  
    # make install FORCE=true  
Set *FORCE* to *true* tell installation system to force overwrite drop-in file anyway.
Don't use another *FORCE* values except *true*, it used in bash commands.  
Untar new package version next to the previous one and follow the general
install instructions.

## Manual upgrade
Read CANGELOG.md, compare files and decide whether to replace/delete/install new ones.
Be careful with these drop-in files, because they contain ports settings and update
schedule. It is necessary to launch `# systemctl daemon-reload` end check units status
after upgrade.

# Uninstall instructions
When you uninstall upnpc-daemon, systemd drop-in files normally remain
in their directories for a future installations. Remove they are manually
or use *FORCE*=true in case of *make* using.

## Uninstall by Linux package manager
### openSUSE Leap 15.3/SLE 15 SP3
    # zypper remove upnpc-daemon
### CentOS/RHEL/OL 8
    # dnf remove upnpc-daemon

## Uninstall by make
    # make uninstall
Drop-in files will be left if it different from orirginal.
    # make uninstall FORCE=true
In second case drop-in file will be deleted anyway with their directories.

## Manual uninstall
Follow the installation instructions only in reverse order and sense. Disable
systemd timer by `# systemctl disable upnpc-daemon.timer` and delete all files
and directories that you created.

