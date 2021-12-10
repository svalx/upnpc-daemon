# Installation instructions
You may install upnpc-daemon in a different ways:
 - install by your Linux distribution package manager if it available (preferred way)
 - using *make* - if native package no available for your OS
 - manually - if for some reason the previous option is not suitable
____

## Installing Linux package
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
 - README.md installation to a package docdir
 - systemd drop-in files installations to goal directories

**Type `./configure --help` for full usage instructions.**  
After *configure* executed, it create a *config.status* script, that store
an original configuration options and may be used for reconfigure
without any metadata lost.
*Makefile*, created by *configure* contains some standard targets like *dist*,
that can be used for your purposes. Makefile also supports the DESTDIR parameter,
which will allow you to install the program in another root directory like this:  
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
	`# mkdir -p /etc/systemd/system/{upnpc-daemon.spervice.d,upnpc-daemon.timer.d} /usr/local/libexec`
	`# install -m 644 upnpc-daemon.service upnpc-daemon.timer /usr/local/lib/systemd/system`
	`# install -m 644 ports.conf /etc/systemd/system/upnpc-daemon.service.d`
	`# install -m 644 schedule.conf /etc/systemd/system/upnpc-daemon.timer.d`
	`# install upnpc-redirect /usr/local/libexec`  
   If these directories do not exist, then they need to be created. Note you'll
   probably need superuser privileges for this and next actions. 
5. Optionally, you can create a softlink */usr/local/sbin/rcupnpc-daemon* to
   */usr/sbin/service* that allows for a convenient restart of the service.
	`# ln -sf /usr/sbin/service /usr/local/sbin/rcupnpc-daemon`  
   Also you can install README.md in the directory tree to have usage instructions at hand:  
   `# mkdir -p /usr/local/share/doc/upnpc-daemon`  
   `# install -m 644 README.md /usr/local/share/doc/upnpc-daemon`  
*install-sh* and *mkinstalldirs* scrips available in the *tools* subdirectory, it can be used for safe directory creations and file installation if native install tool not avalilable.
