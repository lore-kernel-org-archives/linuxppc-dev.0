Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AB5CCB7199
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Nov 2010 16:46:58 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 18 Nov 2010 16:46:48 +1100
Message-ID: <1290059208.32570.3.camel@pasglop>
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

Here are a handful of bug fixes and trivialities for powerpc for you
to pull.

Thanks !

Cheers,
Ben.

The following changes since commit 7957f0a857754c555e07f58a3fb83ac29501478c:
  Linus Torvalds (1):
        Fix build failure due to hwirq.h needing smp_lock.h

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Alessio Igor Bogani (1):
      powerpc: Update a BKL related comment

Benjamin Herrenschmidt (1):
      powerpc: Fix div64 in bootloader

Kumar Gala (2):
      powerpc/mm: Fix build error in setup_initial_memory_limit
      powerpc/mm: Fix module instruction tlb fault handling on Book-E 64

Michael Neuling (1):
      powerpc: Fix call to subpage_protection()

Nishanth Aravamudan (1):
      powerpc/pseries: Don't override CONFIG_PPC_PSERIES_DEBUG

kerstin jonsson (1):
      powerpc: Set CONFIG_32BIT on ppc32

 arch/powerpc/Kconfig                       |    4 ++++
 arch/powerpc/boot/div64.S                  |    3 ++-
 arch/powerpc/kernel/setup_64.c             |    5 ++---
 arch/powerpc/mm/hash_utils_64.c            |    2 +-
 arch/powerpc/mm/tlb_low_64e.S              |    5 ++++-
 arch/powerpc/mm/tlb_nohash.c               |    2 +-
 arch/powerpc/platforms/pseries/Kconfig     |    6 ++++++
 arch/powerpc/platforms/pseries/eeh.c       |    2 --
 arch/powerpc/platforms/pseries/pci_dlpar.c |    2 --
 9 files changed, 20 insertions(+), 11 deletions(-)
