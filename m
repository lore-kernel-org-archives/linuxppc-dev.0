From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Can't set CFLAGS before configuring glibc
Date: Mon, 14 Apr 2003 22:00:27 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C486B@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to build glibc-2.2.5 with gcc-core-2.95.3.  If I set
CFLAGS to include "-msoft-float" before the configure, then the
build breaks quickly with a "glibc cannot be compiled without
optimization" error.

My guess is that this overrides the default CFLAGS which contains
optimization flags.  But I can't decipher what's going on to figure
out how to just _append_ to the CFLAGS.

If I could just make the compiler default to -msoft-float or
-mcpu=403, I wouldn't need this.  I did compile gcc using
"--with-cpu=403 --nfp" but this doesn't seem to affect the
default (checked by running "powerpc-linux-gcc -v test.c").
If either -msoft-float or -mcpu=403 are specified, the
-D_SOFT_FLOAT_ does get set correctly.

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
