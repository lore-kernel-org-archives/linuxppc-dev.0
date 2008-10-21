Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] Please pull spufs merge branch
Date: Tue, 21 Oct 2008 11:46:42 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810211146.43634.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben,

Please do a:

git pull \
  git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git merge

For a few more spufs changes for .28

Cheers,


Jeremy

---
diffstat:

 arch/powerpc/platforms/cell/spufs/file.c           |  155 ++++++----
 arch/powerpc/platforms/cell/spufs/run.c            |    3 
 arch/powerpc/platforms/cell/spufs/sched.c          |   24 +
 arch/powerpc/platforms/cell/spufs/spufs.h          |    1 
 arch/powerpc/platforms/cell/spufs/sputrace.c       |   37 ++
 5 files changed, 151 insertions(+), 69 deletions(-)

8 commits:

  powerpc/spufs: sputrace: Only enable logging on open(), prevent
	multiple openers
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: sputrace: Don't block until the read buffer is full
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Use state_mutex for switch_log locking, and prevent
	multiple openers
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Don't require full buffer in switch_log read
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Don't spu_acquire_saved unnecessarily in regs read
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Use kmalloc rather than kzalloc for switch log buffer
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Improve search of node for contexts with SPU affinity
    Andre Detsch <adetsch@br.ibm.com>

  powerpc/spufs: Explain conditional decrement of aff_sched_count
    Andre Detsch <adetsch@br.ibm.com>
