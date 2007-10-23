Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18205.59569.182121.594684@cargo.ozlabs.ibm.com>
Date: Tue, 23 Oct 2007 22:27:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch again
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

Since the pull request I sent earlier today, I have added some more
commits to the powerpc.git merge branch, so if you have already done
the pull, please do another

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

There are 7 commits from Josh Boyer and Valentine Barshak that fix
some bugs on the 4xx embedded powerpc boards, and allow them to use
the ibm_newemac driver that has gone in recently via Jeff Garzik's
tree.

Thanks,
Paul.

 arch/powerpc/Kconfig.debug             |    1 
 arch/powerpc/boot/dts/bamboo.dts       |   10 ++-
 arch/powerpc/boot/dts/sequoia.dts      |   14 +++-
 arch/powerpc/boot/dts/walnut.dts       |   12 +++
 arch/powerpc/boot/treeboot-walnut.c    |    6 +-
 arch/powerpc/configs/bamboo_defconfig  |  114 +++++++++++++++++++-------------
 arch/powerpc/configs/ebony_defconfig   |  115 +++++++++++++++++++-------------
 arch/powerpc/configs/walnut_defconfig  |   94 +++++++++++++++-----------
 arch/powerpc/platforms/40x/Kconfig     |    1 
 arch/powerpc/platforms/44x/Kconfig     |    8 +-
 arch/powerpc/platforms/Kconfig.cputype |    1 
 11 files changed, 230 insertions(+), 146 deletions(-)

Josh Boyer (4):
      [POWERPC] 4xx: Enable EMAC on the PPC 440GP Ebony board
      [POWERPC] 4xx: Fix timebase clock selection on Walnut
      [POWERPC] 4xx: Enable EMAC for PPC405 Walnut board
      [POWERPC] 4xx: Enable EMAC on Bamboo board

Valentine Barshak (3):
      [POWERPC] 4xx: Add RGMII support for Sequoia 440EPx
      [POWERPC] 4xx: Enable NEW EMAC support for Sequoia 440EPx.
      [POWERPC] 4xx: Split early debug output and early boot console for 44x
