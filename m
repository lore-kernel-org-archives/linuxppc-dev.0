Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18205.15255.485057.815929@cargo.ozlabs.ibm.com>
Date: Tue, 23 Oct 2007 10:08:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git master branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

to get five more commits that fix some bugs for systems using the
Freescale embedded 52xx processors and enable them to restart
properly.

Thanks,
Paul.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |    4 +
 arch/powerpc/boot/dts/lite5200.dts                 |   26 +++----
 arch/powerpc/boot/dts/lite5200b.dts                |   26 +++----
 arch/powerpc/platforms/52xx/lite5200.c             |    4 +
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   71 +++++++++++++++++++-
 arch/powerpc/sysdev/bestcomm/bestcomm.c            |    9 ++-
 drivers/watchdog/mpc5200_wdt.c                     |    3 +
 include/asm-powerpc/mpc52xx.h                      |    9 +++
 8 files changed, 109 insertions(+), 43 deletions(-)

Grant Likely (1):
      [POWERPC] bestcomm: Restrict bus prefetch bugfix to original mpc5200 silicon.

Marian Balakowicz (4):
      [POWERPC] Add mpc52xx_find_and_map_path(), refactor utility functions
      [POWERPC] Update device tree binding for mpc5200 gpt
      [POWERPC] Add restart support for mpc52xx based platforms
      [POWERPC] Enable restart support for lite5200 board
