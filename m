Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84035B7BC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 18:07:45 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Nov 2009 18:07:22 +1100
Message-ID: <1257404842.13611.109.camel@pasglop>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev list <linuxppc-dev@lists.ozlabs.org>,
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

Here are some small bits for .32

The Kconfig cleanup you asked for hugetlbfs selection, a few regression
fixes and an actual bug fix that I decided was worth putting in now
(the RTC dates thingy)

Cheers,
Ben. 

The following changes since commit 2e2ec952350f25242f2e0539db16b1e46f9eb01b:
  Linus Torvalds (1):
        Merge branch 'bugfix' of git://git.kernel.org/.../jeremy/xen

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Andre Detsch (1):
      powerpc/pci: Fix regression in powerpc MSI-X

Benjamin Herrenschmidt (4):
      powerpc: Cleanup Kconfig selection of hugetlbfs support
      powerpc/mm: Remove debug context clamping from nohash code
      powerpc: Avoid giving out RTC dates below EPOCH
      powerpc/kvm: Remove problematic BUILD_BUG_ON statement

 arch/powerpc/Kconfig                  |    4 ++++
 arch/powerpc/kernel/time.c            |   15 ++++++++++++++-
 arch/powerpc/kvm/timing.h             |    4 ++++
 arch/powerpc/mm/mmu_context_nohash.c  |    4 ++--
 arch/powerpc/platforms/pseries/msi.c  |    2 --
 arch/powerpc/platforms/pseries/xics.c |    9 +++++++++
 fs/Kconfig                            |    2 +-
 7 files changed, 34 insertions(+), 6 deletions(-)
