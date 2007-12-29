Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7331DDDFD
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 05:17:48 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBTIHh86023385
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 13:17:43 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBTIHhfw138650
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 11:17:43 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBTIHZxa019531
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 11:17:35 -0700
Date: Sat, 29 Dec 2007 12:16:42 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: Please pull from 'for-2.6.25' branch of 4xx tree
Message-ID: <20071229121642.405d2764@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from:

 master.kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git for-2.6.25

to pick up the current 4xx patches for 2.6.25.  There is a large PCI
port from Ben, some new board ports from Stefan, Valentine and Hugh, and
a handful of various fixes.  The total diff stat is large, but a lot of
it comes from new DTS and defconfig files.

josh

Benjamin Herrenschmidt (19):
      [POWERPC] Reworking machine check handling and Fix 440/440A
      [POWERPC] 4xx: Improve support for 4xx indirect DCRs
      [POWERPC] 4xx: PLB to PCI-X support
      [POWERPC] 4xx: PLB to PCI 2.x support
      [POWERPC] 4xx: PLB to PCI Express support
      [POWERPC] 4xx: PCI support for Ebony board
      [POWERPC] 4xx: Add early udbg support for 40x processors
      [POWERPC] 4xx: EP405 boards support for arch/powerpc
      [POWERPC] 4xx: Add PCI to Walnut platform
      [POWERPC] 4xx: Wire up PCI on Bamboo board
      [POWERPC] 4xx: Wire up 440EP USB controller support to Bamboo board
      [POWERPC] 4xx: Adds decoding of 440SPE memory size to boot wrapper library
      [POWERPC] 4xx: Add mfspr/mtspr inline macros to 4xx bootwrapper
      [POWERPC] 4xx: Add CPR0 accessors to boot wrapper
      [POWERPC] 4xx: Rework clock probing in boot wrapper
      [POWERPC] 4xx: Base support for 440SPe "Katmai" eval board
      [POWERPC] 4xx: remove bogus "ranges" property in Bamboo EBC node
      [POWERPC] 4xx: PCI-E Link setup improvements
      [POWERPC] pci32: 4xx embedded platforms want to reassign all PCI resources

Hugh Blemings (1):
      [POWERPC] 4xx: Base support for 440GX Taishan eval board

Josh Boyer (11):
      [POWERPC] 4xx: Fix 440grx setup function to call 440A fixup
      [POWERPC] 4xx: Include missing header
      [POWERPC] 4xx: libfdt and pci fixes for Rainier
      [POWERPC] 4xx: Rename CPU nodes to avoid dtc incompatibility
      [POWERPC] 4xx: Update Kilauea, Rainier, and Walnut defconfigs
      [POWERPC] 4xx: Mark of_bus structures as __initdata
      [POWERPC] Conditionally compile e200 and e500 platforms in cputable
      [POWERPC] Remove unneeded variable declarations from mpc837x_mds
      [POWERPC] 4xx: Use machine_device_initcall for bus probe
      [POWERPC] 4xx: Minor coding style cleanups for 4xx bootwrapper
      [POWERPC] 4xx: Update defconfigs

