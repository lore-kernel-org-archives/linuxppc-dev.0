Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5BC1C2C0079
 for <linuxppc-dev@ozlabs.org>; Fri, 27 Jul 2012 22:45:08 +1000 (EST)
Date: Fri, 27 Jul 2012 07:44:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1207270743440.9079@right.am.freescale.net>
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

A few patches that missed the initial 3.6 window.  These are bug fixes at
this point.

- k

The following changes since commit 574ce79cea9d3fda109ffcc82f81733de4740e5c:

  powerpc/mpic: Create a revmap with enough entries for IPIs and timers (2012-07-23 14:20:42 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Claudiu Manoil (1):
      powerpc/85xx: Fix sram_offset parameter type

Shaohui Xie (1):
      powerpc/85xx: P3041DS - change espi input-clock from 40MHz to 35MHz

Tang Yuantian (1):
      powerpc/85xx: Fix pci base address error for p2020rdb-pc in dts

Timur Tabi (2):
      powerpc/85xx: p1022ds: disable the NAND flash node if video is enabled
      powerpc/85xx: p1022ds: fix DIU/LBC switching with NAND enabled

 arch/powerpc/boot/dts/p2020rdb-pc_32b.dts |    4 +-
 arch/powerpc/boot/dts/p2020rdb-pc_36b.dts |    4 +-
 arch/powerpc/boot/dts/p3041ds.dts         |    2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c    |  122 +++++++++++++++++++++++-----
 arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
 arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 ++++------
 6 files changed, 121 insertions(+), 54 deletions(-)
