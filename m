Message-Id: <5.0.2.1.0.20010516132449.00a248b0@pop.gmx.de>
Date: Wed, 16 May 2001 13:41:23 +0800
To: linuxppc-embedded@lists.linuxppc.org
From: Michael Habermann <MHabermann@gmx.de>
Subject: LIB_PATH for cross compiling
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi!

I cross compile from i386 to ppc. If I compile a simple C program, the
linker searchs the libc.so.6 in the /lib path instead of the
/usr/local/powerpc-linux/lib. If I specify the path explicit, it works.

I've tried to make changes in binutils/ld/Makefile and
binutils/ld/genscripts, but found no solution.

How can I change the search path of the linker so that I can simply replace
gcc with powerpc-linux-gcc for simple programs?

I know the question has been asked several times before, but I've not found
an answer in the mailing list that I can use.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
