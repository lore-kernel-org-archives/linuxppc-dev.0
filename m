Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17571.47868.286977.635819@cargo.ozlabs.ibm.com>
Date: Thu, 29 Jun 2006 21:35:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'master' branch
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

Please do a pull from the "master" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

to get some more powerpc updates, as listed below.

Thanks,
Paul.

 arch/powerpc/Kconfig                              |   23 -
 arch/powerpc/Kconfig.debug                        |    9 
 arch/powerpc/configs/cell_defconfig               |    7 
 arch/powerpc/configs/mpc7448_hpc2_defconfig       |  923 +++++++++++++++++++++
 arch/powerpc/kernel/Makefile                      |    3 
 arch/powerpc/kernel/cpu_setup_power4.S            |   14 
 arch/powerpc/kernel/cputable.c                    |   12 
 arch/powerpc/kernel/crash.c                       |  147 +++
 arch/powerpc/kernel/head_64.S                     |   62 -
 arch/powerpc/kernel/iommu.c                       |   30 +
 arch/powerpc/kernel/legacy_serial.c               |   11 
 arch/powerpc/kernel/lparcfg.c                     |  147 ++-
 arch/powerpc/kernel/machine_kexec_64.c            |    4 
 arch/powerpc/kernel/misc.S                        |  203 +++++
 arch/powerpc/kernel/misc_32.S                     |  156 ----
 arch/powerpc/kernel/misc_64.S                     |  223 -----
 arch/powerpc/kernel/paca.c                        |    1 
 arch/powerpc/kernel/prom.c                        |   49 +
 arch/powerpc/kernel/rtas.c                        |  119 ++-
 arch/powerpc/kernel/setup_64.c                    |   22 -
 arch/powerpc/kernel/traps.c                       |   27 -
 arch/powerpc/kernel/udbg.c                        |    7 
 arch/powerpc/mm/hash_native_64.c                  |    3 
 arch/powerpc/mm/hash_utils_64.c                   |  106 +-
 arch/powerpc/mm/mmu_context_64.c                  |    2 
 arch/powerpc/platforms/86xx/Kconfig               |    6 
 arch/powerpc/platforms/86xx/Makefile              |    3 
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h        |    1 
 arch/powerpc/platforms/86xx/mpc86xx.h             |    8 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |  129 +++
 arch/powerpc/platforms/86xx/mpc86xx_smp.c         |   10 
 arch/powerpc/platforms/86xx/pci.c                 |  137 ---
 arch/powerpc/platforms/Makefile                   |    1 
 arch/powerpc/platforms/cell/Kconfig               |    2 
 arch/powerpc/platforms/cell/setup.c               |   16 
 arch/powerpc/platforms/cell/spu_base.c            |    8 
 arch/powerpc/platforms/cell/spufs/file.c          |   10 
 arch/powerpc/platforms/cell/spufs/switch.c        |    6 
 arch/powerpc/platforms/embedded6xx/Kconfig        |   15 
 arch/powerpc/platforms/embedded6xx/Makefile       |    4 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |  335 ++++++++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |   26 +
 arch/powerpc/platforms/iseries/dt.c               |    2 
 arch/powerpc/platforms/iseries/htab.c             |    4 
 arch/powerpc/platforms/iseries/lpevents.c         |   55 +
 arch/powerpc/platforms/iseries/proc.c             |    1 
 arch/powerpc/platforms/iseries/setup.c            |   19 
 arch/powerpc/platforms/maple/setup.c              |    7 
 arch/powerpc/platforms/powermac/setup.c           |    9 
 arch/powerpc/platforms/pseries/iommu.c            |   33 +
 arch/powerpc/platforms/pseries/lpar.c             |    4 
 arch/powerpc/platforms/pseries/setup.c            |   10 
 arch/powerpc/sysdev/Makefile                      |    2 
 arch/powerpc/sysdev/dart.h                        |    6 
 arch/powerpc/sysdev/dart_iommu.c                  |   49 +
 arch/powerpc/sysdev/todc.c                        |  392 +++++++++
 arch/powerpc/sysdev/tsi108_dev.c                  |  145 +++
 arch/powerpc/sysdev/tsi108_pci.c                  |  412 +++++++++
 drivers/ide/Kconfig                               |    9 
 drivers/ide/ppc/pmac.c                            |  125 ---
 drivers/macintosh/Kconfig                         |   12 
 drivers/macintosh/Makefile                        |    1 
 drivers/macintosh/via-pmu-led.c                   |  144 +++
 include/asm-powerpc/cputable.h                    |   48 -
 include/asm-powerpc/iseries/it_lp_queue.h         |   40 -
 include/asm-powerpc/kdump.h                       |    2 
 include/asm-powerpc/kexec.h                       |    9 
 include/asm-powerpc/machdep.h                     |    2 
 include/asm-powerpc/mmu.h                         |    1 
 include/asm-powerpc/mmu_context.h                 |    7 
 include/asm-powerpc/mpc86xx.h                     |    5 
 include/asm-powerpc/rtas.h                        |    3 
 include/asm-powerpc/time.h                        |    6 
 include/asm-powerpc/todc.h                        |  487 +++++++++++
 include/asm-powerpc/tsi108.h                      |  109 ++
 include/asm-powerpc/udbg.h                        |    3 
 kernel/kexec.c                                    |    6 
 77 files changed, 4086 insertions(+), 1110 deletions(-)
 create mode 100644 arch/powerpc/configs/mpc7448_hpc2_defconfig
 create mode 100644 arch/powerpc/kernel/misc.S
 create mode 100644 arch/powerpc/platforms/embedded6xx/Makefile
 create mode 100644 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h
 create mode 100644 arch/powerpc/sysdev/todc.c
 create mode 100644 arch/powerpc/sysdev/tsi108_dev.c
 create mode 100644 arch/powerpc/sysdev/tsi108_pci.c
 create mode 100644 drivers/macintosh/via-pmu-led.c
 create mode 100644 include/asm-powerpc/todc.h
 create mode 100644 include/asm-powerpc/tsi108.h

