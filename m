Message-ID: <3A7D719C.7A0104C4@chello.nl>
Date: Sun, 04 Feb 2001 16:13:32 +0100
From: "b.stolk" <b.stolk@chello.nl>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: incomplete asm-ppc/errno.h in 2.4.1 kernel.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,


I'm trying to build 2.4.1 with reiserfs on my Motorola PowerStack II.

But: EHASHCOLLISION seems to be missing from include/asm-ppc/errno.h
It's present in asm-alpha and asm-i386

Anyone working on reiserfs support for ppc at the moment?

Here's the error:


make[3]: Entering directory `/usr/src/linux/fs/reiserfs'
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o bitmap.o bitmap.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o do_balan.o do_balan.c
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring    -c -o namei.o namei.c
namei.c: In function `reiserfs_add_entry':
namei.c:475: `EHASHCOLLISION' undeclared (first use in this function)

I will try a 2.4.1 build without reiser, to see if that works.

 Bram

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
