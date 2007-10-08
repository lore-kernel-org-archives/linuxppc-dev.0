Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 968FBDDEE8
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 04:33:24 +1000 (EST)
Date: Mon, 8 Oct 2007 13:32:48 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.24'
Message-ID: <Pine.LNX.4.64.0710081332010.10766@blarg.am.freescale.net>
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

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt      |  243 +++++
 arch/powerpc/Kconfig                              |   14
 arch/powerpc/Kconfig.debug                        |   21
 arch/powerpc/boot/Makefile                        |    8
 arch/powerpc/boot/cpm-serial.c                    |   44
 arch/powerpc/boot/cuboot-8xx.c                    |    8
 arch/powerpc/boot/cuboot-hpc2.c                   |   48 +
 arch/powerpc/boot/cuboot-pq2.c                    |   70 -
 arch/powerpc/boot/dts/ep88xc.dts                  |  214 ++++
 arch/powerpc/boot/dts/lite5200.dts                |   10
 arch/powerpc/boot/dts/lite5200b.dts               |   62 -
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |    5
 arch/powerpc/boot/dts/mpc8272ads.dts              |  318 +++---
 arch/powerpc/boot/dts/mpc8313erdb.dts             |    4
 arch/powerpc/boot/dts/mpc8349emitx.dts            |    4
 arch/powerpc/boot/dts/mpc8349emitxgp.dts          |    4
 arch/powerpc/boot/dts/mpc834x_mds.dts             |    4
 arch/powerpc/boot/dts/mpc8568mds.dts              |  156 +--
 arch/powerpc/boot/dts/mpc8610_hpcd.dts            |  191 ++++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |    6
 arch/powerpc/boot/dts/mpc885ads.dts               |  206 ++--
 arch/powerpc/boot/dts/pq2fads.dts                 |  240 +++++
 arch/powerpc/boot/ep88xc.c                        |   54 +
 arch/powerpc/boot/fixed-head.S                    |    4
 arch/powerpc/boot/fsl-soc.c                       |   57 +
 arch/powerpc/boot/fsl-soc.h                       |    8
 arch/powerpc/boot/mpc8xx.c                        |   82 +
 arch/powerpc/boot/mpc8xx.h                        |   11
 arch/powerpc/boot/pq2.c                           |  102 ++
 arch/powerpc/boot/pq2.h                           |   11
 arch/powerpc/boot/wrapper                         |   20
 arch/powerpc/configs/ep88xc_defconfig             |  751 ++++++++++++++++
 arch/powerpc/configs/mpc8272_ads_defconfig        |  248 +++--
 arch/powerpc/configs/mpc8610_hpcd_defconfig       | 1023 ++++++++++++++++++++++
 arch/powerpc/configs/mpc885_ads_defconfig         |  297 +++---
 arch/powerpc/configs/pq2fads_defconfig            | 1003 +++++++++++++++++++++
 arch/powerpc/kernel/Makefile                      |    2
 arch/powerpc/kernel/head_32.S                     |   16
 arch/powerpc/kernel/head_8xx.S                    |   10
 arch/powerpc/kernel/head_fsl_booke.S              |   76 -
 arch/powerpc/kernel/softemu8xx.c                  |  202 ++++
 arch/powerpc/kernel/traps.c                       |    6
 arch/powerpc/kernel/udbg.c                        |    2
 arch/powerpc/kernel/vdso32/.gitignore             |    1
 arch/powerpc/kernel/vdso64/.gitignore             |    1
 arch/powerpc/mm/fsl_booke_mmu.c                   |    2
 arch/powerpc/mm/init_32.c                         |    3
 arch/powerpc/platforms/82xx/Kconfig               |   24
 arch/powerpc/platforms/82xx/Makefile              |    6
 arch/powerpc/platforms/82xx/mpc8272_ads.c         |  196 ++++
 arch/powerpc/platforms/82xx/mpc82xx.c             |  109 --
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |  631 -------------
 arch/powerpc/platforms/82xx/pq2.c                 |   82 +
 arch/powerpc/platforms/82xx/pq2.h                 |   20
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c      |  195 ++++
 arch/powerpc/platforms/82xx/pq2ads.h              |    8
 arch/powerpc/platforms/82xx/pq2fads.c             |  198 ++++
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |    2
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    4
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    4
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    2
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    2
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    4
 arch/powerpc/platforms/85xx/Kconfig               |    2
 arch/powerpc/platforms/85xx/Makefile              |    1
 arch/powerpc/platforms/85xx/misc.c                |   55 -
 arch/powerpc/platforms/85xx/mpc85xx.h             |   17
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    6
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   23
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   23
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   42
 arch/powerpc/platforms/86xx/Kconfig               |   13
 arch/powerpc/platforms/86xx/Makefile              |    1
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c        |  216 ++++
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h        |   21
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   23
 arch/powerpc/platforms/8xx/Kconfig                |   28
 arch/powerpc/platforms/8xx/Makefile               |    1
 arch/powerpc/platforms/8xx/ep88xc.c               |  176 +++
 arch/powerpc/platforms/8xx/m8xx_setup.c           |   90 -
 arch/powerpc/platforms/8xx/mpc86xads.h            |    3
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |   10
 arch/powerpc/platforms/8xx/mpc885ads.h            |   41
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |  460 +++------
 arch/powerpc/platforms/Kconfig                    |   15
 arch/powerpc/platforms/embedded6xx/Kconfig        |    1
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    2
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2
 arch/powerpc/sysdev/Makefile                      |    1
 arch/powerpc/sysdev/commproc.c                    |  279 +++++-
 arch/powerpc/sysdev/commproc.h                    |   12
 arch/powerpc/sysdev/cpm2_common.c                 |  176 +++
 arch/powerpc/sysdev/cpm2_pic.c                    |    2
 arch/powerpc/sysdev/cpm_common.c                  |  205 ++++
 arch/powerpc/sysdev/fsl_pci.c                     |    5
 arch/powerpc/sysdev/fsl_soc.c                     |   80 +
 arch/powerpc/sysdev/fsl_soc.h                     |    1
 arch/powerpc/sysdev/mpc8xx_pic.c                  |   19
 arch/powerpc/sysdev/qe_lib/qe.c                   |   36
 arch/powerpc/sysdev/qe_lib/qe_ic.c                |   31
 arch/powerpc/sysdev/qe_lib/qe_io.c                |   38
 arch/powerpc/sysdev/qe_lib/ucc.c                  |  270 ++---
 arch/powerpc/sysdev/qe_lib/ucc_fast.c             |  127 +-
 arch/powerpc/sysdev/qe_lib/ucc_slow.c             |   48 -
 drivers/net/ucc_geth.c                            |    2
 drivers/net/ucc_geth.h                            |    1
 drivers/serial/cpm_uart/cpm_uart.h                |   48 -
 drivers/serial/cpm_uart/cpm_uart_core.c           |  539 ++++++++---
 drivers/serial/cpm_uart/cpm_uart_cpm1.c           |   18
 drivers/serial/cpm_uart/cpm_uart_cpm1.h           |   16
 drivers/serial/cpm_uart/cpm_uart_cpm2.c           |   24
 drivers/serial/cpm_uart/cpm_uart_cpm2.h           |   16
 include/asm-powerpc/commproc.h                    |   65 +
 include/asm-powerpc/cpm.h                         |   14
 include/asm-powerpc/cpm2.h                        |   26
 include/asm-powerpc/cputable.h                    |   10
 include/asm-powerpc/fs_pd.h                       |   38
 include/asm-powerpc/immap_86xx.h                  |   86 +
 include/asm-powerpc/immap_cpm2.h                  |    4
 include/asm-powerpc/immap_qe.h                    |   35
 include/asm-powerpc/qe.h                          |  243 +++--
 include/asm-powerpc/qe_ic.h                       |   68 +
 include/asm-powerpc/ucc.h                         |   40
 include/asm-powerpc/ucc_slow.h                    |    9
 include/asm-powerpc/udbg.h                        |    1
 include/linux/pci_ids.h                           |    1
 126 files changed, 8477 insertions(+), 2788 deletions(-)

