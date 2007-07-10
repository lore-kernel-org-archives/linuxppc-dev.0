Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5013EDDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 15:42:34 +1000 (EST)
Date: Tue, 10 Jul 2007 00:42:21 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for_paulus' branch
Message-ID: <Pine.LNX.4.64.0707100042120.6913@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt |   32 ++
 arch/powerpc/boot/dts/mpc8272ads.dts         |   42 +--
 arch/powerpc/boot/dts/mpc832x_mds.dts        |   16 +
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |   16 +
 arch/powerpc/boot/dts/mpc8349emitx.dts       |   10
 arch/powerpc/boot/dts/mpc834x_mds.dts        |   10
 arch/powerpc/boot/dts/mpc836x_mds.dts        |   16 +
 arch/powerpc/boot/dts/mpc8540ads.dts         |  147 ++++++-----
 arch/powerpc/boot/dts/mpc8541cds.dts         |   90 +++---
 arch/powerpc/boot/dts/mpc8544ds.dts          |   18 -
 arch/powerpc/boot/dts/mpc8548cds.dts         |  108 ++++----
 arch/powerpc/boot/dts/mpc8555cds.dts         |   90 +++---
 arch/powerpc/boot/dts/mpc8560ads.dts         |  148 ++++++-----
 arch/powerpc/boot/dts/mpc8568mds.dts         |   66 +++--
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |   50 ++-
 arch/powerpc/boot/dts/mpc866ads.dts          |   31 --
 arch/powerpc/boot/dts/mpc885ads.dts          |   54 ++--
 arch/powerpc/kernel/io.c                     |   12
 arch/powerpc/kernel/pci_32.c                 |   34 --
 arch/powerpc/kernel/pci_64.c                 |    9
 arch/powerpc/mm/hash_native_64.c             |    2
 arch/powerpc/mm/stab.c                       |    4
 arch/powerpc/platforms/52xx/efika.c          |    4
 arch/powerpc/platforms/52xx/lite5200.c       |    2
 arch/powerpc/platforms/52xx/mpc52xx_pm.c     |    8
 arch/powerpc/platforms/83xx/Makefile         |    2
 arch/powerpc/platforms/83xx/mpc8313_rdb.c    |    1
 arch/powerpc/platforms/83xx/mpc834x_itx.c    |    2
 arch/powerpc/platforms/83xx/mpc834x_mds.c    |   49 ---
 arch/powerpc/platforms/83xx/mpc83xx.h        |   28 +-
 arch/powerpc/platforms/83xx/usb.c            |  181 +++++++++++++
 arch/powerpc/platforms/85xx/misc.c           |   32 ++
 arch/powerpc/platforms/85xx/mpc8544_ds.c     |   15 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c    |   22 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    |   99 ++-----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   21 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c   |   15 -
 arch/powerpc/platforms/8xx/m8xx_setup.c      |    5
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |   71 +++++
 arch/powerpc/sysdev/fsl_soc.c                |   13 +
 arch/powerpc/sysdev/mpc8xx_pic.h             |   11
 arch/powerpc/sysdev/qe_lib/ucc.c             |    2
 arch/powerpc/sysdev/qe_lib/ucc_fast.c        |    8
 arch/ppc/mm/tlb.c                            |    1
 drivers/pcmcia/Kconfig                       |   17 -
 drivers/pcmcia/m8xx_pcmcia.c                 |  351 ++++++++++++---------------
 drivers/serial/cpm_uart/cpm_uart_core.c      |    2
 include/asm-powerpc/mmu-8xx.h                |  147 +++++++++++
 include/asm-powerpc/mmu-fsl-booke.h          |   88 ++++++
 include/asm-powerpc/mmu.h                    |   10
 include/asm-powerpc/mmu_context.h            |  202 +++++++++++++++
 include/asm-powerpc/mpc8xx.h                 |    4
 include/asm-powerpc/system.h                 |    2
 include/linux/fsl_devices.h                  |    5
 54 files changed, 1591 insertions(+), 834 deletions(-)

David Gibson (2):
      [POWERPC] Split out asm-ppc/mmu.h portions for Freescale Book-E
      [POWERPC] Split out asm-ppc/mmu.h portions for PowerPC 8xx

Domen Puncer (1):
      [POWERPC] 52xx: sparse fixes

Grant Likely (1):
      [POWERPC] 83xx: Add USB support to mpc8349-mitx board port

Jon Loeliger (1):
      [POWERPC] Replace use of GET_64BIT(prop, i) with of_read_number().

Kumar Gala (6):
      [POWERPC] Reworked interrupt numbers for OpenPIC based Freescale chips
      [POWERPC] Kill pcibios_enable_resources()
      [POWERPC] Fix up interrupt senses for MPC85xx boards
      [POWERPC] Merge asm-ppc/mmu_context.h into asm-power/mmu_context.h
      [POWERPC] Move inline asm eieio to using eieio inline function
      [POWERPC] CPM_UART: Use inline function form of eieio

Laurent Pinchart (1):
      [PPC] Add linux/pagemap.h to arch/ppc/mm/tlb.c

Li Yang (2):
      [POWERPC] qe_lib: export symbols for QE driver to compile as module
      [POWERPC] 83xx: USB platform code rework

Roy Zang (4):
      [POWERPC] Document the global utilities node define and example
      [POWERPC] Fix the node index confusion for SOC
      [POWERPC] 85xx: Fix 8548CDS reset bug
      [POWERPC] Remove redundant pci_read_irq_line() function for 85xx platform

Timur Tabi (1):
      [POWERPC] Fix MAC address entries for 83xx, 85xx, and 86xx device trees

Vitaly Bordug (2):
      [POWERPC] 8xx: mpc885ads pcmcia support
      [POWERPC] dts: kill hardcoded phandles
