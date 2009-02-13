Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A880DDDA3
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 09:13:03 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Sat, 14 Feb 2009 09:12:21 +1100
Message-Id: <1234563141.26036.67.camel@pasglop>
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

Here's 4 small powerpc fixes, a couple are regression in .29, and the
others are nasty enough bugs with trivial enough fixes that I deemed
then ok to go into .29 (and back into stable).

The following changes since commit b578f3fcca1e78624dfb5f358776e63711d7fda2:
  Linus Torvalds (1):
        Merge git://git.infradead.org/users/cbou/battery-2.6.29

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Dave Hansen (1):
      powerpc/mm: Fix numa reserve bootmem page selection

Geoff Levand (1):
      powerpc/ps3: Move ps3_mm_add_memory to device_initcall

Michael Neuling (1):
      powerpc/vsx: Fix VSX alignment handler for regs 32-63

Philippe Gerum (1):
      powerpc/mm: Fix _PAGE_CHG_MASK to protect _PAGE_SPECIAL

 arch/powerpc/include/asm/pgtable-4k.h    |    2 +-
 arch/powerpc/include/asm/pgtable-64k.h   |    2 +-
 arch/powerpc/include/asm/pgtable-ppc32.h |    3 ++-
 arch/powerpc/kernel/align.c              |    7 ++++++-
 arch/powerpc/mm/numa.c                   |    5 +++--
 arch/powerpc/platforms/ps3/mm.c          |    2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)
