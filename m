Message-ID: <001001c3b8a4$f8beff80$4844900a@hydingnb1>
From: "hyding" <nari_dhy@nari-china.com>
To: "linuxppc-embed" <linuxppc-embedded@lists.linuxppc.org>
Subject: gcc-3.3.1-glibc-2.3.2-binutils-2.14 cross compile kernel problems
Date: Tue, 2 Dec 2003 15:21:58 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi,
    I have built cross-toolchain with gcc-3.3.1, binutils-2.14,
glibc-2.3.2 and linux-2.4.18 header files. I have succeeded in compiling
a test program with gcc into a static app. This test program runs well
in the target. But i failed to build kernel with gcc. The info is as
follow:

powerpc-ml300-linux-gnu-gcc -D__KERNEL__ -I/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -I/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/arch/ppc -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring -Wa,-m405   -DKBUILD_BASENAME=main -c -o init/main.o init/main.c
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h: In function `init':
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:413: error: asm-specifier for variable `__sc_5' conflicts with asm clobber list
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:412: error: asm-specifier for variable `__sc_5'
...
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h: In function `write':
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:408: error: asm-specifier for variable `__sc_4' conflicts with asm clobber list
....
/home/user/embedded-linux/src/crosstool-0.25/build/powerpc-ml300-linux-gnu/gcc-3.3.1-glibc-2.3.2/linux-2.4.18/include/asm/unistd.h:416: confused by earlier errors, bailing out
make: *** [init/main.o] Error 1

Thanks.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
