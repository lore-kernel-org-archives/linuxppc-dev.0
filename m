Return-Path: <oss@buserror.net>
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41nVww4T22zDr5r
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 11 Aug 2018 15:31:59 +1000 (AEST)
Date: Sat, 11 Aug 2018 00:29:43 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20180811052943.GA14957@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This contains an 8xx compilation fix, and a dpaa device tree fix.

The following changes since commit 77b5f703dcc859915f0f20d92bc538e4a99ef149:

  powerpc/powernv/opal: Use standard interrupts property when available (2018-08-08 00:32:38 +1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to bd96461249bdded1f6ee50b25e8cd4ce3faaf581:

  powerpc/dts/fsl: t2080rdb: use the Cortina PHY driver compatible (2018-08-08 17:18:02 -0500)

----------------------------------------------------------------
Camelia Groza (3):
      powerpc/configs/dpaa: enable the Cortina PHY driver
      powerpc/dts/fsl: t4240rdb: use the Cortina PHY driver compatible
      powerpc/dts/fsl: t2080rdb: use the Cortina PHY driver compatible

Christophe Leroy (1):
      powerpc/cpm1: fix compilation error with CONFIG_PPC_EARLY_DEBUG_CPM

 arch/powerpc/boot/dts/fsl/t2080rdb.dts | 4 ++--
 arch/powerpc/boot/dts/fsl/t4240rdb.dts | 8 ++++----
 arch/powerpc/configs/dpaa.config       | 1 +
 arch/powerpc/include/asm/fixmap.h      | 1 +
 arch/powerpc/sysdev/cpm_common.c       | 1 +
 5 files changed, 9 insertions(+), 6 deletions(-)
