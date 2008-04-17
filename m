Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09A6ADE1ED
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 16:45:16 +1000 (EST)
Date: Thu, 17 Apr 2008 01:41:26 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0804170140070.23166@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

to receive the following updates:

(i've got some more patches to pull off the list, but lets get these into
your tree).

 Documentation/powerpc/booting-without-of.txt      |    6
 arch/powerpc/Kconfig                              |    5
 arch/powerpc/Kconfig.debug                        |    2
 arch/powerpc/boot/cpm-serial.c                    |  117 -
 arch/powerpc/boot/cuboot-pq2.c                    |   27
 arch/powerpc/boot/devtree.c                       |   20
 arch/powerpc/boot/dts/ep8248e.dts                 |    5
 arch/powerpc/boot/dts/mpc832x_mds.dts             |    7
 arch/powerpc/boot/dts/mpc832x_rdb.dts             |    4
 arch/powerpc/boot/dts/mpc836x_mds.dts             |    4
 arch/powerpc/boot/dts/mpc8540ads.dts              |  173 +-
 arch/powerpc/boot/dts/mpc8541cds.dts              |  161 +-
 arch/powerpc/boot/dts/mpc8544ds.dts               |  299 ++--
 arch/powerpc/boot/dts/mpc8548cds.dts              |  289 ++--
 arch/powerpc/boot/dts/mpc8555cds.dts              |  161 +-
 arch/powerpc/boot/dts/mpc8560ads.dts              |  209 +-
 arch/powerpc/boot/dts/mpc8568mds.dts              |  291 +---
 arch/powerpc/boot/dts/mpc8572ds.dts               |  383 ++---
 arch/powerpc/boot/dts/sbc8641d.dts                |  352 ++++
 arch/powerpc/boot/mpc52xx-psc.c                   |    9
 arch/powerpc/boot/ns16550.c                       |   10
 arch/powerpc/boot/ops.h                           |    1
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig   | 1395 +++++++++++++++++++
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig   | 1451 ++++++++++++++++++++
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig   | 1081 +++++++++++++++
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig   | 1233 +++++++++++++++++
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig   | 1295 ++++++++++++++++++
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig | 1222 +++++++++++++++++
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig   | 1021 ++++++++++++++
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig   | 1079 +++++++++++++++
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig   |  899 ++++++++++++
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig   |  930 +++++++++++++
 arch/powerpc/configs/83xx/sbc834x_defconfig       |  828 +++++++++++
 arch/powerpc/configs/85xx/ksi8560_defconfig       |  899 ++++++++++++
 arch/powerpc/configs/85xx/mpc8540_ads_defconfig   |  796 +++++++++++
 arch/powerpc/configs/85xx/mpc8544_ds_defconfig    | 1564 ++++++++++++++++++++++
 arch/powerpc/configs/85xx/mpc8560_ads_defconfig   |  885 ++++++++++++
 arch/powerpc/configs/85xx/mpc8568mds_defconfig    | 1117 +++++++++++++++
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig    | 1549 +++++++++++++++++++++
 arch/powerpc/configs/85xx/mpc85xx_cds_defconfig   |  935 +++++++++++++
 arch/powerpc/configs/85xx/sbc8548_defconfig       |  812 +++++++++++
 arch/powerpc/configs/85xx/sbc8560_defconfig       |  830 +++++++++++
 arch/powerpc/configs/85xx/stx_gp3_defconfig       | 1253 +++++++++++++++++
 arch/powerpc/configs/85xx/tqm8540_defconfig       | 1097 +++++++++++++++
 arch/powerpc/configs/85xx/tqm8541_defconfig       | 1109 +++++++++++++++
 arch/powerpc/configs/85xx/tqm8555_defconfig       | 1109 +++++++++++++++
 arch/powerpc/configs/85xx/tqm8560_defconfig       | 1109 +++++++++++++++
 arch/powerpc/configs/ksi8560_defconfig            |  899 ------------
 arch/powerpc/configs/mpc8313_rdb_defconfig        | 1393 -------------------
 arch/powerpc/configs/mpc8315_rdb_defconfig        | 1451 --------------------
 arch/powerpc/configs/mpc832x_mds_defconfig        | 1081 ---------------
 arch/powerpc/configs/mpc832x_rdb_defconfig        | 1233 -----------------
 arch/powerpc/configs/mpc834x_itx_defconfig        | 1295 ------------------
 arch/powerpc/configs/mpc834x_itxgp_defconfig      | 1222 -----------------
 arch/powerpc/configs/mpc834x_mds_defconfig        | 1021 --------------
 arch/powerpc/configs/mpc836x_mds_defconfig        | 1079 ---------------
 arch/powerpc/configs/mpc837x_mds_defconfig        |  899 ------------
 arch/powerpc/configs/mpc837x_rdb_defconfig        |  930 -------------
 arch/powerpc/configs/mpc83xx_defconfig            |  164 ++
 arch/powerpc/configs/mpc8540_ads_defconfig        |  796 -----------
 arch/powerpc/configs/mpc8544_ds_defconfig         | 1549 ---------------------
 arch/powerpc/configs/mpc8560_ads_defconfig        |  885 ------------
 arch/powerpc/configs/mpc8568mds_defconfig         | 1117 ---------------
 arch/powerpc/configs/mpc8572_ds_defconfig         | 1549 ---------------------
 arch/powerpc/configs/mpc85xx_cds_defconfig        |  935 -------------
 arch/powerpc/configs/sbc834x_defconfig            |  828 -----------
 arch/powerpc/configs/sbc8548_defconfig            |  812 -----------
 arch/powerpc/configs/sbc8560_defconfig            |  830 -----------
 arch/powerpc/configs/sbc8641d_defconfig           | 1342 ++++++++++++++++++
 arch/powerpc/configs/stx_gp3_defconfig            | 1253 -----------------
 arch/powerpc/configs/tqm8540_defconfig            | 1097 ---------------
 arch/powerpc/configs/tqm8541_defconfig            | 1109 ---------------
 arch/powerpc/configs/tqm8555_defconfig            | 1109 ---------------
 arch/powerpc/configs/tqm8560_defconfig            | 1109 ---------------
 arch/powerpc/kernel/entry_32.S                    |   30
 arch/powerpc/kernel/head_44x.S                    |    4
 arch/powerpc/kernel/head_booke.h                  |   33
 arch/powerpc/kernel/head_fsl_booke.S              |   10
 arch/powerpc/platforms/82xx/Kconfig               |    3
 arch/powerpc/platforms/83xx/mpc837x_rdb.c         |    1
 arch/powerpc/platforms/85xx/Kconfig               |    8
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    2
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |   13
 arch/powerpc/platforms/86xx/Kconfig               |    8
 arch/powerpc/platforms/86xx/Makefile              |    1
 arch/powerpc/platforms/86xx/sbc8641d.c            |  164 ++
 arch/powerpc/platforms/8xx/Kconfig                |    4
 arch/powerpc/platforms/Kconfig                    |    8
 arch/powerpc/sysdev/Makefile                      |    1
 arch/powerpc/sysdev/cpm1.c                        |  112 -
 arch/powerpc/sysdev/cpm2.c                        |  103 -
 arch/powerpc/sysdev/cpm_common.c                  |    3
 arch/powerpc/sysdev/fsl_lbc.c                     |  129 +
 arch/powerpc/sysdev/fsl_soc.c                     |  611 --------
 arch/powerpc/sysdev/fsl_soc.h                     |    1
 arch/powerpc/sysdev/qe_lib/qe.c                   |   13
 arch/powerpc/sysdev/qe_lib/qe_io.c                |    5
 drivers/mtd/nand/fsl_elbc_nand.c                  |  219 ---
 drivers/net/ucc_geth.c                            |    8
 drivers/net/ucc_geth_mii.c                        |   11
 drivers/serial/cpm_uart/cpm_uart.h                |    3
 drivers/serial/cpm_uart/cpm_uart_core.c           |   19
 drivers/serial/cpm_uart/cpm_uart_cpm1.c           |   14
 drivers/serial/cpm_uart/cpm_uart_cpm2.c           |   52
 drivers/serial/ucc_uart.c                         |   16
 include/asm-powerpc/cpm.h                         |   14
 include/asm-powerpc/cpm1.h                        |   13
 include/asm-powerpc/cpm2.h                        |   11
 include/asm-powerpc/fsl_lbc.h                     |  311 ++++
 include/asm-powerpc/immap_qe.h                    |    3
 include/asm-powerpc/qe.h                          |   12
 111 files changed, 31353 insertions(+), 29640 deletions(-)

