Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01D08DDE20
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jan 2008 09:20:24 +1100 (EST)
Date: Mon, 28 Jan 2008 16:17:52 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.25' branch (updated)
Message-ID: <Pine.LNX.4.64.0801281617160.28018@blarg.am.freescale.net>
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

Please pull from 'for-2.6.25' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.25

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt |  177 ++-
 arch/powerpc/boot/Makefile                   |    5
 arch/powerpc/boot/cuboot-85xx-cpm2.c         |   66 +
 arch/powerpc/boot/dts/mpc8313erdb.dts        |  156 +-
 arch/powerpc/boot/dts/mpc8315erdb.dts        |  287 +++++
 arch/powerpc/boot/dts/mpc832x_mds.dts        |  270 ++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |  177 +--
 arch/powerpc/boot/dts/mpc8349emitx.dts       |  159 +-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |  113 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts        |  260 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts        |  287 ++---
 arch/powerpc/boot/dts/mpc8377_mds.dts        |  141 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts        |  296 +++++
 arch/powerpc/boot/dts/mpc8378_mds.dts        |  133 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts        |  282 ++++
 arch/powerpc/boot/dts/mpc8379_mds.dts        |  149 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts        |  310 +++++
 arch/powerpc/boot/dts/mpc8568mds.dts         |   24
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  227 ++--
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |  333 ++---
 arch/powerpc/boot/dts/sbc8349.dts            |  244 ++++
 arch/powerpc/boot/dts/sbc8548.dts            |  244 ++++
 arch/powerpc/boot/dts/sbc8560.dts            |  330 +++++
 arch/powerpc/boot/dts/storcenter.dts         |   73 -
 arch/powerpc/boot/dts/stx_gp3_8560.dts       |  228 ++++
 arch/powerpc/boot/dts/tqm8540.dts            |  204 +++
 arch/powerpc/boot/dts/tqm8541.dts            |  228 ++++
 arch/powerpc/boot/dts/tqm8555.dts            |  228 ++++
 arch/powerpc/boot/dts/tqm8560.dts            |  245 ++++
 arch/powerpc/boot/libfdt-wrapper.c           |    9
 arch/powerpc/boot/ops.h                      |   11
 arch/powerpc/configs/mpc8313_rdb_defconfig   |    2
 arch/powerpc/configs/mpc8315_rdb_defconfig   | 1417 +++++++++++++++++++++++++
 arch/powerpc/configs/mpc837x_rdb_defconfig   |  887 +++++++++++++++
 arch/powerpc/configs/mpc83xx_defconfig       |  887 +++++++++++++++
 arch/powerpc/configs/mpc85xx_defconfig       | 1523 +++++++++++++++++++++++++++
 arch/powerpc/configs/sbc834x_defconfig       |  800 ++++++++++++++
 arch/powerpc/configs/sbc8548_defconfig       |  741 +++++++++++++
 arch/powerpc/configs/sbc8560_defconfig       |  764 +++++++++++++
 arch/powerpc/configs/stx_gp3_defconfig       | 1183 ++++++++++++++++++++
 arch/powerpc/configs/tqm8540_defconfig       | 1032 ++++++++++++++++++
 arch/powerpc/configs/tqm8541_defconfig       | 1044 ++++++++++++++++++
 arch/powerpc/configs/tqm8555_defconfig       | 1044 ++++++++++++++++++
 arch/powerpc/configs/tqm8560_defconfig       | 1044 ++++++++++++++++++
 arch/powerpc/kernel/legacy_serial.c          |   45
 arch/powerpc/kernel/misc_32.S                |   10
 arch/powerpc/platforms/82xx/mpc8272_ads.c    |    5
 arch/powerpc/platforms/82xx/pq2fads.c        |    5
 arch/powerpc/platforms/83xx/Kconfig          |   62 -
 arch/powerpc/platforms/83xx/Makefile         |    4
 arch/powerpc/platforms/83xx/mpc8313_rdb.c    |  101 -
 arch/powerpc/platforms/83xx/mpc831x_rdb.c    |   93 +
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |   11
 arch/powerpc/platforms/83xx/mpc832x_rdb.c    |   11
 arch/powerpc/platforms/83xx/mpc836x_mds.c    |   11
 arch/powerpc/platforms/83xx/mpc837x_rdb.c    |   99 +
 arch/powerpc/platforms/83xx/sbc834x.c        |  115 ++
 arch/powerpc/platforms/83xx/usb.c            |    4
 arch/powerpc/platforms/85xx/Kconfig          |   87 +
 arch/powerpc/platforms/85xx/Makefile         |    4
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |   32
 arch/powerpc/platforms/85xx/sbc8548.c        |  167 ++
 arch/powerpc/platforms/85xx/sbc8560.c        |  283 +++++
 arch/powerpc/platforms/85xx/stx_gp3.c        |  183 +++
 arch/powerpc/platforms/85xx/tqm85xx.c        |  187 +++
 arch/powerpc/platforms/8xx/ep88xc.c          |    5
 arch/powerpc/platforms/8xx/m8xx_setup.c      |   11
 arch/powerpc/platforms/8xx/mpc86xads_setup.c |    8
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |    7
 arch/powerpc/platforms/8xx/mpc8xx.h          |   21
 arch/powerpc/platforms/Kconfig               |    6
 arch/powerpc/platforms/Kconfig.cputype       |   10
 arch/powerpc/platforms/embedded6xx/ls_uart.c |    5
 arch/powerpc/sysdev/Makefile                 |    4
 arch/powerpc/sysdev/commproc.c               |  650 -----------
 arch/powerpc/sysdev/commproc.h               |   12
 arch/powerpc/sysdev/cpm1.c                   |  612 ++++++++++
 arch/powerpc/sysdev/cpm2.c                   |  469 ++++++++
 arch/powerpc/sysdev/cpm2_common.c            |  470 --------
 arch/powerpc/sysdev/fsl_soc.c                |   99 +
 arch/powerpc/sysdev/ipic.c                   |    6
 arch/powerpc/sysdev/micropatch.c             |    2
 arch/powerpc/sysdev/mpc8xx_pic.c             |    1
 arch/powerpc/sysdev/qe_lib/qe.c              |   63 -
 arch/ppc/8260_io/enet.c                      |    2
 arch/ppc/8xx_io/commproc.c                   |   40
 arch/ppc/8xx_io/enet.c                       |    6
 arch/ppc/8xx_io/fec.c                        |    2
 arch/ppc/8xx_io/micropatch.c                 |    2
 arch/ppc/Kconfig                             |   91 -
 arch/ppc/Makefile                            |    9
 arch/ppc/boot/simple/iic.c                   |    2
 arch/ppc/boot/simple/m8xx_tty.c              |    2
 arch/ppc/configs/TQM8540_defconfig           |  973 -----------------
 arch/ppc/configs/TQM8541_defconfig           |  986 -----------------
 arch/ppc/configs/TQM8555_defconfig           |  983 -----------------
 arch/ppc/configs/TQM8560_defconfig           |  992 -----------------
 arch/ppc/configs/mpc834x_sys_defconfig       |  844 --------------
 arch/ppc/configs/mpc8540_ads_defconfig       |  706 ------------
 arch/ppc/configs/mpc8548_cds_defconfig       |  658 -----------
 arch/ppc/configs/mpc8555_cds_defconfig       |  784 -------------
 arch/ppc/configs/mpc8560_ads_defconfig       |  769 -------------
 arch/ppc/configs/stx_gp3_defconfig           |  989 -----------------
 arch/ppc/kernel/Makefile                     |    1
 arch/ppc/kernel/asm-offsets.c                |    6
 arch/ppc/kernel/entry.S                      |   12
 arch/ppc/kernel/head_booke.h                 |   55
 arch/ppc/kernel/head_fsl_booke.S             | 1065 ------------------
 arch/ppc/kernel/misc.S                       |   46
 arch/ppc/kernel/ppc_ksyms.c                  |   11
 arch/ppc/kernel/setup.c                      |    3
 arch/ppc/kernel/traps.c                      |  121 --
 arch/ppc/mm/Makefile                         |    1
 arch/ppc/mm/fsl_booke_mmu.c                  |  236 ----
 arch/ppc/mm/init.c                           |    6
 arch/ppc/mm/mmu_context.c                    |    2
 arch/ppc/mm/mmu_decl.h                       |    6
 arch/ppc/mm/pgtable.c                        |   28
 arch/ppc/mm/ppc_mmu.c                        |    2
 arch/ppc/platforms/83xx/Makefile             |    4
 arch/ppc/platforms/83xx/mpc834x_sys.c        |  346 ------
 arch/ppc/platforms/83xx/mpc834x_sys.h        |   54
 arch/ppc/platforms/85xx/Kconfig              |  106 -
 arch/ppc/platforms/85xx/Makefile             |   13
 arch/ppc/platforms/85xx/mpc8540_ads.c        |  226 ----
 arch/ppc/platforms/85xx/mpc8540_ads.h        |   22
 arch/ppc/platforms/85xx/mpc8555_cds.h        |   23
 arch/ppc/platforms/85xx/mpc8560_ads.c        |  303 -----
 arch/ppc/platforms/85xx/mpc8560_ads.h        |   24
 arch/ppc/platforms/85xx/mpc85xx_ads_common.c |  197 ---
 arch/ppc/platforms/85xx/mpc85xx_ads_common.h |   67 -
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c |  601 ----------
 arch/ppc/platforms/85xx/mpc85xx_cds_common.h |   80 -
 arch/ppc/platforms/85xx/sbc8560.c            |  234 ----
 arch/ppc/platforms/85xx/sbc8560.h            |   47
 arch/ppc/platforms/85xx/sbc85xx.c            |  166 --
 arch/ppc/platforms/85xx/sbc85xx.h            |   70 -
 arch/ppc/platforms/85xx/stx_gp3.c            |  339 ------
 arch/ppc/platforms/85xx/stx_gp3.h            |   69 -
 arch/ppc/platforms/85xx/tqm85xx.c            |  412 -------
 arch/ppc/platforms/85xx/tqm85xx.h            |   53
 arch/ppc/platforms/mpc866ads_setup.c         |    2
 arch/ppc/platforms/mpc885ads_setup.c         |    2
 arch/ppc/syslib/Makefile                     |   13
 arch/ppc/syslib/ipic.c                       |  646 -----------
 arch/ppc/syslib/ipic.h                       |   47
 arch/ppc/syslib/mpc83xx_devices.c            |  251 ----
 arch/ppc/syslib/mpc83xx_sys.c                |  122 --
 arch/ppc/syslib/mpc85xx_devices.c            |  826 --------------
 arch/ppc/syslib/mpc85xx_sys.c                |  233 ----
 arch/ppc/syslib/mpc8xx_devices.c             |    2
 arch/ppc/syslib/ocp.c                        |    2
 arch/ppc/syslib/open_pic.c                   |    2
 arch/ppc/syslib/ppc83xx_pci.h                |  151 --
 arch/ppc/syslib/ppc83xx_setup.c              |  410 -------
 arch/ppc/syslib/ppc83xx_setup.h              |   55
 arch/ppc/syslib/ppc85xx_common.c             |   38
 arch/ppc/syslib/ppc85xx_common.h             |   22
 arch/ppc/syslib/ppc85xx_setup.c              |  367 ------
 arch/ppc/syslib/ppc85xx_setup.h              |   56
 arch/ppc/syslib/ppc8xx_pic.h                 |    1
 arch/ppc/xmon/start_8xx.c                    |    2
 drivers/ata/Kconfig                          |    2
 drivers/net/Kconfig                          |    2
 drivers/net/fec_8xx/fec_8xx-netta.c          |    2
 drivers/net/fec_8xx/fec_main.c               |    2
 drivers/net/fec_8xx/fec_mii.c                |    2
 drivers/net/fs_enet/fs_enet.h                |    2
 drivers/net/fs_enet/mac-fec.c                |    2
 drivers/net/fs_enet/mac-scc.c                |    2
 drivers/net/ucc_geth_mii.c                   |    3
 drivers/pci/Makefile                         |    2
 drivers/serial/cpm_uart/cpm_uart_cpm1.h      |    2
 drivers/spi/spi_mpc83xx.c                    |    6
 include/asm-powerpc/commproc.h               |  752 -------------
 include/asm-powerpc/cpm.h                    |   73 +
 include/asm-powerpc/cpm1.h                   |  685 ++++++++++++
 include/asm-powerpc/cpm2.h                   |   64 -
 include/asm-powerpc/irq.h                    |  212 ---
 include/asm-powerpc/mpc8xx.h                 |   20
 include/asm-ppc/commproc.h                   |  692 ------------
 include/asm-ppc/cpm1.h                       |  688 ++++++++++++
 include/asm-ppc/cpm2.h                       |    2
 include/asm-ppc/immap_85xx.h                 |  126 --
 include/asm-ppc/mmu_context.h                |    5
 include/asm-ppc/mpc83xx.h                    |  107 -
 include/asm-ppc/mpc85xx.h                    |  192 ---
 include/asm-ppc/pgtable.h                    |   46
 include/asm-ppc/ppc_sys.h                    |    4
 include/asm-ppc/ppcboot.h                    |    8
 include/asm-ppc/reg_booke.h                  |   26
 include/asm-ppc/serial.h                     |    4
 192 files changed, 21067 insertions(+), 22059 deletions(-)

