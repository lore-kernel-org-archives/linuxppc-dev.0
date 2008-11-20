Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Subject: [GIT PULL] Please pull spufs.git merge branch
Date: Fri, 21 Nov 2008 10:22:38 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200811211022.48669.jk@ozlabs.org>
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

git pull \
  git://git.kernel.org/pub/scm/linux/kernel/git/jk/spufs.git merge

For a spufs bugfix

Cheers,


Jeremy

---
diffstat:

 arch/powerpc/platforms/cell/spufs/file.c           |    3 +++
 1 file changed, 3 insertions(+)                              

1 commits:

  powerpc/spufs: Fix spinning in spufs_ps_fault on signal
    Jeremy Kerr <jk@ozlabs.org>
