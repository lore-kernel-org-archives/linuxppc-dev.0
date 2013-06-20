Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2EC9A2C01FC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Jun 2013 17:01:48 +1000 (EST)
Message-ID: <1371711696.3944.13.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2013 17:01:36 +1000
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

Please pull this regression fix into 3.10. We accidentally broke
hugetlbfs on Freescale embedded processors which use a slightly
different page table layout than our server processors.

Cheers,
Ben.

The following changes since commit c0691143dfe1d42ec9bd89de5921ccb6a27ea1b3:

  mn10300: Fix include dependency in irqflags.h et al. (2013-06-19 06:29:54 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 8bbd9f04b7d982d1c6aeb5c08f5983b3d0b9e2fe:

  powerpc: Fix bad pmd error with book3E config (2013-06-20 15:25:21 +1000)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: Fix bad pmd error with book3E config

 arch/powerpc/mm/hugetlbpage.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