Anton Vorontsov (8):
      [POWERPC] QE: UCC nodes cleanup
      [POWERPC] fsl_elbc_nand: factor out localbus defines
      [POWERPC] fsl_lbc: implement few UPM routines
      [POWERPC] QE: implement qe_muram_offset
      [POWERPC] QE: immap_qe.h should include asm/io.h
      [POWERPC] QE: export qe_get_brg_clk()
      [POWERPC] QE: fix sparse warnings
      [POWERPC] 83xx: mpc837x_rdb: add simple-bus compatible matching

Kumar Gala (7):
      [POWERPC] Rework Book-E debug exception handling
      [POWERPC] 83xx/85xx: Reorganize defconfigs
      [POWERPC] Make Book-E debug handling SMP safe
      [POWERPC] 83xx: Enable FCM NAND and OF partitions in defconfig
      [POWERPC] 85xx: Fix compile warning
      [POWERPC] 85xx: Convert dts to v1 syntax
      [POWERPC] 85xx: minor .dts cleanups

Laurent Pinchart (6):
      [POWERPC] cpm_uart: Allocate DPRAM memory for SMC ports on CPM2-based platforms.
      [POWERPC] Add bootwrapper function to get virtual reg from the device tree.
      [POWERPC] cpm-serial: Relocate CPM buffer descriptors and SMC parameter ram.
      [POWERPC] ep8248e: Reference SMC parameter RAM base in the device tree.
      [POWERPC] CPM2: Reset the CPM when early debugging is not enabled.
      [POWERPC] CPM: Move opcodes common to CPM1 and CPM2 to include/asm-powerpc/cpm.h

Paul Gortmaker (3):
      [POWERPC] 86xx: Add support for Wind River SBC8641D board
      [POWERPC] 86xx: Add defconfig for Wind River SBC8641D board
      [POWERPC] 86xx: Add device tree source for Wind River SBC8641D

Scott Wood (4):
      [POWERPC] CPM: Always use new binding.
      [POWERPC] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and spi inits.
      [POWERPC] cuboot-pq2: PCI fixes
      [POWERPC] 83xx: mpc8313erdb - Enable FCM NAND and OF partitions in defconfig

Sebastian Siewior (1):
      [POWERPC] 85xx: Enable DMA engine on the MPC8544 DS
