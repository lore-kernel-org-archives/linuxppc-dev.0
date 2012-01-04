Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 14524B6F69
 for <linuxppc-dev@ozlabs.org>; Thu,  5 Jan 2012 09:09:56 +1100 (EST)
Date: Wed, 4 Jan 2012 16:06:13 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1201041605230.15492@right.am.freescale.net>
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

The following changes since commit e4f387d8db3ba3c2dae4d8bdfe7bb5f4fe1bcb0d:

  powerpc: Fix unpaired probe_hcall_entry and probe_hcall_exit (2012-01-03 12:09:27 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Andy Fleming (1):
      powerpc: Add TBI PHY node to first MDIO bus

Julia Lawall (1):
      arch/powerpc/sysdev/fsl_rmu.c: introduce missing kfree

Kumar Gala (3):
      powerpc/fsl-pci: Allow 64-bit PCIe devices to DMA to any memory address
      powerpc/fsl: Update defconfigs to enable some standard FSL HW features
      powerpc/fsl: update compatiable on fsl 16550 uart nodes

Michael Neuling (1):
      powerpc: fix compile error with 85xx/p1023_rds.c

Paul Gortmaker (1):
      sbc834x: put full compat string in board match check

Prabhakar Kushwaha (1):
      powerpc/fsl: Add support for Integrated Flash Controller

Timur Tabi (3):
      powerpc/85xx: re-enable ePAPR byte channel driver in corenet32_smp_defconfig
      powerpc/85xx: fix PCI and localbus properties in p1022ds.dts
      powerpc/fsl: add MSI support for the Freescale hypervisor

Tony Breeds (1):
      powerpc: fix compile error with 85xx/p1010rdb.c

 arch/powerpc/Kconfig                         |    4 +
 arch/powerpc/boot/dts/asp834x-redboot.dts    |    4 +-
 arch/powerpc/boot/dts/fsl/pq3-duart-0.dtsi   |    4 +-
 arch/powerpc/boot/dts/fsl/qoriq-duart-0.dtsi |    4 +-
 arch/powerpc/boot/dts/fsl/qoriq-duart-1.dtsi |    4 +-
 arch/powerpc/boot/dts/gef_ppc9a.dts          |    4 +-
 arch/powerpc/boot/dts/gef_sbc310.dts         |    4 +-
 arch/powerpc/boot/dts/gef_sbc610.dts         |    4 +-
 arch/powerpc/boot/dts/kmeter1.dts            |    2 +-
 arch/powerpc/boot/dts/kuroboxHD.dts          |    4 +-
 arch/powerpc/boot/dts/kuroboxHG.dts          |    4 +-
 arch/powerpc/boot/dts/mpc8308_p1m.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8308rdb.dts         |    4 +-
 arch/powerpc/boot/dts/mpc8313erdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8315erdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc832x_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts     |    4 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc836x_rdk.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8377_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8377_wlan.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8378_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8379_mds.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts        |    4 +-
 arch/powerpc/boot/dts/mpc8540ads.dts         |    4 +-
 arch/powerpc/boot/dts/mpc8541cds.dts         |    4 +-
 arch/powerpc/boot/dts/mpc8555cds.dts         |    4 +-
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    4 +-
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts   |    4 +-
 arch/powerpc/boot/dts/p1010rdb.dtsi          |    5 +
 arch/powerpc/boot/dts/p1020rdb.dtsi          |    5 +
 arch/powerpc/boot/dts/p1021mds.dts           |    4 +
 arch/powerpc/boot/dts/p1022ds.dts            |   12 +-
 arch/powerpc/boot/dts/p2020rdb.dts           |    8 +-
 arch/powerpc/boot/dts/sbc8349.dts            |    4 +-
 arch/powerpc/boot/dts/sbc8548.dts            |    4 +-
 arch/powerpc/boot/dts/sbc8641d.dts           |    4 +-
 arch/powerpc/boot/dts/socrates.dts           |    4 +-
 arch/powerpc/boot/dts/storcenter.dts         |    4 +-
 arch/powerpc/boot/dts/stxssa8555.dts         |    4 +-
 arch/powerpc/boot/dts/tqm8540.dts            |    4 +-
 arch/powerpc/boot/dts/tqm8541.dts            |    4 +-
 arch/powerpc/boot/dts/tqm8548-bigflash.dts   |    4 +-
 arch/powerpc/boot/dts/tqm8548.dts            |    4 +-
 arch/powerpc/boot/dts/tqm8555.dts            |    4 +-
 arch/powerpc/boot/dts/xcalibur1501.dts       |    4 +-
 arch/powerpc/boot/dts/xpedite5200.dts        |    4 +-
 arch/powerpc/boot/dts/xpedite5200_xmon.dts   |    4 +-
 arch/powerpc/boot/dts/xpedite5301.dts        |    4 +-
 arch/powerpc/boot/dts/xpedite5330.dts        |    4 +-
 arch/powerpc/boot/dts/xpedite5370.dts        |    4 +-
 arch/powerpc/configs/corenet32_smp_defconfig |   10 +-
 arch/powerpc/configs/corenet64_smp_defconfig |    3 +-
 arch/powerpc/configs/mpc85xx_defconfig       |   16 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig   |   17 +-
 arch/powerpc/include/asm/fsl_ifc.h           |  834 ++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/sbc834x.c        |    4 +-
 arch/powerpc/platforms/85xx/p1010rdb.c       |    2 -
 arch/powerpc/platforms/85xx/p1023_rds.c      |    1 -
 arch/powerpc/sysdev/Makefile                 |    1 +
 arch/powerpc/sysdev/fsl_ifc.c                |  310 ++++++++++
 arch/powerpc/sysdev/fsl_msi.c                |   68 ++-
 arch/powerpc/sysdev/fsl_msi.h                |    7 +-
 arch/powerpc/sysdev/fsl_pci.c                |   84 +++
 arch/powerpc/sysdev/fsl_rmu.c                |    1 +
 71 files changed, 1448 insertions(+), 150 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_ifc.h
 create mode 100644 arch/powerpc/sysdev/fsl_ifc.c
