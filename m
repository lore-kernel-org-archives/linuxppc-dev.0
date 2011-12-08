Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 498581007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 18:30:01 +1100 (EST)
Date: Thu, 8 Dec 2011 01:29:55 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1112080129140.13118@right.am.freescale.net>
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

[ some bugfixes & defconfig updates for 3.2]

The following changes since commit 49e44064d7e3f24f874a51dd513b83ef9994aa8a:

  powerpc/44x: Add mtd ndfc to the ppx44x defconfig (2011-11-25 10:06:00 +1100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Andy Fleming (1):
      powerpc: Add TBI PHY node to first MDIO bus

Kumar Gala (2):
      powerpc/fsl-pci: Allow 64-bit PCIe devices to DMA to any memory address
      powerpc/fsl: Update defconfigs to enable some standard FSL HW features

Paul Gortmaker (1):
      sbc834x: put full compat string in board match check

 arch/powerpc/boot/dts/p1010rdb.dts            |    5 ++
 arch/powerpc/boot/dts/p1020rdb.dts            |    5 ++
 arch/powerpc/boot/dts/p1020rdb_camp_core0.dts |    5 ++
 arch/powerpc/boot/dts/p1021mds.dts            |    4 ++
 arch/powerpc/boot/dts/p1022ds.dts             |    4 ++
 arch/powerpc/boot/dts/p2020rdb.dts            |    8 +++-
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    4 ++
 arch/powerpc/configs/corenet32_smp_defconfig  |   10 +++--
 arch/powerpc/configs/corenet64_smp_defconfig  |    3 +-
 arch/powerpc/configs/mpc85xx_defconfig        |   17 +++++--
 arch/powerpc/configs/mpc85xx_smp_defconfig    |   18 ++++++--
 arch/powerpc/platforms/83xx/sbc834x.c         |    4 +-
 arch/powerpc/sysdev/fsl_pci.c                 |   55 +++++++++++++++++++++++++
 13 files changed, 123 insertions(+), 19 deletions(-)
