Message-ID: <3B7ACCD7.BCC0D2AA@minolta-qms.com>
Date: Wed, 15 Aug 2001 13:26:15 -0600
From: Mark Pilon <mark.pilon@minolta-qms.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: gcc 3.0 for PPC
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


if anyone is / has built gcc 3.0 for PPC I'd appreciate a word as
to how you configured it.

I built it configured:
./configure --host=i386-pc-linux-gnu --target=powerpc-linux
--prefix=/home/mpilon/ppc_tools --with-newlib -enable-languages=c

and got many warnings, mostly comparison between signed and unsigned ...

and it finally dies compiling ./libgcc2.c -o libgcc/./_muldi3.o
w/:

In file included from tm.h:6,
                 from config/rs6000/xm-sysv4.h:35,
                 from tconfig.h:3,
                 from libgcc2.c:36:
config/rs6000/linux.h:81:20: signal.h: No such file or directory
config/rs6000/linux.h:82:26: sys/ucontext.h: No such file or directory
make[2]: *** [libgcc/./_muldi3.o] Error 1
make[2]: Leaving directory `/home/mpilon/ppc_tools/gcc-3.0/gcc'
make[1]: *** [stmp-multilib] Error 2
make[1]: Leaving directory `/home/mpilon/ppc_tools/gcc-3.0/gcc'
make: *** [all-gcc] Error 2

thanks,
Mark

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
