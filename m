Message-Id: <200002061329.WAA27669@mail.cc.tohoku.ac.jp>
MIME-Version: 1.0
Date: Sun, 06 Feb 2000 22:29:20 +0900
From: Kazunori Aoshima <aoshimak@mail.cc.tohoku.ac.jp>
To: linuxppc-dev@lists.linuxppc.org
Subject: Error report : make clgenfb on 2.2.14
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

Error occured on last stage of kernel make.
Like this :

drivers/char/char.a(vt.o): In function `vt_ioctl':
vt.o(.text+0x1c10): undefined reference to `console_getmode'
vt.o(.text+0x1c10): relocation truncated to fit: R_PPC_REL24 console_getmode
vt.o(.text+0x1cf8): undefined reference to `console_setmode'
vt.o(.text+0x1cf8): relocation truncated to fit: R_PPC_REL24 console_setmode
vt.o(.text+0x1e5c): undefined reference to `console_setcmap'
vt.o(.text+0x1e5c): relocation truncated to fit: R_PPC_REL24 console_setcmap
vt.o(.text+0x1e74): undefined reference to `console_powermode'
vt.o(.text+0x1e74): relocation truncated to fit: R_PPC_REL24 console_powermode
make: *** [vmlinux] Error 1


Environment:
	kernel-2.2.14
with
	clgenfb 1.9.4.4
	drivers/video/vga.h (from 2.3.40)


----------------------
Kaz Aoshima = Editor of the PReP station
Material deveropment, Faculty of engineering,
Tohoku University, Japan
E-mail:aoshimak@mail.cc.tohoku.ac.jp
#I would appreciate if you could give me suggestions
 for my impolite English expressions.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
