.PHONY: prefixpatch

INSTALL ?= /usr/bin/install
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644
PREFIX ?= /usr/local
exec_prefix = $(DESTDIR)$(PREFIX)
libdir = $(exec_prefix)/lib
unitdir = $(libdir)/systemd/system
bindir = $(exec_prefix)/bin
sbindir = $(exec_prefix)/sbin
basename = upnpc-daemon
scriptname = upnpc-redirect.sh

all: prefixpatch

prefixpatch: upnpc-daemon.service
	echo $(PREFIX)
	echo $(DESTDIR)

installdirs: mkinstalldirs
	./mkinstalldirs $(bindir) \
                        $(unitdir)/$(basename).service.d \
                        $(unitdir)/$(basename).timer.d
install: all installdirs
	$(INSTALL_PROGRAM) $(scriptname) $(bindir)
	$(INSTALL_DATA) ports.conf $(unitdir)/$(basename).service.d
	$(INSTALL_DATA) schedule.conf $(unitdir)/$(basename).timer.d
	$(INSTALL_DATA) $(basename).service $(basename).timer $(unitdir)

uninstall: 
	rm -rf $(unitdir)/$(basename).service.d \
               $(unitdir)/$(basename).timer.d \
               $(bindir)/$(scriptname) \
               $(unitdir)/$(basename).service \
               $(unitdir)/$(basename).timer
