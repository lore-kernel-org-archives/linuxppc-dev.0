Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17801.3873.941944.129198@cargo.ozlabs.ibm.com>
Date: Wed, 20 Dec 2006 21:23:29 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some bug fixes for powerpc, plus a documentation update and a
defconfig update, as listed below.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |   19 +
 arch/powerpc/boot/Makefile                   |    3 
 arch/powerpc/configs/cell_defconfig          |  358 +++++++++++++++++++++++---
 arch/powerpc/kernel/of_platform.c            |    1 
 arch/powerpc/kernel/pci_64.c                 |    1 
 arch/powerpc/kernel/prom_parse.c             |   15 +
 arch/powerpc/kernel/signal_32.c              |   16 +
 arch/powerpc/platforms/Makefile              |    2 
 arch/powerpc/platforms/cell/io-workarounds.c |    2 
 arch/powerpc/platforms/cell/spu_priv1_mmio.c |   95 ++++---
 arch/powerpc/platforms/iseries/Kconfig       |    2 
 drivers/block/viodasd.c                      |    6 
 drivers/cdrom/viocd.c                        |    4 
 drivers/char/viocons.c                       |    7 +
 drivers/char/viotape.c                       |    5 
 drivers/net/iseries_veth.c                   |    9 -
 include/asm-powerpc/spu.h                    |    2 
 17 files changed, 441 insertions(+), 106 deletions(-)

Arnd Bergmann (4):
      [POWERPC] cell: update cell_defconfig
      [POWERPC] cell: add forward struct declarations to spu.h
      [POWERPC] spufs: fix assignment of node numbers
      [POWERPC] powerpc: add scanning of ebc bus to of_platform

Benjamin Herrenschmidt (3):
      [POWERPC] cell: Fix spufs with "new style" device-tree
      [POWERPC] Workaround oldworld OF bug with IRQs & P2P bridges
      [POWERPC] Fix build of cell zImage.initrd

David Woodhouse (1):
      [POWERPC] Probe Efika platform before CHRP.

Jens Osterkamp (1):
      [POWERPC] cell: Enable spider workarounds on all PCI buses

Linas Vepstas (1):
      [POWERPC] Fix PCI device channel state initialization

Paul Mackerras (1):
      [POWERPC] Fix register save area alignment for swapcontext syscall

Stephen Rothwell (6):
      [POWERPC] iSeries: fix viodasd init
      [POWERPC] iSeries: fix viotape init
      [POWERPC] iSeries: fix iseries_veth init
      [POWERPC] iSeries: fix viocd init
      [POWERPC] iSeries: fix viocons init
      [POWERPC] iSeries: fix CONFIG_VIOPATH dependency

Vitaly Wool (1):
      [POWERPC] Update MTD OF documentation