Andrew Morton:
      [POWERPC] powerpc: kconfig warning fix

Arnd Bergmann:
      [POWERPC] spufs: fix class0 interrupt assignment

Benjamin Herrenschmidt:
      [POWERPC] spufs: map mmio space as guarded into user space
      [POWERPC] spufs: fix MFC command queue purge

David Wilder:
      [POWERPC] Add the use of the firmware soft-reset-nmi to kdump.

Geoff Levand:
      [POWERPC] spufs: fix memory hotplug dependency

Haren Myneni:
      [POWERPC] kdump: Reserve the existing TCE mappings left by the first kernel

Jimi Xenidis:
      [POWERPC] Don't access HID registers if running on a Hypervisor.
      [POWERPC] Skip the "copy down" of the kernel if it is already at zero.

Johannes Berg:
      [POWERPC] Convert powermac ide blink to new led infrastructure

Jon Loeliger:
      [POWERPC] Remove redundant PPC_86XX check.
      [POWERPC] Move I8259 selection under MPC8641HPCN board
      [POWERPC] Remove redundant STD_MMU selection.
      [POWERPC] Remove obsolete #include <linux/config.h>.

Kumar Gala:
      powerpc: minor cleanups for mpc86xx

Mark A. Greer:
      [POWERPC] todc: add support for Time-Of-Day-Clock

Michael Ellerman:
      [POWERPC] Remove remaining iSeries debugger cruft
      [POWERPC] Export flat device tree via debugfs for debugging
      [POWERPC] powerpc: Initialise ppc_md htab pointers earlier
      [POWERPC] Use ppc_md.hpte_insert() in htab_bolt_mapping()
      [POWERPC] Make kexec_setup() a regular initcall
      [POWERPC] Setup the boot cpu's paca pointer in C rather than asm
      [POWERPC] Make rtas_call() safe if RTAS hasn't been initialised
      [POWERPC] Move RTAS exports next to their declarations
      [POWERPC] Setup RTAS values earlier, to enable rtas_call() earlier
      [POWERPC] Add udbg support for RTAS console
      [POWERPC] Enable the RTAS udbg console on IBM Cell Blade
      [POWERPC] Enable XMON in cell_defconfig
      [POWERPC] Make sure smp_processor_id works very early in boot

Olof Johansson:
      [POWERPC] U4 DART improvements

Paul Mackerras:
      [POWERPC] Simplify the code defining the 64-bit CPU features
      [POWERPC] Make sure we select CONFIG_NEW_LEDS if ADB_PMU_LED is set
      [POWERPC] Correct the MAX_CONTEXT definition
      [POWERPC] Use little-endian bit from firmware ibm,pa-features property

Sonny Rao:
      [POWERPC] Fix idr locking in init_new_context

Stephen Rothwell:
      [POWERPC] Clean up it_lp_queue.h
      [POWERPC] update asm-powerpc/time.h
      [POWERPC] Remove unused function call_with_mmu_off
      [POWERPC] Consolidate some of kernel/misc*.S
      [POWERPC] Make lparcfg.c work when both iseries and pseries are selected

Zang Roy-r61911:
      [POWERPC] Add general support for mpc7448hpc2 (Taiga) platform
      [POWERPC] Add tsi108 pci and platform device data register function
      [POWERPC] mpc7448hpc2 (taiga) board config file
