Date: Fri, 6 Apr 2001 10:18:34 +0300 (EET DST)
From: =?ISO-8859-1?Q?Jaakko_Peltom=C3=A4ki?= <eejape@tpu.fi>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Hardhat linux on CLLF initrd problem
Message-ID: <Pine.GSO.4.20.0104061003140.2888-100000@newton.tpu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Okay I am a newbie, now that this is said to the problem:
I applied the patch to the time.h at:
http://lists.linuxppc.org/listarcs/linuxppc-embedded/200004/msg00106.html
Now when I make the zImage.initrd it gives errors:

make[1]: Entering directory `/home/jaakko/linux-2.2.14/arch/ppc/kernel'
/opt/hardhat/devkit/ppc/8xx/bin/ppc_8xx-gcc -D__KERNEL__
-I/home/jaakko/linux-2.2.14/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -fno-builtin -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -mcpu=860 -I../8xx_io
  -c -o time.o time.c
In file included from time.c:49:
time.h: In function `set_dec':
time.h:43: `DEC_ADDR' undeclared (first use in this function)
time.h:43: (Each undeclared identifier is reported only once
time.h:43: for each function it appears in.)
make[1]: *** [time.o] Error 1
make[1]: Leaving directory `/home/jaakko/linux-2.2.14/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

It says that DEC_ADDR is undefined. Could someone explain how to fix
this. Should I just use #define something? Or am I missing something here?

Yes I tried to look for an answer from the archives of this mailing list
with no luck. Thank you in advance for your help.

Jaakko Peltomäki
Designer
http://www.syspex.fi


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
