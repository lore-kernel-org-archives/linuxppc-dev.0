Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 23A182C0099
 for <linuxppc-dev@ozlabs.org>; Sat, 18 Aug 2012 04:00:20 +1000 (EST)
Date: Fri, 17 Aug 2012 12:56:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git merge branch (updated)
In-Reply-To: <2F2AC95E-BCAD-4EE6-BC63-E8EF5B3584BE@kernel.crashing.org>
Message-ID: <alpine.LFD.2.00.1208171256150.26104@right.am.freescale.net>
References: <alpine.LFD.2.00.1208030838490.4148@right.am.freescale.net>
 <1344033253.24037.70.camel@pasglop>
 <7009C85C-A90F-4477-821A-507259A8F595@kernel.crashing.org>
 <alpine.LFD.2.00.1208100806200.16855@right.am.freescale.net>
 <2F2AC95E-BCAD-4EE6-BC63-E8EF5B3584BE@kernel.crashing.org>
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

Ben,

Added a watchdog fix.

- k

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

for you to fetch changes up to 127c6e731106a2071ee4a6c5a34c471cd3e719f0:

  booke/wdt: some ioctls do not return values properly (2012-08-17 09:03:51 -0500)

----------------------------------------------------------------
Jia Hongtao (1):
      powerpc/fsl-pci: Only scan PCI bus if configured as a host

Shengzhou Liu (1):
      powerpc/p4080ds: dts - add usb controller version info and port0

Tiejun Chen (1):
      booke/wdt: some ioctls do not return values properly

Zhao Chenhui (1):
      powerpc/85xx: mpc85xx_defconfig - add VIA PATA support for MPC85xxCDS

 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    7 +++++++
 arch/powerpc/configs/mpc85xx_defconfig      |    1 +
 arch/powerpc/sysdev/fsl_pci.c               |   13 ++++++++-----
 drivers/watchdog/booke_wdt.c                |    7 +++----
 4 files changed, 19 insertions(+), 9 deletions(-)
