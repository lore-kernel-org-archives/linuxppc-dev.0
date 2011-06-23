Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F230DB6F84
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 12:41:56 +1000 (EST)
Date: Wed, 22 Jun 2011 21:41:49 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch
Message-ID: <alpine.LFD.2.00.1106222141060.2926@right.am.freescale.net>
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

The following changes since commit 56299378726d5f2ba8d3c8cbbd13cb280ba45e4f:
  Linus Torvalds (1):
        Linux 3.0-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Scott Wood (1):
      powerpc/e500: fix breakage with fsl_rio_mcheck_exception

Shaohui Xie (1):
      powerpc/85xx: fix NAND_CMD_READID read bytes number

Timur Tabi (1):
      powerpc/p1022ds: fix audio-related properties in the device tree

 arch/powerpc/boot/dts/p1022ds.dts |    9 ++++++---
 arch/powerpc/kernel/traps.c       |    2 +-
 arch/powerpc/sysdev/fsl_rio.c     |   33 +++++++++++++++++----------------
 drivers/mtd/nand/fsl_elbc_nand.c  |    6 +++---
 4 files changed, 27 insertions(+), 23 deletions(-)
