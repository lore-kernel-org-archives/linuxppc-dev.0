Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18392.27765.985520.828367@cargo.ozlabs.ibm.com>
Date: Thu, 13 Mar 2008 10:51:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get some more bug-fixes for various powerpc platforms.

Thanks,
Paul.

 arch/powerpc/Makefile                           |    2 
 arch/powerpc/boot/Makefile                      |   18 -
 arch/powerpc/boot/dts/mpc8377_mds.dts           |   70 ++
 arch/powerpc/boot/dts/mpc8378_mds.dts           |   70 ++
 arch/powerpc/boot/dts/mpc8379_mds.dts           |   70 ++
 arch/powerpc/boot/dts/sbc8548.dts               |   16 
 arch/powerpc/boot/wrapper                       |    6 
 arch/powerpc/configs/adder875-uboot_defconfig   |  798 -----------------------
 arch/powerpc/configs/adder875_defconfig         |   61 +-
 arch/powerpc/kernel/head_8xx.S                  |   30 +
 arch/powerpc/kernel/misc_32.S                   |   15 
 arch/powerpc/kernel/pci-common.c                |    8 
 arch/powerpc/kernel/ppc_ksyms.c                 |    3 
 arch/powerpc/mm/hash_utils_64.c                 |    4 
 arch/powerpc/platforms/83xx/mpc837x_mds.c       |    8 
 arch/powerpc/platforms/Kconfig                  |    1 
 arch/powerpc/platforms/Kconfig.cputype          |    7 
 arch/powerpc/platforms/cell/spufs/context.c     |    3 
 arch/powerpc/platforms/cell/spufs/run.c         |    3 
 arch/powerpc/platforms/cell/spufs/sched.c       |    4 
 arch/powerpc/platforms/cell/spufs/spufs.h       |    1 
 arch/powerpc/platforms/powermac/pic.c           |    2 
 arch/powerpc/sysdev/qe_lib/qe.c                 |    7 
 arch/ppc/kernel/head_8xx.S                      |   30 +
 drivers/block/viodasd.c                         |    3 
 drivers/macintosh/via-pmu-backlight.c           |    5 
 drivers/macintosh/via-pmu.c                     |    2 
 include/asm-powerpc/pgtable-ppc32.h             |    8 
 include/asm-ppc/pgtable.h                       |    8 
 include/linux/pmu.h                             |    9 
 30 files changed, 389 insertions(+), 883 deletions(-)
 delete mode 100644 arch/powerpc/configs/adder875-uboot_defconfig
 rename arch/powerpc/configs/{adder875-redboot_defconfig => adder875_defconfig} (95%)

Andy Fleming (1):
      [POWERPC] 83xx: Make 83xx perfmon support selectable

Benjamin Herrenschmidt (3):
      [POWERPC] Fix bogus test for unassigned PCI resources
      [POWERPC] Fix sleep on some powerbooks
      [POWERPC] Fix viodasd driver with scatterlist debug

Grant Likely (1):
      [POWERPC] Fix zImage-dtb.initrd build error

Guido Guenther (1):
      [POWERPC] Fix build of modular drivers/macintosh/apm_emu.c

Ionut Nicu (1):
      [POWERPC] QE: Make qe_get_firmware_info reentrant

Jeremy Kerr (2):
      [POWERPC] spufs: don't (ab)use SCHED_IDLE
      [POWERPC] spufs: fix rescheduling of non-runnable contexts

Jeremy McNicoll (1):
      [POWERPC] 85xx: sbc8548 - Fix incorrect PCI-X and PCI interrupt map

Li Yang (2):
      [POWERPC] 83xx: Fix wrong USB phy type in mpc837xmds dts
      [POWERPC] 83xx: Add local bus device nodes to MPC837xMDS device trees.

Michael Ellerman (1):
      [POWERPC] Fix large hash table allocation on Cell blades

Paul Mackerras (1):
      [POWERPC] Add __ucmpdi2 for 64-bit comparisons in 32-bit kernels

Scott Wood (1):
      [POWERPC] 8xx: Fix wrapper platform for adder875, and combine defconfigs.

Theodore Ts'o (1):
      [POWERPC] Export empty_zero_page

Timur Tabi (1):
      [POWERPC] QE: Fix QE firmware uploading limit

Tony Breeds (3):
      [POWERPC] Fix undefined pmu_sys_suspended compilation error
      [POWERPC] Fix drivers/macintosh/mediabay.c when !CONFIG_ADB_PMU
      [POWERPC] Fix arch/powerpc/platforms/powermac/pic.c when !CONFIG_ADB_PMU

Vitaly Bordug (1):
      [POWERPC] 8xx: fix swap

Yuri Tikhonov (1):
      [PPC] 8xx: swap bug-fix
