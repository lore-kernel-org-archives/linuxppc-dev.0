Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3A79B7C09
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 18:19:01 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 19 Mar 2010 18:18:50 +1100
Message-ID: <1268983130.8599.56.camel@pasglop>
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

Here's a handful of powerpc fixes for 2.6.34, along with a patch
from Fujita Tomonori to remove a config option that is mostly
useless nowadays.

Cheers,
Ben.

The following changes since commit 39710479303fd3affb3e204e9a7a75cc676977b5:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://git.kernel.org/.../vapier/blackfin

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      Merge commit 'kumar/merge' into merge

FUJITA Tomonori (2):
      powerpc: Fix swiotlb to respect the boot option
      powerpc: Remove IOMMU_VMERGE config option

Kumar Gala (2):
      powerpc/85xx: Make sure lwarx hint isn't set on ppc32
      powerpc/fsl-booke: Get coherent bit from PTE

Márton Németh (1):
      powerpc: Do not call prink when CONFIG_PRINTK is not defined

Nathan Lynch (1):
      powerpc: Use correct ccr bit for syscall error status

 arch/powerpc/Kconfig                  |   13 -------------
 arch/powerpc/include/asm/ppc-opcode.h |    6 +++---
 arch/powerpc/include/asm/syscall.h    |    6 +++---
 arch/powerpc/kernel/head_fsl_booke.S  |    7 ++++---
 arch/powerpc/kernel/iommu.c           |    7 +------
 arch/powerpc/kernel/setup_32.c        |    6 ------
 arch/powerpc/kernel/setup_64.c        |    6 ------
 arch/powerpc/mm/mem.c                 |    6 ++++++
 8 files changed, 17 insertions(+), 40 deletions(-)
