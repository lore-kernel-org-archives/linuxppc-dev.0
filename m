Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 26A752C0080
 for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2012 01:08:23 +1000 (EST)
Date: Wed, 19 Sep 2012 10:08:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git next branch
Message-ID: <alpine.LFD.2.00.1209191006580.13197@right.am.freescale.net>
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

The following changes since commit caa1d631fc99940f866480c2bb88a6f5a235e7a2:

  Merge remote-tracking branch 'kumar/next' into next (2012-09-18 16:04:33 +1000)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git next

for you to fetch changes up to 4d56dec5dca496655ef035ef3b80f7c47dc22b77:

  powerpc/fsl-pci: fix warning when CONFIG_SWIOTLB is disabled (2012-09-19 08:41:46 -0500)

----------------------------------------------------------------
Chunhe Lan (1):
      powerpc/85xx: Enable USB support in p1023rds_defconfig

Jia Hongtao (1):
      powerpc/fsl-pci: fix warning when CONFIG_SWIOTLB is disabled

Prabhakar Kushwaha (1):
      powerpc/mpc85xx: Update interrupt handling for IFC controller

Zhao Chenhui (1):
      powerpc/smp: Do not disable IPI interrupts during suspend

 arch/powerpc/configs/85xx/p1023rds_defconfig |    6 ++++++
 arch/powerpc/kernel/smp.c                    |    2 +-
 arch/powerpc/sysdev/fsl_ifc.c                |   20 ++++++++------------
 arch/powerpc/sysdev/fsl_pci.c                |    2 ++
 4 files changed, 17 insertions(+), 13 deletions(-)
