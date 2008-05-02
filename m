Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18458.44292.817770.800636@cargo.ozlabs.ibm.com>
Date: Fri, 2 May 2008 15:56:20 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: [git pull] Please pull powerpc.git master branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

With the exception of one commit from Grant Likely, these are all
fixes for various bugs and compile problems, or documentation
updates.  The one from Grant is something that has been around for a
month or so and only affects MPC5200-based embedded platforms.

Thanks,
Paul.

 .../powerpc/mpc52xx-device-tree-bindings.txt       |   11 ++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts             |   23 +++
 arch/powerpc/configs/ps3_defconfig                 |  132 +++++++++++++-------
 arch/powerpc/kernel/smp.c                          |    2 
 arch/powerpc/mm/slb.c                              |   27 ++--
 arch/powerpc/platforms/ps3/interrupt.c             |    6 -
 arch/powerpc/sysdev/fsl_rio.c                      |    9 +
 arch/powerpc/sysdev/fsl_soc.c                      |    4 -
 arch/powerpc/sysdev/xilinx_intc.c                  |    2 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c         |    6 -
 drivers/net/fec_mpc52xx.c                          |   97 +++++++++++----
 drivers/net/fec_mpc52xx.h                          |   19 ---
 drivers/ps3/ps3-lpm.c                              |    1 
 drivers/ps3/ps3-sys-manager.c                      |    7 -
 drivers/serial/mpc52xx_uart.c                      |    2 
 include/asm-powerpc/ps3.h                          |    3 
 include/linux/rio.h                                |    2 
 17 files changed, 231 insertions(+), 122 deletions(-)

Andrew Liu (1):
      Fix a potential issue in mpc52xx uart driver

Anton Vorontsov (1):
      [POWERPC] 86xx: mpc8610_hpcd: add support for PCI Express x8 slot

Becky Bruce (1):
      [POWERPC] Squash build warning for print of resource_size_t in fsl_soc.c

FUJITA Tomonori (1):
      [POWERPC] PS3: Add time include to lpm

Geert Uytterhoeven (1):
      [POWERPC] PS3: Make ps3_virq_setup and ps3_virq_destroy static

Geoff Levand (3):
      [POWERPC] Fix slb.c compile warnings
      [POWERPC] PS3: Remove unsupported wakeup sources
      [POWERPC] PS3: Update ps3_defconfig

Grant Likely (1):
      [POWERPC] mpc5200: Allow for fixed speed MII configurations

Jason Jin (1):
      [POWERPC] 86xx: Fix the wrong serial1 interrupt for 8610 board

Kumar Gala (1):
      [POWERPC] Xilinx: Fix compile warnings

Paul Mackerras (1):
      [POWERPC] Bolt in SLB entry for kernel stack on secondary cpus

Randy Dunlap (1):
      [RAPIDIO] fix current kernel-doc notation
