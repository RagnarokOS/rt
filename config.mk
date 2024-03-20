# $Ragnarok: config.mk,v 1.4 2023/12/01 19:34:25 lecorbeau Exp $

# rt version
VERSION = 0.1

include ${TOPDIR}/usr/share/X11/mk/xprogs.mk

# paths
PREFIX = /usr
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

PKG_CONFIG = pkg-config

# includes and libs
INCS = -I$(X11INC) \
       `$(PKG_CONFIG) --cflags fontconfig` \
       `$(PKG_CONFIG) --cflags freetype2`
LIBS = -L$(X11LIB) -lm -lrt -lX11 -lutil -lXft -lXrender \
       `$(PKG_CONFIG) --libs fontconfig` \
       `$(PKG_CONFIG) --libs freetype2`

# flags
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 ${HARDENING_CPPFLAGS}
STCFLAGS = $(INCS) ${O_FLAG} ${CFLAGS_LTO} $(STCPPFLAGS) $(CPPFLAGS) ${HARDENING_CFLAGS}
STLDFLAGS = $(LIBS) ${LDFLAGS_LTO} $(LDFLAGS) ${HARDENING_LDFLAGS}

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `$(PKG_CONFIG) --libs fontconfig` \
#       `$(PKG_CONFIG) --libs freetype2`
#MANPREFIX = ${PREFIX}/man

# compiler and linker
CC = clang
