Message-ID: <20001017210229.5208.qmail@web5201.mail.yahoo.com>
Date: Tue, 17 Oct 2000 14:02:29 -0700 (PDT)
From: Yiran Duan <yiranduan@yahoo.com>
Subject: MBX kernel compile error
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I tried to compile linux kernel for MBX board on
i686-pc-linux. The package I used to built my
cross-compiler is:

    binutils-2.10
    glibc-2.1.3
    gcc-2.95

The kernel package I used is

    linux-2.2.17

I passed make xconfig, make dep, make clean, but got
the following error at make zImage:

powerpc-linux-gcc -D__KERNEL__
-I/home/compiler/sources/linux/include -Wall
-Wstrict-prototypes -O2 -fomit-frame-pointer
-fno-strict-aliasing -D__powerpc__ -fsigned-char
-msoft-float -pipe -fno-builtin -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -mcpu=860
-D__ASSEMBLY__ -c head.S -o head.o
head.S: Assembler messages:
head.S:1829: Error: unsupported relocation type
make[1]: *** [head.o] Error 1
make[1]: Leaving directory
`/home/compiler/sources/linux/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2

Could anyone give me any idea about where I was wrong?

Thank you.
Yiran.

Yahoo! Messenger - Talk while you surf!  It's FREE.
http://im.yahoo.com/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
