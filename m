Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A4F4CB6FA7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Jun 2011 22:55:45 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p57CtYZM022324
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Jun 2011 07:55:36 -0500
Date: Tue, 7 Jun 2011 07:55:34 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [git pull] Please pull powerpc.git merge branch (fwd)
Message-ID: <alpine.LFD.2.00.1106070755230.10813@right.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[forgot to CC the list]

---------- Forwarded message ----------
Date: Mon, 6 Jun 2011 16:17:08 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [git pull] Please pull powerpc.git merge branch

The following changes since commit 9693ebd4815eefa2b7c8fcc699061a0c8da0c1e7:

  Merge remote branch 'kumar/merge' into merge (2011-05-27 09:58:22 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git merge

Kumar Gala (2):
      powerpc/fsl_rio: Fix compile error when CONFIG_FSL_RIO not set
      powerpc/book3e: Fix CPU feature handling on e5500 in 32-bit mode

Shaohui Xie (1):
      powerpc/85xx: fix race bug of calling request_irq after enable elbc interrupts

 arch/powerpc/include/asm/rio.h |    2 +-
 arch/powerpc/kernel/cputable.c |    2 +-
 arch/powerpc/sysdev/fsl_lbc.c  |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
