Message-ID: <3B7D82D5.DD98A109@minolta-qms.com>
Date: Fri, 17 Aug 2001 14:47:17 -0600
From: Mark Pilon <mark.pilon@minolta-qms.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: init fails w/ new build of gcc & glibc
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm attempting to build gcc for powerPC as well as new binutils &
glibc, -- all in an attempt to support a new 4xx chip w/ floating
point.

I'm using HHL 1.2 for the 405 & walnut as my base and am attempting
to start using the new compiler and libraries:

I've recompiled the kernel w/ the new compiler (albeit -msoft-float)
and it boots fine;

running w/ the hhl 1.2 libraries the whole system runs fine;

supplying all of the libraries built under the new glibc causes the
following when init is spawned:

Kernel panic: Attempted to kill init!
init: error while loading shared libraries: cannot open sh ared object file:
cannot load shared object file: No such file or directory

-- there is no comment as to what's missing ...

I can spawn sash in place of 'init' and that runs (no surprise ...)
-- I realize I've probably screwed up something pretty basic --
I'm probably out of synch somewhere in the libraries but don't
know how to debug this further.

under sash, when I try to -exec /bin/ldd /bin/busybox all I get
is a file-not-found for ldd ...

thanks in advance,

Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
