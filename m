Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CB6AADE066
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 16:34:35 +1000 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 18 May 2009 16:34:25 +1000
Message-Id: <1242628465.18075.46.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

A few more 2.6.30 things for you... a defconfig update, and a couple
of small fixes, either obvious enough or regression fixes.

Cheers,
Ben.

The following changes since commit 86460103c412f9e11aeb7950cce64b9e51539d4d:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../rafael/suspend-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc: Explicit alignment for .data.cacheline_aligned

Geoff Levand (1):
      powerpc/ps3: Update ps3_defconfig

Mel Gorman (1):
      powerpc: Do not assert pte_locked for hugepage PTE entries

Michael Ellerman (1):
      powerpc/ftrace: Use pr_devel() in ftrace.c

Steven Rostedt (1):
      powerpc/ftrace: Fix constraint to be early clobber

 arch/powerpc/configs/ps3_defconfig |  105 +++++++++++++++++++++---------------
 arch/powerpc/kernel/ftrace.c       |   22 ++++----
 arch/powerpc/kernel/vmlinux.lds.S  |    1 +
 arch/powerpc/mm/pgtable.c          |    3 +-
 4 files changed, 76 insertions(+), 55 deletions(-)