Stefan Roese (11):
      [POWERPC] 4xx: Add 440SPe revA runtime detection to PCIe
      [POWERPC] 4xx: Fix TLB 0 problem with CONFIG_SERIAL_TEXT_DEBUG
      [POWERPC] 4xx: Add 405EX CPU type needed for EMAC support on Kilauea
      [POWERPC] 4xx: Change Kilauea dts to support new EMAC device tree properti
      [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
      [POWERPC] 4xx: Set ibpre for 405EX in 4xx PCIe driver
      [POWERPC] 4xx: Add aliases node to 4xx dts files
      [POWERPC] 4xx: Change Kilauea PCIe bus ranges in dts file
      [POWERPC] 4xx: Add AMCC Makalu board support to platforms/40x
      [POWERPC] 4xx: Makalu dts
      [POWERPC] 4xx: Makalu defconfig

Valentine Barshak (12):
      [POWERPC] 4xx: 440EPx Sequoia USB OHCI DTS entry
      [POWERPC] 4xx: 440GRx Rainier bootwrapper.
      [POWERPC] 4xx: 440GRx Rainier DTS.
      [POWERPC] 4xx: 440GRx Rainier board support.
      [POWERPC] 4xx: 440GRx Rainier default config
      [POWERPC] 4xx: make UIC use generic level irq handler
      [POWERPC] 4xx: rework UIC cascade irq handling
      [POWERPC] 4xx: Correct 440GRx machine_check callback
      [POWERPC] 4xx: Add PCI entry to 440EPx Sequoia DTS.
      [POWERPC] 44x: Sequoia and Rainier updates for 2.6.25
      [POWERPC] 4xx: update 440EP(x)/440GR(x) identical PVR issue workaround
      [POWERPC] 4xx: Add PCI entry to 440GRx Rainier DTS.


 arch/powerpc/Kconfig                      |    1 +
 arch/powerpc/Kconfig.debug                |   19 +-
 arch/powerpc/boot/4xx.c                   |  405 ++++++--
 arch/powerpc/boot/4xx.h                   |   13 +-
 arch/powerpc/boot/Makefile                |   10 +-
 arch/powerpc/boot/bamboo.c                |    4 +-
 arch/powerpc/boot/cuboot-katmai.c         |   56 ++
 arch/powerpc/boot/cuboot-rainier.c        |   56 ++
 arch/powerpc/boot/cuboot-sequoia.c        |    2 +-
 arch/powerpc/boot/cuboot-taishan.c        |   54 +
 arch/powerpc/boot/dcr.h                   |   54 +-
 arch/powerpc/boot/dts/bamboo.dts          |   62 ++-
 arch/powerpc/boot/dts/ebony.dts           |   53 +-
 arch/powerpc/boot/dts/ep405.dts           |  228 +++++
 arch/powerpc/boot/dts/katmai.dts          |  400 ++++++++
 arch/powerpc/boot/dts/kilauea.dts         |   99 ++-
 arch/powerpc/boot/dts/makalu.dts          |  347 +++++++
 arch/powerpc/boot/dts/rainier.dts         |  353 +++++++
 arch/powerpc/boot/dts/sequoia.dts         |   49 +-
 arch/powerpc/boot/dts/taishan.dts         |  383 ++++++++
 arch/powerpc/boot/dts/walnut.dts          |   50 +-
 arch/powerpc/boot/ebony.c                 |   62 +--
 arch/powerpc/boot/ep405.c                 |   74 ++
 arch/powerpc/boot/reg.h                   |    8 +
 arch/powerpc/boot/treeboot-walnut.c       |   51 +-
 arch/powerpc/boot/wrapper                 |    2 +-
 arch/powerpc/configs/bamboo_defconfig     |   22 +-
 arch/powerpc/configs/ebony_defconfig      |    8 +-
 arch/powerpc/configs/ep405_defconfig      |  952 ++++++++++++++++++
 arch/powerpc/configs/katmai_defconfig     |  790 +++++++++++++++
 arch/powerpc/configs/kilauea_defconfig    |   53 +-
 arch/powerpc/configs/makalu_defconfig     |  812 +++++++++++++++
 arch/powerpc/configs/rainier_defconfig    |  873 ++++++++++++++++
 arch/powerpc/configs/sequoia_defconfig    |   10 +-
 arch/powerpc/configs/taishan_defconfig    |  790 +++++++++++++++
 arch/powerpc/configs/walnut_defconfig     |   94 ++-
 arch/powerpc/kernel/cpu_setup_44x.S       |   15 +-
 arch/powerpc/kernel/cputable.c            |  108 ++
 arch/powerpc/kernel/head_44x.S            |   14 +-
 arch/powerpc/kernel/head_booke.h          |    2 +-
 arch/powerpc/kernel/misc_32.S             |   39 +
 arch/powerpc/kernel/prom.c                |   37 +-
 arch/powerpc/kernel/traps.c               |   62 +-
 arch/powerpc/kernel/udbg.c                |    3 +
 arch/powerpc/kernel/udbg_16550.c          |   33 +
 arch/powerpc/platforms/40x/Kconfig        |   40 +-
 arch/powerpc/platforms/40x/Makefile       |    2 +
 arch/powerpc/platforms/40x/ep405.c        |  123 +++
 arch/powerpc/platforms/40x/kilauea.c      |   10 +-
 arch/powerpc/platforms/40x/makalu.c       |   58 ++
 arch/powerpc/platforms/40x/virtex.c       |    5 +-
 arch/powerpc/platforms/40x/walnut.c       |   11 +-
 arch/powerpc/platforms/44x/Kconfig        |   46 +-
 arch/powerpc/platforms/44x/Makefile       |    5 +-
 arch/powerpc/platforms/44x/bamboo.c       |   11 +-
 arch/powerpc/platforms/44x/ebony.c        |   10 +-
 arch/powerpc/platforms/44x/katmai.c       |   63 ++
 arch/powerpc/platforms/44x/rainier.c      |   61 ++
 arch/powerpc/platforms/44x/sequoia.c      |   11 +-
 arch/powerpc/platforms/44x/taishan.c      |   73 ++
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    5 -
 arch/powerpc/platforms/Kconfig.cputype    |    1 +
 arch/powerpc/sysdev/Kconfig               |    8 +
 arch/powerpc/sysdev/Makefile              |    3 +
 arch/powerpc/sysdev/ppc4xx_pci.c          | 1528 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/ppc4xx_pci.h          |  369 +++++++
 arch/powerpc/sysdev/uic.c                 |  117 +--
 arch/ppc/kernel/head_44x.S                |    2 +-
 arch/ppc/kernel/traps.c                   |   98 ++-
 arch/ppc/mm/44x_mmu.c                     |   51 +-
 include/asm-powerpc/cputable.h            |   13 +
 include/asm-powerpc/dcr-native.h          |   30 +-
 include/asm-powerpc/dcr-regs.h            |   71 ++
 include/asm-powerpc/ptrace.h              |    3 +-
 include/asm-powerpc/reg_booke.h           |    3 +-
 include/asm-powerpc/udbg.h                |    1 +
 include/asm-ppc/mmu.h                     |    6 +
 include/asm-ppc/reg_booke.h               |    2 +-
 78 files changed, 9952 insertions(+), 500 deletions(-)
