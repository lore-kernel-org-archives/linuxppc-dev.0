Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [GIT PULL] Please pull spufs.git master branch
Message-Id: <1205289058.252638.178134801644.0.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Wed, 12 Mar 2008 13:30:58 +1100
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

I have a two more bugfixes for the SPU scheduler.

Cheers,


Jeremy


--- 2 commits:

  [POWERPC] spufs: don't (ab)use SCHED_IDLE
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/run.c            |    3 ++-
    arch/powerpc/platforms/cell/spufs/sched.c          |    4 ++--
    arch/powerpc/platforms/cell/spufs/spufs.h          |    1 +
    3 files changed, 5 insertions(+), 3 deletions(-)
   
  [POWERPC] spufs: fix rescheduling of non-runnable contexts
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/context.c        |    3 ++-
    1 file changed, 2 insertions(+), 1 deletion(-)
   
