Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-Id: <5.1.1.6.2.20030527114004.01282240@corelis.com>
Date: Tue, 27 May 2003 11:49:51 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: "Brian S. Park" <brian@corelis.com>
Subject: getting Linux working on IBM Walnut demo board
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I'm new to embedded Linux and need help from all the gurus out there.

I'm trying to boot Linux on IBM Walnut demo board with PPC405GP.
I download ELDK, installed it on a RedHat Linx 7.3 machine.
I was able to build u-boot 3.0 which came with ELDK and it booted
successfully on my demo board.
However, when I tried to rebuild the kernel (2.4.4 which came with ELDK) it
gives me the following error.
I'm using the default configuration for Walnut board (i.e. make
rmproper;make walnut_config;make oldconfig;make dep; make pImage).

Also, the documentation on http://www.denx.de/doc/ seems a bit old (it
still talks about ppcboot instead u-boot). Are there new ocuments or FAQ's
for a newbie like me?

Any help will be appreciated.

Thank you.

ppc_4xx-gcc -D__KERNEL__
-I/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include -Wall
-Wstrict-prototypes -Os -fomit-frame-pointer -fno-strict-aliasing
-D__powerpc__ -fsigned-char -msoft-float -pipe -ffixed-r2
-Wno-uninitialized -mmultiple -mstring -mcpu=403 -g  -c -o init/main.o
init/main.c
In file included from
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/linux/raid/md.h:38,
                  from init/main.c:24:
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h: In
function `virt_to_bus':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:212:
`PCI_DRAM_OFFSET' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:212:
(Each undeclared identifier is reported only once
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:212:
for each function it appears in.)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:216:
warning: control reaches end of non-void function
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h: In
function `bus_to_virt':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:223:
`PCI_DRAM_OFFSET' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/io.h:227:
warning: control reaches end of non-void function
In file included from
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/linux/bootmem.h:8,
                  from init/main.c:29:
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `enable_dma':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:208:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `disable_dma':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:224:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `clear_dma_ff':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:239:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `set_dma_mode':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:248:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `set_dma_page':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:262:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `set_dma_addr':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:308:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `set_dma_count':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:336:
`_IO_BASE' undeclared (first use in this function)
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:
In function `get_dma_residue':
/mnt1/home/ELDK/ppc_4xx/usr/src/linux-2.4.4-2002-10-06/include/asm/dma.h:366:
`_IO_BASE' undeclared (first use in this function)
make: *** [init/main.o] Error 1


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