Anton Vorontsov (4):
      [POWERPC] QE: get rid of most device_types and model
      ucc_geth: get rid of device_type for mdio
      spi_mpc83xx: use brg-frequency for SPI in QE
      [POWERPC] fsl_spi: stop using device_type = "spi"

Grant Likely (1):
      [POWERPC] 82xx and embedded6xx: Use machine_*_initcall() hooks in platform code

Jochen Friedrich (7):
      [POWERPC] 8xx: Remove unused m8xx_cpm_hostalloc/free/dump()
      [POWERPC] 8xx: Rename m8xx_pic_init to mpc8xx_pics_init
      [POWERPC] 8xx: Remove unneeded and misspelled prototype m8xx_calibrate_decr
      [POWERPC] 8xx: Remove sysdev/commproc.h
      [POWERPC] 8xx: Get rid of conditional includes of board specific setup
      [POWERPC] CPM: Rename commproc to cpm1 and cpm2_common.c to cpm2.c
      [POWERPC] CPM: Move definition of buffer descriptor to cpm.h

Jon Loeliger (2):
      [POWERPC] 86xx: Convert all 86xx DTS files to /dts-v1/ format.
      [POWERPC] Convert StorCenter DTS file to /dts-v1/ format.

Kim Phillips (10):
      [POWERPC] 83xx: fold the mpc8313 platform into the mpc831x platform
      [POWERPC] 83xx: add base platform support for the mpc8315 rdb board
      [POWERPC] 83xx: Add the MPC8315E RDB dts
      [POWERPC] 83xx: enable FSL SATA driver config for Freescale SoCs
      [POWERPC] 83xx: ipic: add interrupt vector 94
      [POWERPC] 83xx: add the mpc8315 rdb defconfig
      [POWERPC] 83xx: add MPC837x RDB platform support
      [POWERPC] 83xx: add the mpc837[789]_rdb dts files
      [POWERPC] 83xx: add the mpc837x rdb defconfig
      [POWERPC] 83xx: Fix typo in mpc837x compatible entries

