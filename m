Message-ID: <38FF33CE.7CC78547@aminocom.com>
Date: Thu, 20 Apr 2000 16:43:58 +0000
From: Elizabeth Clarke <eclarke@aminocom.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: glibc-2.1.2 cross-compile problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm having a problem compiling glibc-2.1.2 using the xppc
cross-compilation toolset. I (believe I) have followed the instructions
for patching glibc
and all seemed fine, but I get the following, any help much
appriciated!:


/opt/xppc/bin/powerpc-linux-gcc ../sysdeps/unix/sysv/linux/poll.c -c
-DNDEBUG=1 -DSOFT_FLOAT -O2 -Wall
-Winline -Wstrict-prototypes -Wwrite-strings -mcpu=860 -msoft-float
-fpic    -I../include -I.  -I.. -I../libio  -I../sysdeps/powerpc/elf
-I../linuxthreads/sysdeps/unix/sysv/linux
-I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv
-I../linuxthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc
-I../sysdeps/unix/sysv/linux/powerpc -I../sysdeps/unix/sysv/linux
-I../sysdeps/gnu -I../sysdeps/unix/common -I../sysdeps/unix/mman
-I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I../sysdeps/unix
-I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I../sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf
-I../sysdeps/generic  -nostdinc -isystem
/opt/xppc/lib/gcc-lib/powerpc-linux/egcs-2.91.66/include -isystem
/usr/local/amino/module3/linux/linux/include -D_LIBC_REENTRANT -include
../include/libc-symbols.h  -DPIC   -o poll.os
../sysdeps/unix/bsd/poll.c: In function `__emulate_poll':
In file included from ../sysdeps/unix/sysv/linux/poll.c:62:
../sysdeps/unix/bsd/poll.c:194: internal error--insn does not satisfy
its constraints:
(insn 1390 183 187 (set (reg:SI 12 r12)
        (unspec[
                (symbol_ref:SI ("@max_fd_size.39"))
                (reg:SI 65 lr)
            ]  8)) 398 {*movsi_got_internal} (nil)
    (nil))
toplev.c:1367: Internal compiler error in function
fatal_insn


Thanks
Beth

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
