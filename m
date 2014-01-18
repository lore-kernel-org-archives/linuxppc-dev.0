Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 26E662C0099
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2014 12:22:48 +1100 (EST)
Date: Fri, 17 Jan 2014 19:22:36 -0600
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git
Message-ID: <20140118012236.GA23644@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This contains a fix for a chroma_defconfig build break that was
introduced by e6500 tablewalk support, and a device tree binding patch
that missed the previous pull request due to some last-minute polishing.

The following changes since commit fac515db45207718168cb55ca4d0a390e43b61af:

  Merge remote-tracking branch 'scott/next' into next (2014-01-15 14:22:35 +1100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 4b3cbc82a04485f6400cb5b227798daaa8512a23:

  clk: corenet: Adds the clock binding (2014-01-17 19:01:27 -0600)

----------------------------------------------------------------
Scott Wood (1):
      powerpc/booke64: Guard e6500 tlb handler with CONFIG_PPC_FSL_BOOK3E

Tang Yuantian (1):
      clk: corenet: Adds the clock binding

 .../devicetree/bindings/clock/corenet-clock.txt    | 134 +++++++++++++++++++++
 arch/powerpc/Kconfig                               |   1 +
 arch/powerpc/mm/tlb_low_64e.S                      |   3 +-
 arch/powerpc/mm/tlb_nohash.c                       |   2 +
 4 files changed, 139 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/corenet-clock.txt
