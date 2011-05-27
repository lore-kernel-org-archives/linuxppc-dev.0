Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7340EB6F8F
	for <linuxppc-dev@ozlabs.org>; Fri, 27 May 2011 16:56:04 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 May 2011 16:55:53 +1000
Message-ID: <1306479353.7481.546.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here's the 3 patches Kumar was complaining I forgot to pull :-)

Two are pretty old patches related to FSL RapidIO stuff, and
one is a bug fix.

Cheers,
Ben.

The following changes since commit dc7acbb2518f250050179c8581a972df3b6a24f1:

  Merge branch 'upstream/tidy-xen-mmu-2.6.39' of git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen (2011-05-26 19:01:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      Merge remote branch 'kumar/merge' into merge

Shaohui Xie (2):
      powerpc/fsl_rio: move machine_check handler
      powerpc/fsl_rio: Error interrupt handler for sRIO on MPC85xx

Shengzhou Liu (1):
      powerpc/fsl_lbc: Add workaround for ELBC-A001 erratum

 arch/powerpc/include/asm/fsl_lbc.h |    2 +
 arch/powerpc/include/asm/rio.h     |    5 ++
 arch/powerpc/kernel/traps.c        |   13 +++++
 arch/powerpc/sysdev/fsl_lbc.c      |    9 +++-
 arch/powerpc/sysdev/fsl_rio.c      |  100 ++++++++++++++++++++++++++++-------
 5 files changed, 107 insertions(+), 22 deletions(-)
