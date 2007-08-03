Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18099.1109.83340.915328@cargo.ozlabs.ibm.com>
Date: Fri, 3 Aug 2007 20:32:53 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get another batch of bug-fixes for powerpc.

Thanks,
Paul.

 arch/powerpc/kernel/entry_64.S            |    3 +++
 arch/powerpc/kernel/pci_32.c              |    5 ++++-
 arch/powerpc/kernel/smp.c                 |    9 +++------
 arch/powerpc/mm/hash_low_64.S             |    6 ++++--
 arch/powerpc/mm/hash_utils_64.c           |    2 +-
 arch/powerpc/mm/numa.c                    |    4 ++--
 arch/powerpc/mm/slb.c                     |   28 ++++++++++++++++++----------
 arch/powerpc/platforms/cell/spufs/sched.c |    3 ++-
 arch/powerpc/platforms/powermac/feature.c |    6 ++++--
 arch/powerpc/platforms/ps3/setup.c        |    2 +-
 include/asm-powerpc/mmu-hash64.h          |    1 +
 include/asm-powerpc/pgtable-64k.h         |    8 +++-----
 12 files changed, 46 insertions(+), 31 deletions(-)

Andre Detsch (1):
      [POWERPC] spufs: Fix affinity after introduction of node_allowed() calls

Kevin Corry (1):
      [POWERPC] Fix num_cpus calculation in smp_call_function_map()

Michael Ellerman (1):
      [POWERPC] Fix parse_drconf_memory() for 64-bit start addresses

Michael Neuling (1):
      [POWERPC] Fixes for the SLB shadow buffer code

Paul Mackerras (2):
      [POWERPC] Expand RPN field to 34 bits when using 64k pages
      [POWERPC] Fix special PTE code for secondary hash bucket

Segher Boessenkool (2):
      [POWERPC] Fix a compile warning in pci_32.c
      [POWERPC] Fix a compile warning in powermac/feature.c

Stephen Rothwell (1):
      [POWERPC] ps3: Fix section mismatch in ps3/setup.c
