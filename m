Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18278.4237.784433.401363@cargo.ozlabs.ibm.com>
Date: Mon, 17 Dec 2007 17:00:45 +1100
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

to get some bugfixes and defconfig updates for powerpc.

Thanks,
Paul.

 arch/powerpc/configs/mpc8272_ads_defconfig |    6 +++---
 arch/powerpc/configs/pq2fads_defconfig     |    6 +++---
 arch/powerpc/configs/ps3_defconfig         |    2 +-
 arch/powerpc/kernel/ppc_ksyms.c            |   12 ------------
 arch/powerpc/math-emu/op-2.h               |    3 ++-
 arch/powerpc/platforms/iseries/lpevents.c  |   17 +++++++++++++++--
 arch/powerpc/platforms/ps3/Kconfig         |    2 +-
 arch/powerpc/sysdev/cpm2_common.c          |    3 +--
 drivers/net/fs_enet/mac-scc.c              |    2 +-
 include/asm-powerpc/commproc.h             |    3 ---
 10 files changed, 27 insertions(+), 29 deletions(-)

Jochen Friedrich (2):
      [POWERPC] Fix typo #ifdef -> #ifndef
      [POWERPC] Kill non-existent symbols from ksyms and commproc.h

Liu Yu (1):
      [POWERPC] Fix rounding bug in emulation for double float operating

Michael Ellerman (1):
      [POWERPC] Make PS3_SYS_MANAGER default y, not m

Scott Wood (2):
      [POWRPC] CPM2: Eliminate section mismatch warning in cpm2_reset().
      [POWERPC] 82xx: mpc8272ads, pq2fads: Update defconfig with CONFIG_FS_ENET_MDIO_FCC

Stephen Rothwell (1):
      [POWERPC] iSeries: don't printk with HV spinlock held
