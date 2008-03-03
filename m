Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [GIT PULL] Please pull spufs.git master branch
Message-Id: <1204521564.484720.279352630417.0.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Mon, 03 Mar 2008 16:19:24 +1100
Cc: cbe-oss-dev@ozlabs.org
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

I have a number of striaghtforward spufs bugfixes for .25.

Cheers,


Jeremy


--- 7 commits:

  [POWERPC] spufs: fix context destruction during psmap fault
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/file.c           |   12 +++++++++++-
    1 file changed, 11 insertions(+), 1 deletion(-)
   
  [POWERPC] spufs: fix invalid scheduling of forgotten contexts
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/context.c        |    7 +++----
    1 file changed, 3 insertions(+), 4 deletions(-)
   
  [POWERPC] spufs: fix order of sputrace thread IDs
    Jeremy Kerr <jk@ozlabs.org>

    arch/powerpc/platforms/cell/spufs/sputrace.c       |    7 ++++---
    1 file changed, 4 insertions(+), 3 deletions(-)
   
  [POWERPC] spufs: synchronize IRQ when disabling
    Arnd Bergmann <arnd@arndb.de>

    arch/powerpc/platforms/cell/spufs/switch.c         |    6 ++++++
    1 file changed, 6 insertions(+)
   
  [POWERPC] spufs: invalidate SLB translation before adding a new entry
    Arnd Bergmann <arnd@arndb.de>

    arch/powerpc/platforms/cell/spu_base.c             |    4 ++++
    1 file changed, 4 insertions(+)
   
  [POWERPC] spufs: serialize SLB invalidation against SLB loading
    Arnd Bergmann <arnd@arndb.de>

    arch/powerpc/platforms/cell/spu_base.c             |   12 +++++++++---
    1 file changed, 9 insertions(+), 3 deletions(-)
   
  [POWERPC] spufs: fix use time accounting on SPE-overcommit
    Andre Detsch <adetsch@br.ibm.com>

    arch/powerpc/platforms/cell/spufs/sched.c          |    2 +-
    1 file changed, 1 insertion(+), 1 deletion(-)
   
