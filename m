Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [GIT PULL] Please pull spufs merge branch
Date: Mon, 8 Sep 2008 09:49:50 +1000
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200809080949.50867.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please do a:

git pull \
  git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git merge

For a set of spufs fixes for .27. The first fixes a regression 
since .26, the second fixes a problem with unkillable processes, and 
the third a WARN_ON.

Cheers,


Jeremy

---
diffstat:

 arch/powerpc/platforms/cell/spufs/sched.c          |   29 +++++++---
 1 file changed, 23 insertions(+), 6 deletions(-)

3 commits:

  powerpc/spufs: Fix multiple get_spu_context()
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Fix race for a free SPU
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: Fix possible scheduling of a context to multiple SPEs
    Andre Detsch <adetsch@br.ibm.com>
