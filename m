Message-ID: <A33AEFDC2EC0D411851900D0B73EBEF7063E50@NAPA>
From: Hua Ji <hji@netscreen.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: cross-compier with gcc
Date: Wed, 17 Jan 2001 11:06:44 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, guys,

Good morning!

Help needed!

I made a cross compiler on my solaris machine for powerpc-elf target.
Everything looks fine when I did the make.

When I used my powerpc-elf-gcc to compile and link my helloworld.c, I got
some error described below. Basically,
my helloworld.c is:
--------
#include <stdio.h>
void main()
{
	printf("Hello World!\n");
}
--------

The command line used for compile and link is: powerpc-elf-gcc -v -o
helloworld helloworld.c

The error is: Can't link printf codes from library!!

---------
GNU assembler version 2.9.1 (powerpc-elf), using BFD version 2.9.1

/export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
collect2 -V -Qy -dn -Bstatic
-L/export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.
2 -L/export/home4/hji/compilers/powerpc-elf-1-17/powerpc-elf/lib
/var/tmp/ccAEuQ8q.o
/export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
libgcc.a
/export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
libgcc.a
/export/home4/hji/compilers/powerpc-elf-1-17/powerpc-elf/bin/ld: warning:
cannot find entry symbol _start; defaulting to 01800074
/var/tmp/ccAEuQ8q.o: In function `ppctest':
/var/tmp/ccAEuQ8q.o(.text+0x20): undefined reference to `printf'
GNU ld version 2.9.1 (with BFD 2.9.1)
  Supported emulations:
   elf32ppc
--------------------

Thanks, guys.

Hua

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
