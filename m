Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18299.8054.953879.43676@cargo.ozlabs.ibm.com>
Date: Wed, 2 Jan 2008 16:21:58 +1100
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

to get a fix for a bug introduced in one of the two commits I asked
you to pull last time.

Thanks,
Paul.

 arch/powerpc/platforms/cell/spufs/sched.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

commit a5a971129cc6155e26315fd28a450505ccc35fd8
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Jan 2 15:56:30 2008 +1100

    [POWERPC] Fix build failure on Cell when CONFIG_SPU_FS=y
    
    Commit aed3a8c9bb1a8623a618232087c5ff62718e3b9a introduced a
    definition of notify_spus_active in .../cell/spu_syscalls.c, and
    another definition under #ifndef MODULE in .../cell/spufs/sched.c.
    The latter is not necessary and causes the build to fail when
    CONFIG_SPU_FS=y, so this removes it.  It also removes the export
    of do_notify_spus_active, which is unnecessary.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>
    Acked-by: Arnd Bergmann <arnd@arndb.de>
    Acked-by: Jeremy Kerr <jk@ozlabs.org>
