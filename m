Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17700.17773.769331.167769@cargo.ozlabs.ibm.com>
Date: Thu, 5 Oct 2006 09:36:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'master' branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

again, to get a Cell update.  I apologize on Arnd's behalf for the
lateness of this update.

Thanks,
Paul.

 arch/powerpc/configs/cell_defconfig          |   60 +++
 arch/powerpc/platforms/cell/Kconfig          |    5 
 arch/powerpc/platforms/cell/interrupt.c      |   10 -
 arch/powerpc/platforms/cell/iommu.c          |    8 
 arch/powerpc/platforms/cell/spider-pic.c     |    6 
 arch/powerpc/platforms/cell/spu_base.c       |  168 ++++++++--
 arch/powerpc/platforms/cell/spufs/Makefile   |    2 
 arch/powerpc/platforms/cell/spufs/context.c  |    6 
 arch/powerpc/platforms/cell/spufs/file.c     |  354 +++++++++++++++-----
 arch/powerpc/platforms/cell/spufs/gang.c     |   81 +++++
 arch/powerpc/platforms/cell/spufs/inode.c    |  232 +++++++++++--
 arch/powerpc/platforms/cell/spufs/run.c      |   48 ++-
 arch/powerpc/platforms/cell/spufs/sched.c    |  450 ++++++++++----------------
 arch/powerpc/platforms/cell/spufs/spufs.h    |   29 ++
 arch/powerpc/platforms/cell/spufs/switch.c   |    9 +
 arch/powerpc/platforms/cell/spufs/syscalls.c |    9 -
 include/asm-powerpc/spu.h                    |   36 ++
 17 files changed, 1017 insertions(+), 496 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/spufs/gang.c

Arnd Bergmann:
      [POWERPC] spufs: implement error event delivery to user space
      [POWERPC] spufs: Add infrastructure needed for gang scheduling
      [POWERPC] spufs: use correct pg_prot for mapping SPU local store
      [POWERPC] spufs: make mailbox functions handle multiple elements
      [POWERPC] spufs: remove support for ancient firmware
      [POWERPC] spufs: add support for read/write on cntl
      [POWERPC] spufs: support new OF device tree format
      [POWERPC] spufs: add infrastructure for finding elf objects
      [POWERPC] Update cell_defconfig
      [POWERPC] spiderpic: enable new style devtree support
      [POWERPC] cell: fix bugs found by sparse

Benjamin Herrenschmidt:
      [POWERPC] spufs: cell spu problem state mapping updates

HyeonSeung Jang:
      [POWERPC] spufs: fix context switch during page fault

Mark Nutter:
      [POWERPC] spufs: scheduler support for NUMA.
