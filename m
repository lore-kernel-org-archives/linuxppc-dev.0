Message-ID: <000c01bfb251$0591a770$e50102c8@d-pengl-229.sc.mcel.mot.com>
From: "Rolf Liu" <rolfl@sc.mcel.mot.com>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: problems with compiling glibc-2.1.3
Date: Sat, 29 Apr 2000 22:06:04 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, all,
I am compiling glibc-2.1.3 with my own
cross-compiler(powerpc-linux-gcc-2.95.2.
I have configured the glibc.
During the compiling , there comes such error message,
powerpc-linux-gcc
../sysdeps/powerpc/dl-machine.c -c -O -Wall -Winline -Wstrict-
prototypes -Wwrite-strings -g      -I../include -I.  -I.. -I../libio  -I../s
ysde
ps/powerpc/elf -I../crypt/sysdeps/unix -I../linuxthreads/sysdeps/unix/sysv/l
inux
 -I../linuxthreads/sysdeps/pthread -I../linuxthreads/sysdeps/unix/sysv -I../
linu
xthreads/sysdeps/unix -I../linuxthreads/sysdeps/powerpc -I../sysdeps/unix/sy
sv/l
inux/powerpc -I../sysdeps/unix/sysv/linux -I../sysdeps/gnu -I../sysdeps/unix
/com
mon -I../sysdeps/unix/mman -I../sysdeps/unix/inet -I../sysdeps/unix/sysv -I.
./sy
sdeps/unix -I../sysdeps/posix -I../sysdeps/powerpc -I../sysdeps/wordsize-32
-I..
/sysdeps/ieee754 -I../sysdeps/libm-ieee754 -I../sysdeps/generic/elf -I../sys
deps
/generic  -nostdinc -isystem
/home/lhx/lib/gcc-lib/powerpc-linux/2.95.2/include
-isystem /home/lhx/include -D_LIBC_REENTRANT -include
../include/libc-symbols.h
    -o dl-machine.o
../sysdeps/powerpc/dl-machine.c:32: #error This will not work with
versioning tu
rned off, sorry.
make[1]: *** [dl-machine.o] Error 1


thanks a lot.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