Anton Vorontsov (8):
      [POWERPC] fsl_soc: fix uninitialized i2c_board_info structure
      [POWERPC] MPC8568E-MDS: add support for ds1374 rtc
      [POWERPC] mpc8568mds.dts: fix PCIe I/O address space location and size
      [POWERPC] mpc85xx_mds: select QUICC_ENGINE
      [POWERPC] QEIC: Implement pluggable handlers, fix MPIC cascading
      [POWERPC] QE: pario - support for MPC85xx layout
      [POWERPC] 85xx: mpc8568mds - update dts to be able to use UCCs
      [POWERPC] 85xx: mpc85xx_mds - reset UCC ethernet properly

Dale Farnsworth (1):
      [POWERPC] 85xx: Failure with odd memory sizes and CONFIG_HIGHMEM

Emil Medve (1):
      [POWERPC] QE: Added missing CEURNR register

Grant Likely (1):
      [POWERPC] Lite5200: Use comma delimiter format for lists in device tree

Jason Jin (1):
      [POWERPC] Treat 8610 PCIe host bridge as transparent

John Traill (1):
      [POWERPC] 8xx: Set initial memory limit.

Kumar Gala (6):
      [POWERPC] Cleaned up whitespace in head_fsl_booke.S
      [POWERPC] Fixup MPC8568 dts
      [POWERPC] Update .gitignore for new vdso generated files
      [POWERPC] FSL: Access PCIe LTSSM register with correct size
      [POWERPC] Use for_each_ matching routinues for pci PHBs
      [POWERPC] 85xx/86xx: refactor RSTCR reset code

