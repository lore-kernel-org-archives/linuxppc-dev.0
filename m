Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 470DD2C00A5
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 02:01:06 +1000 (EST)
Date: Thu, 23 Aug 2012 11:00:46 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
In-Reply-To: <alpine.LFD.2.00.1208171256150.26104@right.am.freescale.net>
Message-ID: <alpine.LFD.2.00.1208231100060.505@right.am.freescale.net>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
 <1344033253.24037.70.camel@pasglop>
 <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
 <alpine.LFD.2.00.1208100806200.16855@right.am.freescale.net>
 <2F2AC95E-BCAD-4EE6-BC63-E8EF5B3584BE@kernel.crashing.org>
 <alpine.LFD.2.00.1208171256150.26104@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ Added defconfig updates from Kim to fix NFS boot on yocto ]

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

for you to fetch changes up to 1267643dc311e860e728dbd09a97c2e0a773bfdb:

  powerpc/fsl: fix "Failed to mount /dev: No such device" errors (2012-08-23 10:46:20 -0500)

----------------------------------------------------------------
Jia Hongtao (1):
      powerpc/fsl-pci: Only scan PCI bus if configured as a host

Kim Phillips (2):
      powerpc/fsl: update defconfigs
      powerpc/fsl: fix "Failed to mount /dev: No such device" errors

Shengzhou Liu (1):
      powerpc/p4080ds: dts - add usb controller version info and port0

Tiejun Chen (1):
      booke/wdt: some ioctls do not return values properly

Zhao Chenhui (1):
      powerpc/85xx: mpc85xx_defconfig - add VIA PATA support for MPC85xxCDS

 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi  |    7 ++++++
 arch/powerpc/configs/85xx/p1023rds_defconfig |   31 ++++++++----------------
 arch/powerpc/configs/corenet32_smp_defconfig |   29 +++++++---------------
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/mpc83xx_defconfig       |   18 ++++----------
 arch/powerpc/configs/mpc85xx_defconfig       |   33 +++++++-------------------
 arch/powerpc/configs/mpc85xx_smp_defconfig   |   32 +++++++------------------
 arch/powerpc/sysdev/fsl_pci.c                |   13 ++++++----
 drivers/watchdog/booke_wdt.c                 |    7 +++---
 9 files changed, 60 insertions(+), 111 deletions(-)
