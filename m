Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4C98B7CBD
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 15:05:38 +1100 (EST)
Date: Wed, 17 Feb 2010 22:05:24 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <Pine.LNX.4.64.1002172204160.19485@localhost.localdomain>
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

The following changes since commit efd0f0f385da6ee6d1a22cfe1ac94607ebe2a292:
  Benjamin Herrenschmidt (1):
        Merge commit 'jwb/next' into next

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

Anton Vorontsov (1):
      powerpc/85xx: Add NOR, LEDs and PIB support for MPC8568E-MDS boards

Malcolm Crossley (3):
      powerpc/86xx: Fix GE SBC310 XMC site support
      powerpc/86xx: Add MSI section to GE SBC610 DTS
      powerpc/86xx: Add MSI section to GE PPC9A DTS

Martyn Welch (5):
      powerpc/86xx: Add MSI section to GE SBC310 DTS
      powerpc/86xx: Basic flash support for GE SBC610
      powerpc/86xx: Switch on highmem support on GE SBC610
      powerpc/86xx: Enable VME driver on the GE PPC9A
      powerpc/86xx: Enable VME driver on the GE SBC610

Sebastian Andrzej Siewior (1):
      powerpc/fsl-booke: replace a hardcoded constant

 arch/powerpc/boot/dts/gef_ppc9a.dts            |   16 ++++++
 arch/powerpc/boot/dts/gef_sbc310.dts           |   19 +++++++-
 arch/powerpc/boot/dts/gef_sbc610.dts           |   66 +++++++++++++++++++++---
 arch/powerpc/boot/dts/mpc8568mds.dts           |   65 ++++++++++++++++++++++-
 arch/powerpc/configs/86xx/gef_ppc9a_defconfig  |   47 ++++++++++++++++-
 arch/powerpc/configs/86xx/gef_sbc610_defconfig |   65 +++++++++++++++++++----
 arch/powerpc/kernel/head_fsl_booke.S           |    4 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c      |    3 +
 8 files changed, 259 insertions(+), 26 deletions(-)
