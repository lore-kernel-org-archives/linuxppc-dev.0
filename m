Message-ID: <20020529223118.11673.qmail@web11504.mail.yahoo.com>
Date: Wed, 29 May 2002 15:31:18 -0700 (PDT)
From: Khai Trinh <kqtrinh@yahoo.com>
Subject: Where to place the text section of the kernel image
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am building the ppc kernel image for Ebony. I would
like to find out how one goes about deciding where the
place the text section of the kernel image in memory?
The output of the built had it put @0x800000. I looked
in the Makefile but couldn't find where it's
specified. More importantly, how do we decide where to
put it? The output of the makefile is shown below:

ppc_405-ld -T ../ld.script -Ttext 0x00800000 -Bstatic
-o zvmlinux head.o ../comm
on/relocate.o direct.o ../common/misc-simple.o
../common/misc-common.o ../common
/string.o ../common/util.o ../common/ns16550.o image.o
../lib/zlib.a
ppc_405-objcopy -O elf32-powerpc zvmlinux zvmlinux -R
.comment -R .stab -R .stab
str \
        -R .ramdisk -R .sysmap
cp zvmlinux ../images/zvmlinux.ebony
../utils/mktree zvmlinux ../images/zImage.ebony
0x800000

Thanks,
--Khai


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
