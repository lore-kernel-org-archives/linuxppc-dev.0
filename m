Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17644.63105.27596.85261@cargo.ozlabs.ibm.com>
Date: Thu, 24 Aug 2006 10:44:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: gregkh@suse.de, linuxppc-dev@ozlabs.org
Subject: Please pull powerpc.git 'merge' branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Greg,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get another set of PowerPC updates for 2.6.18.

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8540ads.dts              |  257 +++++++++++++++++
 arch/powerpc/boot/dts/mpc8541cds.dts              |  244 ++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts              |  287 +++++++++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts              |  244 ++++++++++++++++
 arch/powerpc/kernel/legacy_serial.c               |    8 -
 arch/powerpc/kernel/prom_parse.c                  |   13 -
 arch/powerpc/kernel/time.c                        |   25 +-
 arch/powerpc/kernel/traps.c                       |    8 -
 arch/powerpc/mm/hugetlbpage.c                     |    2 
 arch/powerpc/platforms/85xx/Kconfig               |    1 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |  162 ++++-------
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |  210 ++++++--------
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h        |   32 --
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |  324 +++++++++++----------
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   73 ++---
 arch/powerpc/platforms/powermac/bootx_init.c      |   15 +
 arch/powerpc/sysdev/fsl_soc.c                     |   30 +-
 arch/powerpc/sysdev/tsi108_dev.c                  |   10 -
 arch/powerpc/sysdev/tsi108_pci.c                  |   21 +
 include/asm-powerpc/pgalloc.h                     |    2 
 include/asm-powerpc/system.h                      |    9 +
 include/asm-powerpc/tsi108.h                      |   14 +
 include/asm-powerpc/tsi108_irq.h                  |  124 ++++++++
 23 files changed, 1593 insertions(+), 522 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8540ads.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8541cds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8555cds.dts
 create mode 100644 include/asm-powerpc/tsi108_irq.h

Adam Litke:
      [POWERPC] hugepage BUG fix

Andy Fleming:
      [POWERPC] Fix interrupts on 8540 ADS board
      [POWERPC] Fix CDS IRQ handling and PCI code
      [POWERPC] Add 85xx DTS files to powerpc
      [POWERPC] Fix FEC node in 8540 ADS dts

Benjamin Herrenschmidt:
      [POWERPC] Fix BootX booting with an initrd

Jon Loeliger:
      [POWERPC] Rewrite the PPC 86xx IRQ handling to use Flat Device Tree

Li Yang:
      [POWERPC] Fix compile problem without CONFIG_PCI

Nathan Lynch:
      [POWERPC] Fix gettimeofday inaccuracies

Paul Mackerras:
      [POWERPC] Correct masks used in emulating some instructions

Zang Roy-r61911:
      [POWERPC] Update mpc7448hpc2 board irq support using device tree
      [POWERPC] Pass UPIO_TSI flag to 8259 serial driver
