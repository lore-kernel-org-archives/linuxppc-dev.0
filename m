Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 89ED9B6F9C
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Jan 2012 17:21:43 +1100 (EST)
Message-ID: <1326435694.23910.229.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 13 Jan 2012 17:21:34 +1100
Content-Type: text/plain; charset="UTF-8"
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

Please pull this couple of important bug fixes (a commit
that went in breaks booting on some machines, this fixes
it properly).

Thanks !

Cheers,
Ben.

The following changes since commit 7b3480f8b701170c046e1ed362946f5f0d005e13:

  Merge tag 'for-linus-3.3' of git://git.infradead.org/mtd-2.6 (2012-01-10 13:45:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Blanchard (1):
      powerpc: Fix RCU idle and hcall tracing

Li Zhong (1):
      powerpc: Fix unpaired __trace_hcall_entry and __trace_hcall_exit

 arch/powerpc/kernel/idle.c              |   12 ++----------
 arch/powerpc/platforms/pseries/hvCall.S |    3 ++-
 arch/powerpc/platforms/pseries/lpar.c   |   14 ++++++++++----
 3 files changed, 14 insertions(+), 15 deletions(-)
