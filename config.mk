# $Ragnarok: config.mk,v 1.6 2024/03/24 16:41:30 lecorbeau Exp $

# rt version
VERSION = 0.1

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
STCPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_FORTIFY_SOURCE=2
STCFLAGS = $(INCS) -O2 -flto=thin $(STCPPFLAGS) $(CPPFLAGS) -Wformat -Wformat-security \
	   -fstack-clash-protection -fstack-protector-strong -fcf-protection
STLDFLAGS = $(LIBS) -flto=thin -Wl,-O2 $(LDFLAGS) -Wl,-z,relro,-z,now -Wl,--as-needed

# OpenBSD:
#CPPFLAGS = -DVERSION=\"$(VERSION)\" -D_XOPEN_SOURCE=600 -D_BSD_SOURCE
#LIBS = -L$(X11LIB) -lm -lX11 -lutil -lXft \
#       `$(PKG_CONFIG) --libs fontconfig` \
#       `$(PKG_CONFIG) --libs freetype2`
#MANPREFIX = ${PREFIX}/man

# compiler and linker
CC = clang
