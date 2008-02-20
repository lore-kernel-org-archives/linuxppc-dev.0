Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [GIT PULL] Please pull spufs.git master branch
Message-Id: <1203485792.179169.21603792093.0.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 20 Feb 2008 16:36:32 +1100
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please do a:

git pull \
    git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git master

I have two new bugfixes for spufs: these are both fixes for regressions
since .24.

Cheers,


Jeremy


--- 2 commits:

  [POWERPC] spufs: fix scheduler starvation by idle contexts
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/run.c   |    1 +
    arch/powerpc/platforms/cell/spufs/sched.c |    8 +++-----
    2 files changed, 4 insertions(+), 5 deletions(-)
   
  [POWERPC] cell: fix spurious false return from spu_trap_data_{map,seg}
    Andre Detsch <adetsch@br.ibm.com>

    arch/powerpc/platforms/cell/spu_base.c     |   12 ------------
    arch/powerpc/platforms/cell/spufs/switch.c |    6 +++---
    include/asm-powerpc/spu.h                  |    3 +--
    3 files changed, 4 insertions(+), 17 deletions(-)
   
