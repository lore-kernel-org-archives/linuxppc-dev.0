Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 585CC67A2E
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 17:14:22 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k5S7PHFU004879
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 00:25:17 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5S7EAjK011093
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 02:14:12 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306DD16AC@zch01exm40.ap.freescale.net>
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Subject: RE: patches applied to powerpc.git
Date: Wed, 28 Jun 2006 15:14:10 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@ozlabs.org, linux-kernel-owner@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, Paul

	I have submitted the "v2" version for mpc7448hpc2 board support in arch/powerpc/platforms/embedded6xx.
	I  have not got any suggestion, since I submitted the code.
	In this submission I have addressed all the issues brought up in the "v1" submission. 
	So could you help me merge the patches into your git tree ? If there is any comment about the code, please let me know.
	Thanks a lot!

Roy 

> 
> The following patches have just been pushed to the 
> powerpc.git repository ("master" branch).  I'll ask Linus to 
> pull them tomorrow unless I hear any objections.  If you have 
> patches that you want upstream that aren't listed, bug me or 
> the appropriate platform maintainer about them.
> 
> Paul.
> 
>  arch/powerpc/Kconfig                       |    8 +
>  arch/powerpc/Kconfig.debug                 |    9 +
>  arch/powerpc/configs/cell_defconfig        |    7 +
>  arch/powerpc/kernel/Makefile               |    3 
>  arch/powerpc/kernel/cpu_setup_power4.S     |   14 ++
>  arch/powerpc/kernel/crash.c                |  147 +++++++++++++++---
>  arch/powerpc/kernel/head_64.S              |   51 ++----
>  arch/powerpc/kernel/iommu.c                |   30 ++++
>  arch/powerpc/kernel/machine_kexec_64.c     |    4 -
>  arch/powerpc/kernel/misc.S                 |  203 
> +++++++++++++++++++++++++
>  arch/powerpc/kernel/misc_32.S              |  156 
> --------------------
>  arch/powerpc/kernel/misc_64.S              |  223 
> +---------------------------
>  arch/powerpc/kernel/paca.c                 |    1 
>  arch/powerpc/kernel/prom.c                 |   48 ++++--
>  arch/powerpc/kernel/rtas.c                 |  119 +++++++++++++--
>  arch/powerpc/kernel/setup_64.c             |   19 +-
>  arch/powerpc/kernel/traps.c                |   27 ++-
>  arch/powerpc/kernel/udbg.c                 |    7 +
>  arch/powerpc/mm/hash_native_64.c           |    3 
>  arch/powerpc/mm/hash_utils_64.c            |  106 +++++--------
>  arch/powerpc/platforms/86xx/Kconfig        |    6 -
>  arch/powerpc/platforms/86xx/Makefile       |    3 
>  arch/powerpc/platforms/86xx/mpc8641_hpcn.h |    1 
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 
>  arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    1 
>  arch/powerpc/platforms/86xx/pci.c          |    1 
>  arch/powerpc/platforms/cell/Kconfig        |    2 
>  arch/powerpc/platforms/cell/setup.c        |   16 +-
>  arch/powerpc/platforms/cell/spu_base.c     |    8 +
>  arch/powerpc/platforms/cell/spufs/file.c   |   10 +
>  arch/powerpc/platforms/cell/spufs/switch.c |    6 +
>  arch/powerpc/platforms/iseries/htab.c      |    4 -
>  arch/powerpc/platforms/iseries/lpevents.c  |   55 ++++---
>  arch/powerpc/platforms/iseries/proc.c      |    1 
>  arch/powerpc/platforms/iseries/setup.c     |   19 --
>  arch/powerpc/platforms/maple/setup.c       |    7 -
>  arch/powerpc/platforms/powermac/setup.c    |    9 -
>  arch/powerpc/platforms/pseries/iommu.c     |   33 ++++
>  arch/powerpc/platforms/pseries/lpar.c      |    4 -
>  arch/powerpc/platforms/pseries/setup.c     |   10 +
>  drivers/ide/Kconfig                        |    9 +
>  drivers/ide/ppc/pmac.c                     |  125 ----------------
>  drivers/macintosh/Kconfig                  |   12 ++
>  drivers/macintosh/Makefile                 |    1 
>  drivers/macintosh/via-pmu-led.c            |  144 ++++++++++++++++++
>  include/asm-powerpc/cputable.h             |   48 +++---
>  include/asm-powerpc/iseries/it_lp_queue.h  |   40 +++--
>  include/asm-powerpc/kdump.h                |    2 
>  include/asm-powerpc/kexec.h                |    9 +
>  include/asm-powerpc/machdep.h              |    2 
>  include/asm-powerpc/mmu.h                  |    1 
>  include/asm-powerpc/mpc86xx.h              |    1 
>  include/asm-powerpc/rtas.h                 |    3 
>  include/asm-powerpc/time.h                 |    6 +
>  include/asm-powerpc/udbg.h                 |    3 
>  kernel/kexec.c                             |    6 -
>  56 files changed, 936 insertions(+), 858 deletions(-)  
> create mode 100644 arch/powerpc/kernel/misc.S  create mode 
> 100644 drivers/macintosh/via-pmu-led.c
> 
> Andrew Morton:
>       [POWERPC] powerpc: kconfig warning fix
> 
> Arnd Bergmann:
>       [POWERPC] spufs: fix class0 interrupt assignment
> 
> Benjamin Herrenschmidt:
>       [POWERPC] spufs: map mmio space as guarded into user space
>       [POWERPC] spufs: fix MFC command queue purge
> 
> David Wilder:
>       [POWERPC] Add the use of the firmware soft-reset-nmi to kdump.
> 
> Geoff Levand:
>       [POWERPC] spufs: fix memory hotplug dependency
> 
> Haren Myneni:
>       [POWERPC] kdump: Reserve the existing TCE mappings left 
> by the first kernel
> 
> Jimi Xenidis:
>       [POWERPC] Don't access HID registers if running on a Hypervisor.
>       [POWERPC] Skip the "copy down" of the kernel if it is 
> already at zero.
> 
> Johannes Berg:
>       [POWERPC] Convert powermac ide blink to new led infrastructure
> 
> Jon Loeliger:
>       [POWERPC] Remove redundant PPC_86XX check.
>       [POWERPC] Move I8259 selection under MPC8641HPCN board
>       [POWERPC] Remove redundant STD_MMU selection.
>       [POWERPC] Remove obsolete #include <linux/config.h>.
> 
> Michael Ellerman:
>       [POWERPC] Remove remaining iSeries debugger cruft
>       [POWERPC] Export flat device tree via debugfs for debugging
>       [POWERPC] powerpc: Initialise ppc_md htab pointers earlier
>       [POWERPC] Use ppc_md.hpte_insert() in htab_bolt_mapping()
>       [POWERPC] Make kexec_setup() a regular initcall
>       [POWERPC] Setup the boot cpu's paca pointer in C rather than asm
>       [POWERPC] Make rtas_call() safe if RTAS hasn't been initialised
>       [POWERPC] Move RTAS exports next to their declarations
>       [POWERPC] Setup RTAS values earlier, to enable 
> rtas_call() earlier
>       [POWERPC] Add udbg support for RTAS console
>       [POWERPC] Enable the RTAS udbg console on IBM Cell Blade
>       [POWERPC] Enable XMON in cell_defconfig
> 
> Paul Mackerras:
>       [POWERPC] Simplify the code defining the 64-bit CPU features
>       [POWERPC] Make sure we select CONFIG_NEW_LEDS if 
> ADB_PMU_LED is set
> 
> Stephen Rothwell:
>       [POWERPC] Clean up it_lp_queue.h
>       [POWERPC] update asm-powerpc/time.h
>       [POWERPC] Remove unused function call_with_mmu_off
>       [POWERPC] Consolidate some of kernel/misc*.S
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
