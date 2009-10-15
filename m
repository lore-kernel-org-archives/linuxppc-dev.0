Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A92D5B7B78
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 17:26:22 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 15 Oct 2009 17:25:53 +1100
Message-Id: <1255587953.2347.97.camel@pasglop>
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

A tad late due mostly to me being on vacation :-) Here's some powerpc
fixes for 2.6.32, not that much and nothing really big.

The following changes since commit 80f506918fdaaca6b574ba931536a58ce015c7be:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.dk/linux-2.6-block

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Anton Blanchard (1):
      powerpc: Fix hypervisor TLB batching

Anton Vorontsov (1):
      powerpc/kgdb: Fix build failure caused by "kgdb.c: unused variable 'acc'"

Benjamin Herrenschmidt (3):
      powerpc/pmac: Fix issues with sleep on some powerbooks
      powerpc/mm: Fix hang accessing top of vmalloc space
      Merge commit 'ftrace/ppc' into merge

Dragos Tatulea (1):
      powerpc/oprofile: Add ppc750 CL as supported by oprofile

Heiko Schocher (1):
      powerpc/pci: Fix MODPOST warning

Michael Ellerman (1):
      powerpc: Fix memory leak in axon_msi.c

Sean MacLennan (1):
      powerpc: warning: allocated section `.data_nosave' not in segment

Steven Rostedt (2):
      powerpc/ftrace: show real return addresses in modules
      powerpc64/ftrace: use PACA to retrieve TOC in mod_return_to_handler

 arch/powerpc/include/asm/firmware.h       |   10 +++---
 arch/powerpc/kernel/cputable.c            |    2 +
 arch/powerpc/kernel/entry_64.S            |    3 +-
 arch/powerpc/kernel/kgdb.c                |    6 ----
 arch/powerpc/kernel/pci-common.c          |    2 +-
 arch/powerpc/kernel/process.c             |   10 +++++--
 arch/powerpc/kernel/vmlinux.lds.S         |    1 +
 arch/powerpc/mm/slb_low.S                 |   10 +++----
 arch/powerpc/platforms/cell/axon_msi.c    |    2 +-
 arch/powerpc/platforms/powermac/low_i2c.c |    7 +++-
 arch/powerpc/platforms/pseries/firmware.c |    3 +-
 drivers/macintosh/via-pmu.c               |   40 ++++++++++++++++------------
 12 files changed, 51 insertions(+), 45 deletions(-)
