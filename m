Message-Id: <199909200748.AAA10294@soda.CSUA.Berkeley.EDU>
To: linuxppc-dev@lists.linuxppc.org
Subject: Profiling Code
Date: Mon, 20 Sep 1999 00:48:48 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi,

I have been trying to profile a small C program under LinuxPPC, but I
can't gprof to run. (I couldn't find prof on my box).

Bascially my make rule for profiling executes the following code:

$ gcc -pg -Wall -pedantic -o prog prog.c

This compiles just fine. When I execute the program it creates the
gmon.out file correctly. If I run gprof against this gmon.out file, I
get a seg fault:

$ gprof prog gmon.out
Segmentation fault

ldd on gprof looks okay:

$ ldd /usr/bin/gprof 
        libbfd-990418.so => /usr/lib/libbfd-990418.so (0x01753000)
        libc.so.6 => /lib/libc.so.6 (0x01611000)
        /lib/ld.so.1 => /lib/ld.so.1 (0x30000000)

I am able to build with profiling on my Solaris box and Linux x86 just
fine (for the exact same program), so I think that I'm not doing
something correctly on PPC.

If anyone has been able profile thier code under LinuxPPC, I would
appreciate some pointers.

Thanks,


----ranga <ranga@soda.berkeley.edu>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
