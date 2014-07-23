Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 846921A01A7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:54:47 +1000 (EST)
Message-ID: <1406091277.22200.44.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Jul 2014 14:54:37 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here is a handful of powerpc fixes for 3.16. They are all pretty
simple and self contained and should still make this release.

Cheers,
Ben.

The following changes since commit f56029410a13cae3652d1f34788045c40a13ffc7:

  powerpc/perf: Never program book3s PMCs with values >= 0x80000000 (2014-07-11 13:50:47 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 6f5405bc2ee0102bb3856e2cdea64ff415db2e0c:

  powerpc: use _GLOBAL_TOC for memmove (2014-07-22 15:56:04 +1000)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: subpage_protect: Increase the array size to take care of 64TB

Joel Stanley (1):
      powerpc: Disable doorbells on Power8 DD1.x

Li Zhong (1):
      powerpc: use _GLOBAL_TOC for memmove

Paul Mackerras (1):
      powerpc: Fix bugs in emulate_step()

Tyrel Datwyler (1):
      powerpc/pseries: dynamically added OF nodes need to call of_node_init

 arch/powerpc/include/asm/cputable.h       |  1 +
 arch/powerpc/include/asm/mmu-hash64.h     |  3 ++-
 arch/powerpc/kernel/cputable.c            | 20 ++++++++++++++++++++
 arch/powerpc/lib/mem_64.S                 |  2 +-
 arch/powerpc/lib/sstep.c                  | 10 +++++-----
 arch/powerpc/platforms/pseries/dlpar.c    |  1 +
 arch/powerpc/platforms/pseries/reconfig.c |  1 +
 7 files changed, 31 insertions(+), 7 deletions(-)
