Message-ID: <20000209164620.28902.qmail@web218.mail.yahoo.com>
Date: Wed, 9 Feb 2000 08:46:20 -0800 (PST)
From: Sebastien Articlaux <sebastien_articlaux@yahoo.com>
Subject: Objdump of our vmlinux.initrd- just to know if it's correct
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is what I obtain when I use Objdump.

Sections:
Idx Name  Size      VMA       LMA       File off  Algn
0 .text   0000515c  00100000  00100000  00010000  2**2
          CONTENTS, ALLOC, LOAD, READONLY, CODE
1 .rodata 000004f4  00105160  00105160  00015160  2**4
          CONTENTS, ALLOC, LOAD, READONLY, DATA
2 .data   000002f8  00106000  00106000  00016000  2**2
          CONTENTS, ALLOC, LOAD, DATA
3__ex_table00000018  001062f8  001062f8  000162f8 2**2
          CONTENTS, ALLOC, LOAD, READONLY, DATA
4 .bss    0000bf30  00107000  00107000  00017000  2**2
          ALLOC
5 image   000463f9  00000000  00000000  00017000  2**0
          CONTENTS, READONLY
6 initrd  000be255  00000000  00000000  0005d3f9  2**0
          CONTENTS, READONLY

Any comments about that? or it seems good?

I progress a lot whith your answers!!!
Thank you very much!

Sebastien ARTICLAUX

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
