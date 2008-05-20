Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18482.45251.452257.145098@cargo.ozlabs.ibm.com>
Date: Tue, 20 May 2008 21:06:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [git pull] Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from the 'merge' branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a collection of small fixes and a defconfig update for
powerpc, plus an update to MAINTAINERS for the Cell port.

Thanks,
Paul.

 MAINTAINERS                            |   23 ++-
 arch/powerpc/boot/.gitignore           |    8 -
 arch/powerpc/boot/Makefile             |    6 +
 arch/powerpc/boot/dts/mpc8377_mds.dts  |   18 ++
 arch/powerpc/configs/chrp32_defconfig  |  164 +++++++++++++---------
 arch/powerpc/configs/g5_defconfig      |  226 +++++++++++++++----------------
 arch/powerpc/configs/iseries_defconfig |  146 +++++++++++++-------
 arch/powerpc/configs/pmac32_defconfig  |  174 +++++++++++++++---------
 arch/powerpc/configs/ppc64_defconfig   |  236 +++++++++++++++-----------------
 arch/powerpc/configs/pseries_defconfig |  224 +++++++++++++++---------------
 arch/powerpc/mm/hash_low_32.S          |    2 
 lib/lmb.c                              |    3 
 12 files changed, 675 insertions(+), 555 deletions(-)

Adrian Bunk (1):
      [POWERPC] powerpc/mm/hash_low_32.S: Remove CVS keyword

Arnd Bergmann (1):
      [POWERPC] Update Cell MAINTAINERS entry, add spufs entry

Kumar Gala (4):
      lmb: Fix compile warning
      [POWERPC] Remove generated files on make clean
      [POWERPC] Update arch/powerpc/boot/.gitignore
      [POWERPC] Fix mpc8377_mds.dts DMA nodes to match spec

Paul Mackerras (1):
      [POWERPC] Update defconfigs for desktop/server systems
