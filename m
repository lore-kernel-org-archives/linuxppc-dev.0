Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4C0EADDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 07:07:43 +1000 (EST)
Date: Wed, 1 Oct 2008 16:07:37 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0810011607150.27004@blarg.am.freescale.net>
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

 Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt |   40
 arch/powerpc/boot/dts/asp834x-redboot.dts            |    4
 arch/powerpc/boot/dts/mpc8313erdb.dts                |    4
 arch/powerpc/boot/dts/mpc8315erdb.dts                |    4
 arch/powerpc/boot/dts/mpc832x_mds.dts                |    4
 arch/powerpc/boot/dts/mpc832x_rdb.dts                |    4
 arch/powerpc/boot/dts/mpc8349emitx.dts               |    4
 arch/powerpc/boot/dts/mpc8349emitxgp.dts             |    4
 arch/powerpc/boot/dts/mpc834x_mds.dts                |    4
 arch/powerpc/boot/dts/mpc836x_mds.dts                |    4
 arch/powerpc/boot/dts/mpc836x_rdk.dts                |    4
 arch/powerpc/boot/dts/mpc8377_mds.dts                |    4
 arch/powerpc/boot/dts/mpc8377_rdb.dts                |    4
 arch/powerpc/boot/dts/mpc8378_mds.dts                |    4
 arch/powerpc/boot/dts/mpc8378_rdb.dts                |    4
 arch/powerpc/boot/dts/mpc8379_mds.dts                |    4
 arch/powerpc/boot/dts/mpc8379_rdb.dts                |    4
 arch/powerpc/boot/dts/sbc8349.dts                    |    4
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig     | 1497 +++++++++++++++++
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig     | 1666 +++++++++++++++++++
 arch/powerpc/configs/86xx/sbc8641d_defconfig         | 1481 ++++++++++++++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig          | 1497 -----------------
 arch/powerpc/configs/mpc8641_hpcn_defconfig          | 1666 -------------------
 arch/powerpc/configs/mpc86xx_defconfig               | 1646 ++++++++++++++++++
 arch/powerpc/configs/sbc8641d_defconfig              | 1481 ----------------
 arch/powerpc/include/asm/sfp-machine.h               |  353 ++++
 arch/powerpc/math-emu/Makefile                       |    7
 arch/powerpc/math-emu/double.h                       |  129 -
 arch/powerpc/math-emu/fadd.c                         |   17
 arch/powerpc/math-emu/fadds.c                        |   20
 arch/powerpc/math-emu/fcmpo.c                        |   10
 arch/powerpc/math-emu/fcmpu.c                        |   10
 arch/powerpc/math-emu/fctiw.c                        |    8
 arch/powerpc/math-emu/fctiwz.c                       |    8
 arch/powerpc/math-emu/fdiv.c                         |   14
 arch/powerpc/math-emu/fdivs.c                        |   16
 arch/powerpc/math-emu/fmadd.c                        |   16
 arch/powerpc/math-emu/fmadds.c                       |   18
 arch/powerpc/math-emu/fmsub.c                        |   16
 arch/powerpc/math-emu/fmsubs.c                       |   18
 arch/powerpc/math-emu/fmul.c                         |   14
 arch/powerpc/math-emu/fmuls.c                        |   16
 arch/powerpc/math-emu/fnmadd.c                       |   16
 arch/powerpc/math-emu/fnmadds.c                      |   18
 arch/powerpc/math-emu/fnmsub.c                       |   16
 arch/powerpc/math-emu/fnmsubs.c                      |   18
 arch/powerpc/math-emu/frsp.c                         |   14
 arch/powerpc/math-emu/fsel.c                         |    8
 arch/powerpc/math-emu/fsqrt.c                        |   12
 arch/powerpc/math-emu/fsqrts.c                       |   14
 arch/powerpc/math-emu/fsub.c                         |   14
 arch/powerpc/math-emu/fsubs.c                        |   16
 arch/powerpc/math-emu/lfd.c                          |    4
 arch/powerpc/math-emu/lfs.c                          |   19
 arch/powerpc/math-emu/math.c                         |    8
 arch/powerpc/math-emu/mcrfs.c                        |    3
 arch/powerpc/math-emu/mffs.c                         |    3
 arch/powerpc/math-emu/mtfsb0.c                       |    3
 arch/powerpc/math-emu/mtfsb1.c                       |    3
 arch/powerpc/math-emu/mtfsf.c                        |   20
 arch/powerpc/math-emu/mtfsfi.c                       |    3
 arch/powerpc/math-emu/op-1.h                         |  245 --
 arch/powerpc/math-emu/op-2.h                         |  434 ----
 arch/powerpc/math-emu/op-4.h                         |  317 ---
 arch/powerpc/math-emu/op-common.h                    |  688 -------
 arch/powerpc/math-emu/sfp-machine.h                  |  377 ----
 arch/powerpc/math-emu/single.h                       |   66
 arch/powerpc/math-emu/soft-fp.h                      |  104 -
 arch/powerpc/math-emu/stfs.c                         |   19
 arch/powerpc/math-emu/types.c                        |   51
 arch/powerpc/math-emu/udivmodti4.c                   |    2
 arch/powerpc/platforms/85xx/mpc85xx_ads.c            |    1
 arch/powerpc/platforms/85xx/sbc8560.c                |    1
 arch/powerpc/platforms/86xx/gef_sbc610.c             |   25
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c           |    8
 arch/powerpc/platforms/86xx/sbc8641d.c               |    8
 arch/powerpc/platforms/Kconfig                       |    9
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c    |    1
 arch/powerpc/sysdev/Makefile                         |    1
 arch/powerpc/sysdev/fsl_soc.c                        |   47
 arch/powerpc/sysdev/mpc8xxx_gpio.c                   |  171 +
 drivers/block/floppy.c                               |    2
 drivers/char/ipmi/ipmi_si_intf.c                     |    2
 drivers/i2c/busses/i2c-pca-isa.c                     |    2
 drivers/input/serio/i8042-io.h                       |    2
 drivers/pnp/isapnp/core.c                            |    2
 drivers/pnp/pnpbios/core.c                           |    4
 drivers/serial/mpc52xx_uart.c                        |  181 --
 88 files changed, 7235 insertions(+), 7479 deletions(-)

Anton Vorontsov (1):
      powerpc/fsl_soc: remove mpc83xx_wdt code

Becky Bruce (1):
      powerpc: Drop redundant machine type print in show_cpuinfo

Kumar Gala (6):
      powerpc: convert CONFIG_PPC_MERGE to CONFIG_PPC for legacy io checks
      powerpc/83xx: Add missing cell-index to dma-channel device nodes
      powerpc/86xx: Introduce a generic mpc86xx_defconfig
      powerpc: Move 8xxx GPIO Kconfig under the platform menu
      serial/mpc52xx_uart: remove code associated with !CONFIG_PPC_MERGE
      powerpc/math-emu: Use kernel generic math-emu code

Martyn Welch (1):
      powerpc: Correct USB support for GE Fanuc SBC610

Peter Korsgaard (1):
      powerpc: gpio driver for mpc8349/8572/8610 and compatible
