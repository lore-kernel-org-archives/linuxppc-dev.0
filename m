Date: Wed, 17 Jan 2001 14:18:25 -0600 (CST)
From: Grant Erickson <erick205@umn.edu>
To: Hua Ji <hji@netscreen.com>
cc: Jamie Guinan <guinan@bluebutton.com>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: cross-compier with gcc
In-Reply-To: <Pine.LNX.4.21.0101171510210.1876-100000@gemini.home.net>
Message-Id: <Pine.SOL.4.20.0101171417180.8041-100000@garnet.tc.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 17 Jan 2001, Jamie Guinan wrote:
> You need to configure for "powerpc-linux", and build a glibc.
>
>   http://members.nbci.com/greyhams/linux/PowerPC-Embedded-HOWTO-5.html
>   http://members.home.net/mmporter/linux/cross/

And don't forget:

    http://www.borg.umn.edu/~grant/Linux/cross.html

Grant


> On Wed, 17 Jan 2001, Hua Ji wrote:
>
> > Hi, guys,
> >
> > Good morning!
> >
> > Help needed!
> >
> > I made a cross compiler on my solaris machine for powerpc-elf target.
> > Everything looks fine when I did the make.
> >
> > When I used my powerpc-elf-gcc to compile and link my helloworld.c, I got
> > some error described below. Basically,
> > my helloworld.c is:
> > --------
> > #include <stdio.h>
> > void main()
> > {
> > 	printf("Hello World!\n");
> > }
> > --------
> >
> > The command line used for compile and link is: powerpc-elf-gcc -v -o
> > helloworld helloworld.c
> >
> > The error is: Can't link printf codes from library!!
> >
> > ---------
> > GNU assembler version 2.9.1 (powerpc-elf), using BFD version 2.9.1
> >
> > /export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
> > collect2 -V -Qy -dn -Bstatic
> > -L/export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.
> > 2 -L/export/home4/hji/compilers/powerpc-elf-1-17/powerpc-elf/lib
> > /var/tmp/ccAEuQ8q.o
> > /export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
> > libgcc.a
> > /export/home4/hji/compilers/powerpc-elf-1-17/lib/gcc-lib/powerpc-elf/2.95.2/
> > libgcc.a
> > /export/home4/hji/compilers/powerpc-elf-1-17/powerpc-elf/bin/ld: warning:
> > cannot find entry symbol _start; defaulting to 01800074
> > /var/tmp/ccAEuQ8q.o: In function `ppctest':
> > /var/tmp/ccAEuQ8q.o(.text+0x20): undefined reference to `printf'
> > GNU ld version 2.9.1 (with BFD 2.9.1)
> >   Supported emulations:
> >    elf32ppc
> > --------------------
> >
> > Thanks, guys.
> >
> > Hua
> >
> >
> >
>
> --
> ================================================================
> Jamie Guinan                         Blue Button Solutions, Inc.
> guinan@bluebutton.com                  http://www.bluebutton.com
> ================================================================
>
>
>
>

--
 Grant Erickson                       University of Minnesota Alumni
  o mail:erick205@umn.edu                                 1996 BSEE
  o http://www.umn.edu/~erick205                          1998 MSEE


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
