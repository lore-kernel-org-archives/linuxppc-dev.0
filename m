Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 29EB6B714F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:25:32 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7730FDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:25:31 +1000 (EST)
Date: Mon, 15 Jun 2009 22:25:25 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch for 2.6.31
Message-ID: <Pine.LNX.4.64.0906152218470.13104@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 arch/powerpc/boot/cuboot-85xx.c                 |    2
 arch/powerpc/boot/dts/asp834x-redboot.dts       |    2
 arch/powerpc/boot/dts/gef_sbc610.dts            |   10
 arch/powerpc/boot/dts/kmeter1.dts               |  520 ++++++
 arch/powerpc/boot/dts/mpc8272ads.dts            |   19
 arch/powerpc/boot/dts/mpc8315erdb.dts           |   15
 arch/powerpc/boot/dts/mpc8349emitx.dts          |    2
 arch/powerpc/boot/dts/mpc834x_mds.dts           |    2
 arch/powerpc/boot/dts/mpc8377_mds.dts           |    2
 arch/powerpc/boot/dts/mpc8377_rdb.dts           |    2
 arch/powerpc/boot/dts/mpc8378_mds.dts           |    2
 arch/powerpc/boot/dts/mpc8378_rdb.dts           |    2
 arch/powerpc/boot/dts/mpc8379_mds.dts           |    2
 arch/powerpc/boot/dts/mpc8379_rdb.dts           |    2
 arch/powerpc/boot/dts/mpc8569mds.dts            |   87 +
 arch/powerpc/boot/dts/sbc8349.dts               |    2
 arch/powerpc/boot/dts/xcalibur1501.dts          |  696 +++++++++
 arch/powerpc/boot/dts/xpedite5200.dts           |  466 ++++++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts      |  506 ++++++
 arch/powerpc/boot/dts/xpedite5301.dts           |  640 ++++++++
 arch/powerpc/boot/dts/xpedite5330.dts           |  707 +++++++++
 arch/powerpc/boot/dts/xpedite5370.dts           |  638 ++++++++
 arch/powerpc/boot/wrapper                       |    4
 arch/powerpc/configs/83xx/kmeter1_defconfig     |  908 +++++++++++
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig | 1821 ++++++++++++++++++++++++
 arch/powerpc/include/asm/fsl_lbc.h              |    4
 arch/powerpc/include/asm/reg_booke.h            |    2
 arch/powerpc/kernel/cpu_setup_6xx.S             |    3
 arch/powerpc/kernel/cpu_setup_fsl_booke.S       |   49
 arch/powerpc/platforms/83xx/Kconfig             |    7
 arch/powerpc/platforms/83xx/Makefile            |    1
 arch/powerpc/platforms/83xx/kmeter1.c           |  191 ++
 arch/powerpc/platforms/83xx/mpc83xx.h           |    4
 arch/powerpc/platforms/83xx/usb.c               |   10
 arch/powerpc/platforms/85xx/Kconfig             |   13
 arch/powerpc/platforms/85xx/Makefile            |    1
 arch/powerpc/platforms/85xx/mpc8536_ds.c        |   17
 arch/powerpc/platforms/85xx/mpc85xx_ds.c        |   19
 arch/powerpc/platforms/85xx/mpc85xx_mds.c       |   20
 arch/powerpc/platforms/85xx/xes_mpc85xx.c       |  282 +++
 arch/powerpc/platforms/86xx/Kconfig             |    1
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c      |   15
 drivers/rapidio/rio-scan.c                      |   43
 drivers/rapidio/rio-sysfs.c                     |    6
 drivers/serial/ucc_uart.c                       |   19
 45 files changed, 7713 insertions(+), 53 deletions(-)

Anton Vorontsov (1):
      powerpc/83xx: Update sdhci nodes per new bindings

Becky Bruce (1):
      powerpc: Add 86xx support for SWIOTLB

Dave Liu (1):
      serial: Make ucc_uart work in HW UART mode

Gerhard Pircher (1):
      powerpc: Enable additional BAT registers in setup_745x_specifics()

Haiying Wang (1):
      powerpc/85xx: Add UCC6 and UCC8 nodes in SGMII mode for MPC8569MDS

Heiko Schocher (1):
      83xx: add support for the kmeter1 board.

Kevin Hao (1):
      powerpc/85xx: Add nor flash partitions for mpc8569mds

Kumar Gala (1):
      powerpc/85xx: Add SWIOTLB support to FSL boards

Martyn Welch (1):
      powerpc/86xx: Add I2C device mappings in DTS for SBC610

Nate Case (6):
      powerpc/fsl-booke: Enable L1 cache on e500v1/e500v2/e500mc CPUs
      powerpc/85xx: cuboot - Fix up ethernet3 MAC address on MPC85xx
      powerpc/85xx: Add platform support for X-ES MPC85xx boards
      powerpc/85xx: Add dts files for X-ES MPC85xx boards
      powerpc/85xx: Add defconfig for X-ES MPC85xx boards
      powerpc/bootwrapper: Custom build options for XPedite52xx targets

Peter Korsgaard (1):
      powerpc/mpc83xx: Fix usb mux setup for mpc834x

Wolfgang Denk (1):
      powerpc/mpc8272ads: fix device tree for 8 MB flash size

Yang Li (1):
      rio: warn_unused_result warnings fix

leon.woestenberg@gmail.com (1):
      powerpc/83xx: Add MSI interrupts to DTS of MPC8315E-RDB

mware@internode.on.net (1):
      powerpc/fsl: Increase the number of possible localbus banks
