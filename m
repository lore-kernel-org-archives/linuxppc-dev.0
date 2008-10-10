Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>,
	Ben Herrenschmidt <benh@kernel.crashing.org>
Subject: [GIT PULL] Please pull spufs merge branch
Date: Fri, 10 Oct 2008 11:22:32 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810101122.33224.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul / Ben,

Please do a:

git pull \
  git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git merge

For a few spufs fixes for 2.6.28

Cheers,


Jeremy

---
diffstat:

 arch/powerpc/platforms/cell/spufs/inode.c          |   11 ++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

3 commits:

  powerpc/spufs: set nlink count for spufs root correctly
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: use inc_nlink
    Jeremy Kerr <jk@ozlabs.org>

  powerpc/spufs: add a missing mutex_unlock
    Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
