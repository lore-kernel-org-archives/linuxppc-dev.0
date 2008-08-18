Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18601.560.540107.268646@drongo.ozlabs.ibm.com>
Date: Mon, 18 Aug 2008 15:01:36 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get fixes for various bugs on powerpc, as listed below.

Thanks,
Paul.

 arch/powerpc/include/asm/hvcall.h               |   22 +++++++++
 arch/powerpc/include/asm/irqflags.h             |    5 +-
 arch/powerpc/include/asm/mmu_context.h          |    1 
 arch/powerpc/include/asm/systbl.h               |    2 -
 arch/powerpc/kernel/head_32.S                   |    2 -
 arch/powerpc/kernel/lparcfg.c                   |    5 ++
 arch/powerpc/kernel/misc_32.S                   |    2 -
 arch/powerpc/kernel/module.c                    |   15 ------
 arch/powerpc/kernel/sys_ppc32.c                 |   57 -----------------------
 arch/powerpc/platforms/pseries/plpar_wrappers.h |   27 ++++++++++-
 arch/powerpc/platforms/pseries/setup.c          |   28 ++++++++---
 11 files changed, 78 insertions(+), 88 deletions(-)

Benjamin Herrenschmidt (2):
      powerpc: Fix loss of vdso on fork on 32-bit
      powerpc: Fix lockdep IRQ tracing bug

Brian King (1):
      powerpc: Fix CMM page loaning on 64k page kernel with 4k hardware pages

Christoph Hellwig (1):
      powerpc: Use generic compat_sys_old_readdir

Paul Collins (1):
      powerpc/kexec: Fix up KEXEC_CONTROL_CODE_SIZE missed during conversion

Robert Jennings (2):
      powerpc: Make CMO paging space pool ID and page size available
      powerpc: Add CMO enabled flag and paging space data to lparcfg

Rocky Craig (1):
      powerpc: Fix TLB invalidation on boot on 32-bit

Steven Rostedt (1):
      powerpc: Remove dead module_find_bug code
