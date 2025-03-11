# rt - simple terminal
# See LICENSE file for copyright and license details.
# $Ragnarok: Makefile,v 1.4 2025/03/11 17:58:26 lecorbeau Exp $
.POSIX:

include config.mk

SRC = rt.c x.c
OBJ = $(SRC:.c=.o)

all: options rt

options:
	@echo rt build options:
	@echo "CFLAGS  = $(STCFLAGS)"
	@echo "LDFLAGS = $(STLDFLAGS)"
	@echo "CC      = $(CC)"

config.h:
	cp config.def.h config.h

.c.o:
	$(CC) $(STCFLAGS) -c $<

rt.o: config.h rt.h win.h
x.o: arg.h config.h rt.h win.h

$(OBJ): config.h config.mk

rt: $(OBJ)
	$(CC) -o $@ $(OBJ) $(STLDFLAGS)

clean:
	rm -f rt $(OBJ) rt-$(VERSION).tar.gz

dist: clean
	mkdir -p rt-$(VERSION)
	cp -R FAQ LEGACY TODO LICENSE Makefile README.md config.mk \
		config.def.h rt.info rt.1 rt.xresources arg.h rt.h win.h $(SRC) \
		rt-$(VERSION)
	tar -czvf rt-$(VERSION).tgz rt-$(VERSION)

install: rt
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f rt $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/rt
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f rt.1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/rt.1
	mkdir -p $(DESTDIR)$(PREFIX)/share/doc/rt-$(VERSION)
	cp -f rt.xresources $(DESTDIR)$(PREFIX)/share/doc/rt-$(VERSION)
	chmod 644 $(DESTDIR)$(PREFIX)/share/doc/rt-$(VERSION)/rt.xresources
	tic -sx rt.info
	@echo Please see the README.md file regarding the terminfo entry of rt.

deb: rt
	/usr/bin/equivs-build rt.pkg

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/rt
	rm -f $(DESTDIR)$(MANPREFIX)/man1/rt.1

.PHONY: all options clean dist install uninstall
