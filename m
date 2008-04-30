Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [GIT PULL] Please pull spufs master branch
Message-Id: <1209537841.611177.228566605486.0.gpush@pingu>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 30 Apr 2008 16:44:01 +1000
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please do a:

git-pull git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git

For some updates for 2.6.26. This includes some sputrace updates and a
new switch_log for spufs contexts.

Cheers,


Jeremy


--- 6 commits:

  [POWERPC] spufs: add context switch notification log
    Christoph Hellwig <hch@lst.de>

    arch/powerpc/platforms/cell/spufs/context.c        |    1 
    arch/powerpc/platforms/cell/spufs/file.c           |  166 ++++++++++
    arch/powerpc/platforms/cell/spufs/run.c            |    2 
    arch/powerpc/platforms/cell/spufs/sched.c          |    2 
    arch/powerpc/platforms/cell/spufs/spufs.h          |   29 +
    5 files changed, 200 insertions(+)
   
  [POWERPC] spufs: add sputrace marker parameter names
    Julio M. Merino Vidal <jmerino@ac.upc.edu>

    arch/powerpc/platforms/cell/spufs/spufs.h          |    4 -
    arch/powerpc/platforms/cell/spufs/sputrace.c       |   36 +++++-----
    2 files changed, 20 insertions(+), 20 deletions(-)
   
  [POWERPC] spufs: add marker for destroy_spu_context
    Julio M. Merino Vidal <jmerino@ac.upc.edu>

    arch/powerpc/platforms/cell/spufs/context.c        |    1 +
    1 file changed, 1 insertion(+)
   
  [POWERPC] spufs: fix marker name for find_victim
    Julio M. Merino Vidal <jmerino@ac.upc.edu>

    arch/powerpc/platforms/cell/spufs/sched.c          |    2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)
   
  [POWERPC] spufs: trace spu_acquire_saved events
    Julio M. Merino Vidal <jmerino@ac.upc.edu>

    arch/powerpc/platforms/cell/spufs/context.c        |    2 ++
    1 file changed, 2 insertions(+)
   
  [POWERPC] spufs: add .gitignore for spu_save_dump.h & spu_restore_dump.h
    Kumar Gala <galak@kernel.crashing.org>

    arch/powerpc/platforms/cell/spufs/.gitignore       |    0 
    arch/powerpc/platforms/cell/spufs/.gitignore       |    2 ++
    2 files changed, 2 insertions(+)
   
