Date: Tue, 27 Feb 2001 10:52:08 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Problem with LinuxPPC Kernel 2.4.2 build
In-Reply-To: <3A9BD79D.5BA06B7C@arlut.utexas.edu>
Message-ID: <Pine.A41.3.96LJ1.1b7.1010227104958.75940C-100000@unlserve.unl.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Feb 2001, Ken Offer wrote:

> Hi all,
>
> I downloaded the latest kernel and attempted to build it (i.e.
> ftp://ftp.fsmlabs.com/pub/linuxppc/linuxppc_2_4.snap.tar.bz2  20117 Kb
> Tue Feb 27 06:07:00 2001).  After a while, along comes the curious
> error:
>
> make[1]: Entering directory `/usr/src/linuxppc_2_4_2/arch/ppc/coffboot'
> gcc  -D__KERNEL__ -I/usr/src/linux/include -D__powerpc__  -c -o
> coffcrt0.o coffcrt0.S
> gcc -D__KERNEL__ -I/usr/src/linux/include -D__powerpc__ -O -fno-builtin
> -D__KERNEL__ -I/usr/src/linux/include -D__powerpc__ ppc -c -o start.o
> start.c
> gcc: cannot specify -o with -c or -S and multiple compilations
> make[1]: *** [start.o] Error 1
> make[1]: Leaving directory `/usr/src/linuxppc_2_4_2/arch/ppc/coffboot'
> make: *** [zImage] Error 2
>
> I am using gcc 2.95.3.  Should I be using another version of the
> compiler that can handle the "-c" and "-S" options together, or is there
> a bug in the Makefile?

It's not a gcc problem.  Maybe, wait a day or two and refetch the archive?


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
