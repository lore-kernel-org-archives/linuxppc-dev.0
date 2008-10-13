Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 52758DE027
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:50:23 +1100 (EST)
Date: Mon, 13 Oct 2008 11:50:18 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0810131149580.29551@blarg.am.freescale.net>
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

 Documentation/powerpc/dts-bindings/fsl/83xx-512x-pci.txt |   40 ++
 Documentation/powerpc/dts-bindings/fsl/dma.txt           |   13
 Documentation/powerpc/dts-bindings/fsl/ssi.txt           |   20 -
 arch/powerpc/boot/dts/gef_sbc610.dts                     |   41 ++
 arch/powerpc/boot/dts/mpc5121ads.dts                     |    3
 arch/powerpc/boot/dts/mpc8313erdb.dts                    |    3
 arch/powerpc/boot/dts/mpc8315erdb.dts                    |    3
 arch/powerpc/boot/dts/mpc832x_mds.dts                    |    3
 arch/powerpc/boot/dts/mpc832x_rdb.dts                    |    3
 arch/powerpc/boot/dts/mpc8349emitx.dts                   |    6
 arch/powerpc/boot/dts/mpc8349emitxgp.dts                 |    3
 arch/powerpc/boot/dts/mpc834x_mds.dts                    |    6
 arch/powerpc/boot/dts/mpc836x_mds.dts                    |    3
 arch/powerpc/boot/dts/mpc836x_rdk.dts                    |   15
 arch/powerpc/boot/dts/mpc8377_mds.dts                    |   10
 arch/powerpc/boot/dts/mpc8377_rdb.dts                    |    3
 arch/powerpc/boot/dts/mpc8378_mds.dts                    |   10
 arch/powerpc/boot/dts/mpc8378_rdb.dts                    |    3
 arch/powerpc/boot/dts/mpc8379_mds.dts                    |   10
 arch/powerpc/boot/dts/mpc8379_rdb.dts                    |    3
 arch/powerpc/boot/dts/mpc8536ds.dts                      |    2
 arch/powerpc/boot/dts/mpc8610_hpcd.dts                   |    4
 arch/powerpc/boot/dts/sbc8349.dts                        |    3
 arch/powerpc/configs/83xx/asp8347_defconfig              |    2
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig          |    2
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig          |    2
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig          |    2
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig          |    2
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig          |    2
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig        |    2
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig          |    2
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig          |    2
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig          |    2
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig          |    2
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig          |    2
 arch/powerpc/configs/83xx/sbc834x_defconfig              |    2
 arch/powerpc/configs/86xx/gef_sbc610_defconfig           |    5
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig         |    2
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig         |    2
 arch/powerpc/configs/86xx/sbc8641d_defconfig             |    2
 arch/powerpc/configs/ep8248e_defconfig                   |    2
 arch/powerpc/configs/mpc8272_ads_defconfig               |    2
 arch/powerpc/configs/mpc83xx_defconfig                   |    2
 arch/powerpc/configs/pq2fads_defconfig                   |    2
 arch/powerpc/include/asm/fsl_lbc.h                       |   48 --
 arch/powerpc/kernel/head_fsl_booke.S                     |    4
 arch/powerpc/kernel/pci_32.c                             |    5
 arch/powerpc/platforms/512x/Kconfig                      |    2
 arch/powerpc/platforms/512x/mpc5121_ads.c                |   10
 arch/powerpc/platforms/83xx/Kconfig                      |    5
 arch/powerpc/platforms/83xx/mpc837x_mds.c                |    8
 arch/powerpc/platforms/85xx/Kconfig                      |    1
 arch/powerpc/platforms/86xx/Makefile                     |    2
 arch/powerpc/platforms/86xx/gef_pic.c                    |  258 +++++++++++++++
 arch/powerpc/platforms/86xx/gef_pic.h                    |   11
 arch/powerpc/platforms/86xx/gef_sbc610.c                 |   65 +++
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c               |    1
 arch/powerpc/platforms/Kconfig                           |   12
 arch/powerpc/sysdev/fsl_lbc.c                            |   53 ++-
 arch/powerpc/sysdev/fsl_pci.c                            |   58 ++-
 arch/powerpc/sysdev/fsl_soc.c                            |   38 --
 arch/powerpc/sysdev/fsl_soc.h                            |    8
 arch/powerpc/sysdev/qe_lib/Kconfig                       |    9
 drivers/i2c/chips/Kconfig                                |   11
 drivers/i2c/chips/Makefile                               |    1
 drivers/i2c/chips/mcu_mpc8349emitx.c                     |  209 ++++++++++++
 drivers/of/base.c                                        |    2
 67 files changed, 901 insertions(+), 175 deletions(-)

Anton Vorontsov (7):
      powerpc/QE: move QE_GPIO Kconfig symbol into the platforms/Kconfig
      powerpc/83xx: don't probe broken PCI on mpc837x_mds boards
      powerpc/83xx: add DS1374 RTC support for the MPC837xE-MDS boards
      OF: add fsl,mcu-mpc8349emitx to the exception list
      i2c: MPC8349E-mITX Power Management and GPIO expander driver
      powerpc/83xx: add NAND support for the MPC8360E-RDK boards
      powerpc: fix fsl_upm nand driver modular build

John Rigby (3):
      powerpc/fsl: Hide MPC5121 pci bridge.
      powerpc: 83xx: pci: Remove need for get_immrbase from mpc83xx_add_bridge.
      powerpc/5121: Add PCI support.

Kumar Gala (1):
      powerpc/85xx: Wire up RTC interrupt on MPC8536DS

Martyn Welch (2):
      powerpc: GE Fanuc's FPGA based PIC controller on the SBC610
      powerpc: FPGA support for GE Fanuc SBC610

Milton Miller (1):
      powerpc: remove non-dependent load fsl_booke PTE_64BIT

Timur Tabi (5):
      powerpc: make Freescale QE support a selectable Kconfig option
      powerpc: remove support for bootmem-allocated memory for the DIU driver
      powerpc: disable CHRP and PMAC support in various defconfigs
      powerpc: document the "fsl,ssi-dma-channel" compatible property
      powerpc: reserve two DMA channels for audio in MPC8610 HPCD device tree
