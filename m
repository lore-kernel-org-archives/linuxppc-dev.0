Message-ID: <38CA8F43.A792106C@charter.net>
Date: Sat, 11 Mar 2000 12:24:03 -0600
From: "Dan A. Dickey" <ddickey@charter.net>
MIME-Version: 1.0
To: Quan Qu <ququan@cityfujisawa.ne.jp>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: cdk building
References: <200003110808.AA00070@shanghai.cityfujisawa.ne.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Quan Qu wrote:
...
> I am using Mr. wolfgang 's solution below on Redhat6.1  to build CDK.
>
> >Summary: I've put the scripts I'm using to build the PPC Cross
> >Development Kit for the MPC8xx CPUs on
> >
> >       ftp://ftp.denx.de/pub/LinuxPPC/usr/src/CDK.tar.gz
> >
> >or URL where I got the sources from:
> >
> >ftp://ftp.valinux.com/pub/support/hjl/binutils/binutils-2.9.5.0.22.t
> ar.bz2
...
> I copy the downloaded gzip source to the /LinuxPPC/usr/src/tarballs
> ,and modify ENVIRONMENT.
> then do:
> make binutils
> make egcs-core
> make linux
> make glibc
> make egcs
>
> everything go smoothly until I reach the glibc. I got linker error:
...
> /LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/libc_pic.a(init-first.os): In
> function
> `_dl_start':
> init-first.os(.text+0x128): multiple definition of `_dl_start'
> /LinuxPPC/usr/src/CDK/obj/glibc-2.1.2/elf/dl-allobjs.os(.text+0x680):
> first
> defined here
> /LinuxPPC/CDK/powerpc-linux/bin/ld: Warning: size of symbol
> `_dl_start' changed
> from 568 to 48 in init-first.os
...

I'm not sure why, but I discovered last weekend that
trying to use binutils-2.9.5.0.27 gave me this same problem.
I switched to using binutils-2.9.5.0.22, and this problem
went away.  Make sure you are using 22 and not something newer.
Can you let me know what version you were using if not 27?
I'd like to pinpoint the version where this broke.
	-Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
