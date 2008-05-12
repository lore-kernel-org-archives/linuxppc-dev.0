Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18472.16324.442125.351127@cargo.ozlabs.ibm.com>
Date: Mon, 12 May 2008 23:01:56 +1000
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

to get 5 commits; one that fixes a compile problem for ARCH=powerpc,
and 4 that fix compile problems for ARCH=ppc.  Since 2.6.26 will be
the last release that includes arch/ppc, we probably should make sure
it works in case anyone wants to refer to it subsequently.

Thanks,
Paul.

 arch/powerpc/kernel/Makefile   |    6 ++++++
 arch/powerpc/kernel/cputable.c |    2 ++
 arch/powerpc/lib/Makefile      |    2 +-
 arch/ppc/Makefile              |    2 +-
 arch/ppc/kernel/ppc_ksyms.c    |    1 +
 arch/ppc/kernel/setup.c        |    1 +
 arch/ppc/platforms/residual.c  |    1 +
 include/asm-ppc/system.h       |    2 +-
 8 files changed, 14 insertions(+), 3 deletions(-)

Paul Mackerras (2):
      [POWERPC] Fix default cputable entries for e200 and e500 families
      [POWERPC] ppc: More compile fixes

Segher Boessenkool (3):
      [POWERPC] ppc: Use ebony_defconfig for defconfig
      [POWERPC] ppc: Include <asm/cacheflush.h> in kernel/ppc_ksyms.c
      [POWERPC] ppc: Don't run prom_init_check for arch/ppc builds
