Message-ID: <3906FF25.4E9E6AEA@aminocom.com>
Date: Wed, 26 Apr 2000 14:37:25 +0000
From: Elizabeth Clarke <eclarke@aminocom.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: glibc-2.1.2 cross-compile problem
References: <20000426002414.912D83C989@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Graham Stoney wrote:
>
> Elizabeth Clarke writes:
> > I'm having a problem compiling glibc-2.1.2 using the xppc
> > cross-compilation toolset. I (believe I) have followed the instructions
> > for patching glibc and all seemed fine, but I get the following, any help
> > much appriciated!:
>
> Are you running gcc-2.95.2?

I wasn't, but I grabbed it yesterday afternoon and been trying to
compile it as per the instructions at
http://members.home.net/mmporter/linux/cross/ which I found in your FAQ.
I grabbed and compiled the latest binutils okay. But.... can't get gcc
to compile. It took a little pursuading before it would use the
new binutils, and now complains about stdio.h being missing:

/usr/local/src/gcc-2.95.2/gcc/xgcc -B/usr/local/src/gcc-2.95.2/gcc/
-B/usr/local/powerpc-linux/bin/ -c -DHAVE_CONFIG_H -g -O2 -I.
-I./../../include  choose-temp.c
choose-temp.c:29: stdio.h: No such file or directory
choose-temp.c:30: sys/types.h: No such file or directory
choose-temp.c:32: unistd.h: No such file or directory
choose-temp.c:35: stdlib.h: No such file or directory
choose-temp.c:38: sys/file.h: No such file or directory
make[2]: *** [choose-temp.o] Error 1
make[2]: Leaving directory
`/usr/local/src/gcc-2.95.2/powerpc-linux/libiberty'
make[1]: *** [all-target-libiberty] Error 2
make[1]: Leaving directory `/usr/local/src/gcc-2.95.2'


Aaaaaarrrrggggghhhhhhhhhhh!
Beth
 feeling a little frustrated

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
