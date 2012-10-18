Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2D16A2C0082
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2012 20:23:57 +1100 (EST)
Message-ID: <1350552198.2476.5.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 18 Oct 2012 20:23:18 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
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

Here are a handful of powerpc related fixes for you to pull.

Cheers,
Ben.

The following changes since commit 18673533256a2953ccefded52df2679de8640685:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2012-10-17 12:41:18 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 83dac59409387789b88bed40b1be86a8abc572be:

  cpuidle/powerpc: Fix snooze state problem in the cpuidle design on pseries. (2012-10-18 10:57:25 +1100)

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc: Build fix for powerpc KVM

Benjamin Herrenschmidt (1):
      Revert "powerpc/perf: Use pmc_overflow() to detect rolled back events"

Deepthi Dharwar (3):
      cpuidle/powerpc: Fix target residency initialisation in pseries cpuidle
      cpuidle/powerpc: Fix smt_snooze_delay functionality.
      cpuidle/powerpc: Fix snooze state problem in the cpuidle design on pseries.

 arch/powerpc/include/asm/kvm_book3s_32.h        |    1 +
 arch/powerpc/include/asm/processor.h            |    4 +-
 arch/powerpc/kernel/sysfs.c                     |    2 +-
 arch/powerpc/kvm/book3s_32_mmu_host.c           |    4 +-
 arch/powerpc/perf/core-book3s.c                 |    2 +-
 arch/powerpc/platforms/pseries/processor_idle.c |   62 +++++++++++------------
 6 files changed, 36 insertions(+), 39 deletions(-)
