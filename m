Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C4681B6EE7
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2012 07:45:06 +1100 (EST)
Date: Thu, 29 Mar 2012 15:44:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.02.1203291544170.14273@spiff>
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

Ben,

A few minor bug fixes and missing dts updates for 3.4.  There got lost in
the mix.  Sorry for the delay

- k

The following changes since commit 1ce447b90f3e71c81ae59e0062bc305ef267668b:

  powerpc/perf: Fix instruction address sampling on 970 and Power4 (2012-03-28 11:33:24 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Dave Liu (1):
      powerpc/qe: Update the SNUM table for MPC8569 Rev2.0

Diana CRACIUN (1):
      powerpc/dts: Removed fsl,msi property from dts.

Jerry Huang (2):
      powerpc/85xx: add the P1020MBG-PC DTS support
      powerpc/85xx: add the P1020UTM-PC DTS support

Shaveta Leekha (1):
      powerpc/85xx: Enable I2C_CHARDEV and I2C_MPC options in defconfigs

Timur Tabi (2):
      powerpc/8xxx: remove 85xx/86xx restrictions from fsl_guts.h
      powerpc/epapr: add "memory" as a clobber to all hypercalls

 arch/powerpc/boot/dts/p1020mbg-pc.dtsi       |  151 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts    |   89 +++++++++++++++
 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts    |   89 +++++++++++++++
 arch/powerpc/boot/dts/p1020utm-pc.dtsi       |  140 ++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1020utm-pc_32b.dts    |   89 +++++++++++++++
 arch/powerpc/boot/dts/p1020utm-pc_36b.dts    |   89 +++++++++++++++
 arch/powerpc/boot/dts/p2041rdb.dts           |    3 -
 arch/powerpc/boot/dts/p3041ds.dts            |    4 -
 arch/powerpc/boot/dts/p3060qds.dts           |    2 -
 arch/powerpc/boot/dts/p4080ds.dts            |    3 -
 arch/powerpc/boot/dts/p5020ds.dts            |    4 -
 arch/powerpc/configs/corenet32_smp_defconfig |    1 +
 arch/powerpc/configs/corenet64_smp_defconfig |    2 +
 arch/powerpc/configs/mpc85xx_defconfig       |    1 +
 arch/powerpc/configs/mpc85xx_smp_defconfig   |    1 +
 arch/powerpc/include/asm/epapr_hcalls.h      |    7 +-
 arch/powerpc/include/asm/fsl_guts.h          |   26 +----
 arch/powerpc/platforms/85xx/mpc85xx_mds.c    |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c    |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c       |    4 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |    2 +-
 arch/powerpc/sysdev/qe_lib/qe.c              |   22 ++++-
 drivers/net/ethernet/freescale/ucc_geth.c    |    6 +-
 sound/soc/fsl/mpc8610_hpcd.c                 |    8 +-
 sound/soc/fsl/p1022_ds.c                     |   10 +-
 25 files changed, 701 insertions(+), 56 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020mbg-pc_36b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020utm-pc.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1020utm-pc_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1020utm-pc_36b.dts