Kumar Gala (13):
      [POWERPC] Always build setup-bus.c on powerpc
      [POWERPC] bootwrapper: Add find_node_by_compatible
      [POWERPC] Add a cuboot wrapper for 85xx with CPM2
      [POWERPC] 85xx: Port STX GP3 board over from arch/ppc
      [POWERPC] 85xx: Port TQM85xx boards over from arch/ppc
      [POWERPC] 85xx: some minor cleanups for stx_gp3 and tqm85xx
      [PPC] Remove 83xx from arch/ppc
      [PPC] Remove 85xx from arch/ppc
      [POWERPC] 86xx: Remove unused IRQ defines
      [POWERPC] 85xx: rework platform Kconfig
      [POWERPC] 83xx: rework platform Kconfig
      [POWERPC] 85xx: convert sbc85* boards to use machine_device_initcall
      [POWERPC] 85xx: Only invalidate TLB0 and TLB1

Li Yang (1):
      [POWERPC] Add docs for Freescale PowerQUICC SATA device tree nodes

Paul Gortmaker (14):
      [POWERPC] Reduce code duplication in legacy_serial, add UART parent types
      [POWERPC] 85xx: Add support for Wind River SBC8560 in arch/powerpc
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8560 board
      [POWERPC] CPM2: Make support for the CPM2 optional on 8560 based boards
      [POWERPC] 85xx: Add default .config file for Wind River SBC8560
      [POWERPC] 85xx: Add basic support for Wind River SBC8548 board
      [POWERPC] 85xx: Add v1 device tree source for Wind River SBC8548 board
      [POWERPC] 85xx: Add default .config file for Wind River SBC8548
      [POWERPC] 83xx: Add support for Wind River SBC834x boards
      [POWERPC] 83xx: Add device tree source for Wind River SBC834x board.
      [POWERPC] 83xx: Add default config file for Wind River SBC8349 board
      [POWERPC] 83xx: mpc834x_mds - Convert device tree source to dts-v1
      [POWERPC] QE: Explicitly set address-cells and size cells for muram
      [POWERPC] 83xx: Clean up / convert mpc83xx board DTS files to v1 format.

Zhang Wei (1):
      [POWERPC] Add docs for Freescale DMA & DMA channel device tree nodes