Peter Korsgaard (5):
      [POWERPC] fsl_soc: Fix trivial printk typo.
      [POWERPC] fsl_soc: rtc-ds1307 support
      [POWERPC] spi: Use fsl_spi instead of mpc83xx_spi
      [POWERPC] spi: mode should be "cpu-qe" instead of "qe"
      [POWERPC] spi: Support non-QE processors

Roy Zang (1):
      [POWERPC] bootwrapper: adds cuboot for MPC7448HPC2 platform

Scott Wood (27):
      [POWERPC] CPM: Change from fsl,brg-frequency to brg/clock-frequency
      [POWERPC] Introduce new CPM device bindings.
      [POWERPC] Add early debug console for CPM serial ports.
      [POWERPC] bootwrapper: Support all-in-one PCI nodes in cuboot-pq2.
      [POWERPC] bootwrapper: Add fsl_get_immr() and 8xx/pq2 clock functions.
      [POWERPC] bootwrapper: Use fsl_get_immr() in cuboot-pq2.c.
      [POWERPC] cpm_uart: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.
      [POWERPC] cpm_uart: sparse fixes
      [POWERPC] cpm_uart: Issue STOP_TX command before initializing console.
      [POWERPC] 8xx: Fix CONFIG_PIN_TLB.
      [POWERPC] 8xx: Infrastructure code cleanup.
      [POWERPC] 8xx: Add pin and clock setting functions.
      [POWERPC] 8xx: Work around CPU15 erratum.
      [POWERPC] cpm2: Infrastructure code cleanup.
      [POWERPC] cpm2: Add SCCs to cpm2_clk_setup(), and cpm2_smc_clk_setup().
      [POWERPC] cpm2: Add cpm2_set_pin().
      [POWERPC] mpc82xx: Define CPU_FTR_NEED_COHERENT
      [POWERPC] mpc82xx: Remove a bunch of cruft that duplicates generic functionality.
      [POWERPC] mpc82xx: Rename mpc82xx_ads to mpc8272_ads.
      [POWERPC] mpc8272ads: Change references from 82xx_ADS to 8272_ADS.
      [POWERPC] Document local bus nodes in the device tree, and update cuboot-pq2.
      [POWERPC] 8xx: mpc885ads cleanup
      [POWERPC] 8xx/wrapper: Embedded Planet EP88xC support
      [POWERPC] mpc82xx: Update mpc8272ads, and factor out PCI and reset.
      [POWERPC] mpc82xx: Add pq2fads board support.
      [POWERPC] 8xx: Move softemu8xx.c from arch/ppc
      [POWERPC] cpm: Describe multi-user ram in its own device node.

Timur Tabi (2):
      [POWERPC] qe: miscellaneous code improvements and fixes to the QE library
      [POWERPC] 86xx: update immap_86xx.h for the 8610

Xianghua Xiao (2):
      [POWERPC] Add initial MPC8610 HPCD Device Tree Source file.
      [POWERPC] Add initial MPC8610 HPCD Platform files.
