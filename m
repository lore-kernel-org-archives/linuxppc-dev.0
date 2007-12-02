Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18259.15345.627820.551644@cargo.ozlabs.ibm.com>
Date: Mon, 3 Dec 2007 10:12:49 +1100
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

There are two commits there; one reverts a patch which was causing
some machines to fail to come back up when rebooting, and the other
only touches a couple of defconfigs.

Thanks,
Paul.

 arch/powerpc/kernel/rtas.c             |   12 ++++++------
 arch/powerpc/platforms/pseries/setup.c |    3 +--
 arch/ppc/configs/ml300_defconfig       |    2 +-
 arch/ppc/configs/ml403_defconfig       |    2 +-
 include/asm-powerpc/rtas.h             |    3 +--
 5 files changed, 10 insertions(+), 12 deletions(-)

Grant Likely (1):
      [POWERPC] Remove xmon from ml300 and ml403 defconfig in arch/ppc

Paul Mackerras (1):
      Revert "[POWERPC] Fix RTAS os-term usage on kernel panic"
