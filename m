Message-ID: <41EDEC3C1B88D51186EB00A0C9CFADF702FA88@AMWMAIL>
From: Cindy Peters <cinpet@adaptivemicro.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Cross-compiling standard utilities for MPC823
Date: Tue, 25 Sep 2001 10:12:33 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am attempting to cross-compile the file utilities that I downloaded from
the linuxppc ftp site for the MPC823 on an x86 PC running Redhat 6.2. I am
getting an error when configure is trying to determine the byte ordering.
Following is a clip from the config.log file.

configure:2220: checking whether byte ordering is bigendian
configure:2242: powerpc-linux-gcc -c -g -O2  conftest.c >&5
configure: In function `main':
configure:2236: `bogus' undeclared (first use in this function)
configure:2236: (Each undeclared identifier is reported only once
configure:2236: for each function it appears in.)
configure:2236: parse error before `endian'
configure: failed program was:
#line 2228 "configure"
#include "confdefs.h"
#include <sys/types.h>
#include <sys/param.h>

int
main ()
{
#if !BYTE_ORDER || !BIG_ENDIAN || !LITTLE_ENDIAN
 bogus endian macros
#endif

  ;
  return 0;
}

I have tried defining BIG_ENDIAN and BYTE_ORDERING but that is not helping.
Can someone tell me what I need to do to successfully cross-compile this?
Here is the command line I am using.

AR=powerpc-linux-ar AS=powerpc-linux-as LD=powerpc-linux-ld \
  RANLIB=powerpc-linux-ranlib CC=powerpc-linux-gcc NM=powerpc-linux-nm \
  ./configure --build=i686-pc-linux-gnu --host=powerpc-unknown-linux-gnu \
  --target=powerpc-unknown-linux-gnu \
	--prefix=/opt/usr/local/powerpc-linux

Thanks,

Cindy Peters
Adaptive Micro-Ware, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
