Subject: Re: glibc-2.1.2 cross-compile problem
To: eclarke@aminocom.com (Elizabeth Clarke)
Date: Fri, 28 Apr 2000 10:42:54 +1000 (EST)
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <39084D22.417A2FC3@aminocom.com> from "Elizabeth Clarke" at Apr 27, 2000 02:22:26 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000428004254.2D5043C978@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Elizabeth,

Elizabeth Clarke writes:
> /usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
> -B/usr/local/powerpc-linux/bin/ -c -g -O2 -I. -I. -D_IO_MTSAFE_IO
> iogetline.c -o pic/iogetline.o
> /usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
> -B/usr/local/powerpc-linux/bin/ -c -g -O2 -I. -I. -D_IO_MTSAFE_IO
> iogetline.c
> In file included from iolibio.h:1,
>                  from libioP.h:47,
>                  from iogetline.c:26:
> libio.h:30: _G_config.h: No such file or directory
> make[1]: *** [iogetline.o] Error 1
> make[1]: Leaving directory
> `/usr/local/src/gcc-2.95.2/powerpc-linux/libio'
>
> So now I'm where Graham Stoney was at Date: Thu, 12 Aug 1999 14:34:44
> -0400.

Can't remember what I did to solve this, but I got past it somehow. Try
doing a "make install", and see if it installs enough of the compiler to go
ahead with the glibc build. I found I had to build gcc in two passes, firstly
with --with-newlib, and then without once glibc was installed.

> Surely its should not be as bad as this?

Agreed. Funnily enough though, it's better than it used to be. I remember when
I was a lad, before "configure" was around...

Good luck,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
