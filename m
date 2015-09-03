Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A06F71A1E60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2015 16:15:03 +1000 (AEST)
Message-ID: <1441260902.29016.8.camel@ellerman.id.au>
Subject: [git pull] Please pull powerpc/linux.git powerpc-4.3-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: B48286@freescale.com, Jason.Jin@freescale.com,
 Priyanka.Jain@freescale.com,  Shaohui.Xie@freescale.com,
 Shengzhou.Liu@freescale.com, a.hajda@samsung.com,  aik@ozlabs.ru,
 andrew.donnellan@au1.ibm.com, anton@samba.org, b44839@freescale.com,
 benh@kernel.crashing.org, christophe.leroy@c-s.fr,
 computersforpeace@gmail.com,  cyrilbur@gmail.com, dja@axtens.net,
 dongsheng.wang@freescale.com,  ego@linux.vnet.ibm.com,
 felix@linux.vnet.ibm.com, gsi@denx.de,  gwshan@linux.vnet.ibm.com,
 haokexin@gmail.com, hbathini@linux.vnet.ibm.com,
 hegdevasant@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 j.anaszewski@samsung.com,  javier@osg.samsung.com, jk@ozlabs.org,
 joe@perches.com, jthumshirn@suse.de,  keescook@chromium.org,
 khandual@linux.vnet.ibm.com, ldufour@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
 linuxppc-dev@lists.ozlabs.org, mahesh@linux.vnet.ibm.com,
 mikey@neuling.org,  naveen.n.rao@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, paulus@samba.org,  pebolle@tiscali.nl,
 rostedt@goodmis.org, sam.mj@au1.ibm.com,  scottwood@freescale.com,
 stewart@linux.vnet.ibm.com, sukadev@linux.vnet.ibm.com,  thuth@redhat.com,
 vaibhav@linux.vnet.ibm.com, vipin@linux.vnet.ibm.com,
 vthakkar1994@gmail.com, weiyang@linux.vnet.ibm.com,
 yangbo.lu@freescale.com,  yao.yuan@freescale.com,
 yongjun_wei@trendmicro.com.cn
Date: Thu, 03 Sep 2015 16:15:02 +1000
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-3bc6gVKk9HhXeYiWj2Qg"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-3bc6gVKk9HhXeYiWj2Qg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.3:

The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590=
:

  Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.3-1

for you to fetch changes up to 390fd5929f52bdfb9dfcc03820041ba556780f4a:

  cxl: Set up and enable PSL Timebase (2015-08-30 18:56:34 +1000)

----------------------------------------------------------------
powerpc updates for 4.3

 - Support "hybrid" iommu/direct DMA ops for coherent_mask < dma_mask from =
Benjamin Herrenschmidt
 - EEH fixes for SRIOV from Gavin
 - Introduce rtas_get_sensor_fast() for IRQ handlers from Thomas Huth
 - Use hardware RNG for arch_get_random_seed_* not arch_get_random_* from P=
aul Mackerras
 - Seccomp filter support from Michael Ellerman
 - opal_cec_reboot2() handling for HMIs & machine checks from Mahesh Salgao=
nkar
 - Add powerpc timebase as a trace clock source from Naveen N. Rao
 - Misc cleanups in the xmon, signal & SLB code from Anshuman Khandual
 - Add an inline function to update POWER8 HID0 from Gautham R. Shenoy
 - Fix pte_pagesize_index() crash on 4K w/64K hash from Michael Ellerman
 - Drop support for 64K local store on 4K kernels from Michael Ellerman
 - move dma_get_required_mask() from pnv_phb to pci_controller_ops from And=
rew Donnellan
 - Initialize distance lookup table from drconf path from Nikunj A Dadhania
 - Enable RTC class support from Vaibhav Jain
 - Disable automatically blocked PCI config from Gavin Shan
 - Add LEDs driver for PowerNV platform from Vasant Hegde
 - Fix endianness issues in the HVSI driver from Laurent Dufour
 - Kexec endian fixes from Samuel Mendoza-Jonas
 - Fix corrupted pdn list from Gavin Shan
 - Fix fenced PHB caused by eeh_slot_error_detail() from Gavin Shan

 - Freescale updates from Scott: Highlights include 32-bit memcpy/memset
   optimizations, checksum optimizations, 85xx config fragments and updates=
,
   device tree updates, e6500 fixes for non-SMP, and misc cleanup and minor
   fixes.

 - A ton of cxl updates & fixes:
  - Add explicit precision specifiers from Rasmus Villemoes
  - use more common format specifier from Rasmus Villemoes
  - Destroy cxl_adapter_idr on module_exit from Johannes Thumshirn
  - Destroy afu->contexts_idr on release of an afu from Johannes Thumshirn
  - Compile with -Werror from Daniel Axtens
  - EEH support from Daniel Axtens
  - Plug irq_bitmap getting leaked in cxl_context from Vaibhav Jain
  - Add alternate MMIO error handling from Ian Munsie
  - Allow release of contexts which have been OPENED but not STARTED from A=
ndrew Donnellan
  - Remove use of macro DEFINE_PCI_DEVICE_TABLE from Vaishali Thakkar
  - Release irqs if memory allocation fails from Vaibhav Jain
  - Remove racy attempt to force EEH invocation in reset from Daniel Axtens
  - Fix + cleanup error paths in cxl_dev_context_init from Ian Munsie
  - Fix force unmapping mmaps of contexts allocated through the kernel api =
from Ian Munsie
  - Set up and enable PSL Timebase from Philippe Bergheaud

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc/iommu: Set default DMA offset in dma_dev_setup

Andrew Donnellan (2):
      powerpc/powernv: move dma_get_required_mask from pnv_phb to pci_contr=
oller_ops
      cxl: Allow release of contexts which have been OPENED but not STARTED

Andrzej Hajda (2):
      powerpc/pseries: use kmemdup rather than duplicating its implementati=
on
      powerpc/nvram: use kmemdup rather than duplicating its implementation

Anshuman Khandual (11):
      powerpc/tm: Drop tm_orig_msr from thread_struct
      powerpc/signal: Fix confusing header documentation in sigcontext.h
      powerpc/signal: Add helper function to fetch quad word aligned pointe=
r
      powerpc/perf: Change type of the bhrb_users variable
      powerpc/slb: Remove a duplicate extern variable
      powerpc/slb: Rename all the 'slot' occurrences to 'entry'
      powerpc/slb: Add documentation on runtime patching of SLB encoding
      powerpc/prom: Simplify the logic to fetch SLB size
      powerpc/xmon: Drop the valid variable completely in dump_segments()
      powerpc/prom: Use DRCONF flags while processing detected LMBs
      powerpc/powernv: Add OPAL interfaces for accessing and modifying syst=
em LED states

Anton Blanchard (1):
      powerpc: Remove mtmsrd(), use existing mtmsr()

Benjamin Herrenschmidt (3):
      powerpc/iommu: Remove dma_data union
      powerpc/iommu: Cleanup setting of DMA base/offset
      powerpc/iommu: Support "hybrid" iommu/direct DMA ops for coherent_mas=
k < dma_mask

Daniel Axtens (17):
      cxl: Don't ignore add_process_element() result when attaching context
      cxl: Compile with -Werror
      cxl: sparse: Make declarations static
      cxl: sparse: Silence iomem warning in debugfs file creation
      powerpc/eeh: Probe after unbalanced kref check
      cxl: Convert MMIO read/write macros to inline functions
      cxl: Drop commands if the PCI channel is not in normal state
      cxl: Allocate and release the SPA with the AFU
      cxl: Make IRQ release idempotent
      cxl: Clean up adapter MMIO unmap path.
      cxl: Refactor adaptor init/teardown
      cxl: Refactor AFU init/teardown
      cxl: Don't remove AFUs/vPHBs in cxl_reset
      cxl: Allow the kernel to trust that an image won't change on PERST.
      cxl: EEH support
      cxl: Add CONFIG_CXL_EEH symbol
      cxl: Remove racy attempt to force EEH invocation in reset

Gautham R. Shenoy (1):
      powerpc: Add an inline function to update POWER8 HID0

Gavin Shan (13):
      powerpc/powernv: Allow to reserve one PE for multiple times
      powerpc/powernv: Reserve M64 PEs based on BARs
      powerpc/powernv: Boolean argument for pnv_ioda_setup_bus_PE()
      powerpc/powernv: Pick M64 PEs based on BARs
      powerpc/powernv: Include VF PE in PELTV of PF PE
      powerpc/powernv: Unfreeze VF PE on releasing it
      powerpc/eeh: Fix wrong printed PE number
      powerpc/eeh: Dump PHB diag-data for non-existing PE
      powerpc: Export include/uapi/asm/eeh.h
      powerpc/eeh: Disable automatically blocked PCI config
      powerpc/pseries: Fix corrupted pdn list
      powerpc/pseries: Cleanup on pci_dn_reconfig_notifier()
      powerpc/eeh: Fix fenced PHB caused by eeh_slot_error_detail()

Gerhard Sittig (1):
      powerpc/512x: silence a USB Kconfig dependency warning

Hari Bathini (1):
      powerpc/nvram: print no error when pstore backend is not nvram

Hou Zhiqiang (1):
      powerpc/85xx: Remove unused pci fixup hooks on c293pcie

Ian Munsie (3):
      cxl: Add alternate MMIO error handling
      cxl: Fix + cleanup error paths in cxl_dev_context_init
      cxl: Fix force unmapping mmaps of contexts allocated through the kern=
el api

Jaiprakash Singh (2):
      fsl_ifc: Change IO accessor based on endianness
      powerpc/t1023rdb/dts: set ifc nand chip select from 2 to 1

Jason Jin (1):
      powerpc: Add a vga alias node for P1022

Javier Martinez Canillas (2):
      macintosh/therm_windtunnel: Export I2C module alias information
      macintosh/therm_windtunnel: Export OF module alias information

Joe Perches (1):
      powerpc: Remove redundant breaks

Johannes Thumshirn (2):
      cxl: Destroy cxl_adapter_idr on module_exit
      cxl: Destroy afu->contexts_idr on release of an afu

Kevin Hao (3):
      powerpc: pci: use %pR for printing struct resource
      powerpc/e6500: remove the stale TCD_LOCK macro
      powerpc/e6500: hw tablewalk: optimize a bit for tcd lock acquiring co=
des

LEROY Christophe (8):
      powerpc: put csum_tcpudp_magic inline
      powerpc: add support for csum_add()
      powerpc: use memset_io() to clear CPM Muram
      Partially revert "powerpc: Remove duplicate cacheable_memcpy/memzero =
functions"
      powerpc/32: memset(0): use cacheable_memzero
      powerpc/32: Merge the new memset() with the old one
      powerpc/32: cacheable_memcpy becomes memcpy
      powerpc/32: Few optimisations in memcpy

Laurent Dufour (1):
      powerpc/hvsi: Fix endianness issues in the HVSI driver

Mahesh Salgaonkar (4):
      powerpc/powernv: display reason for Malfunction Alert HMI.
      powerpc/powernv: Pull all HMI events before panic.
      powerpc/powernv: Invoke opal_cec_reboot2() on unrecoverable machine c=
heck errors.
      powerpc/powernv: Invoke opal_cec_reboot2() on unrecoverable HMI.

Michael Ellerman (21):
      powerpc: Add macros for the ibm_architecture_vec[] lengths
      powerpc/kernel: Switch to using MAX_ERRNO
      powerpc/kernel: Change the do_syscall_trace_enter() API
      powerpc: Drop unused syscall_get_error()
      powerpc: Don't negate error in syscall_set_return_value()
      powerpc: Rework syscall_get_arguments() so there is only one loop
      powerpc: Use orig_gpr3 in syscall_get_arguments()
      powerpc: Change syscall_get_nr() to return int
      powerpc/kernel: Add SIG_SYS support for compat tasks
      powerpc/kernel: Enable seccomp filter
      selftests/seccomp: Make seccomp tests work on big endian
      selftests/seccomp: Add powerpc support
      powerpc: Update corenet32_smp_defconfig for modern distros
      selftests/powerpc: Install tempfile so the subpage_prot_file test wor=
ks
      powerpc/mm: Fix pte_pagesize_index() crash on 4K w/64K hash
      powerpc/cell: Drop support for 64K local store on 4K kernels
      powerpc/mm: Drop the 64K on 4K version of pte_pagesize_index()
      powerpc/mm: Simplify page size kconfig dependencies
      powerpc/mm: Drop CONFIG_PPC_HAS_HASH_64K
      powerpc/powernv: Fix mis-merge of OPAL support for LEDS driver
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Naveen N. Rao (1):
      powerpc/ftrace: add powerpc timebase as a trace clock source

Nikunj A Dadhania (1):
      powerpc/numa: initialize distance lookup table from drconf path

Paul Bolle (3):
      windfarm: decrement client count when unregistering
      windfarm: make wf_critical_overtemp() static
      windfarm: remove three exported but unused functions

Paul Mackerras (1):
      powerpc: Use hardware RNG for arch_get_random_seed_* not arch_get_ran=
dom_*

Philippe Bergheaud (1):
      cxl: Set up and enable PSL Timebase

Priyanka Jain (1):
      powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board support

Rasmus Villemoes (2):
      cxl: Add explicit precision specifiers
      cxl: use more common format specifier

Samuel Mendoza-Jonas (2):
      powerpc/kexec: Reset secondary cpu endianness before kexec
      powerpc/powernv: Reset HILE before kexec_sequence()

Scott Wood (5):
      powerpc/85xx: Make defconfigs consistent
      powerpc/85xx: Use kconfig fragments
      powerpc/mm: Don't call __flush_dcache_icache_phys() with PA>VA
      powerpc/booke64: Move mb() to __set_pte_at() with kernel-addr test
      powerpc/fsl: Force coherent memory on e500mc derivatives

Shaohui Xie (2):
      powerpc/85xx: enable teranetics PHY
      powerpc/config: enable aquantia PHY

Shengzhou Liu (2):
      powerpc/t1024rdb: add ina220 current sensor node
      powerpc/t1023rdb: add ina220 current sensor node

Sukadev Bhattiprolu (2):
      powerpc/perf/hv-24x7: Whitespace - fix parameter alignment
      powerpc/perf/hv-24x7: Simplify extracting counter from result buffer

Thomas Huth (2):
      powerpc/rtas: Replace magic values with defines
      powerpc/rtas: Introduce rtas_get_sensor_fast() for IRQ handlers

Vaibhav Jain (3):
      cxl: Plug irq_bitmap getting leaked in cxl_context
      powerpc/pseries: enable RTC class support
      cxl: Release irqs if memory allocation fails

Vaishali Thakkar (1):
      cxl: Remove use of macro DEFINE_PCI_DEVICE_TABLE

Vasant Hegde (3):
      powerpc/powernv: Create LED platform device
      leds/powernv: Add driver for PowerNV platform
      powerpc/powernv: Enable LEDS support

Vipin K Parashar (1):
      powerpc/powernv: Add poweroff (EPOW, DPO) events support for PowerNV =
platform

Wang Dongsheng (2):
      powerpc/85xx: Add binding for SCFG
      powerpc/mpc85xx:Add SCFG device tree support of T104x

Wei Yang (1):
      powerpc/powernv: Fix the log message when disabling VF

Wei Yongjun (1):
      powerpc/4xx: Fix return value check in hsta_msi_probe()

Yangbo Lu (1):
      powerpc/corenet: enable eSDHC

Yao Yuan (1):
      powerpc/corenet32: enable DMA in defconfig

 Documentation/ABI/testing/sysfs-class-cxl          |  10 +
 .../devicetree/bindings/leds/leds-powernv.txt      |  26 +
 .../bindings/memory-controllers/fsl/ifc.txt        |   3 +
 .../devicetree/bindings/powerpc/fsl/scfg.txt       |  18 +
 Documentation/trace/ftrace.txt                     |   5 +
 arch/powerpc/Kconfig                               |  22 +-
 arch/powerpc/Makefile                              |  20 +
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   5 +
 arch/powerpc/boot/dts/t1023rdb.dts                 |  13 +-
 arch/powerpc/boot/dts/t1024rdb.dts                 |   6 +
 arch/powerpc/boot/dts/t1040d4rdb.dts               |  46 ++
 arch/powerpc/boot/dts/t1042d4rdb.dts               |  53 ++
 arch/powerpc/boot/dts/t104xd4rdb.dtsi              | 205 +++++++
 arch/powerpc/configs/85xx-32bit.config             |   5 +
 arch/powerpc/configs/85xx-64bit.config             |   4 +
 arch/powerpc/configs/85xx-hw.config                | 142 +++++
 arch/powerpc/configs/85xx-smp.config               |   2 +
 arch/powerpc/configs/altivec.config                |   1 +
 arch/powerpc/configs/corenet32_smp_defconfig       | 185 -------
 arch/powerpc/configs/corenet_basic_defconfig       |   1 +
 ...orenet64_smp_defconfig =3D> fsl-emb-nonhw.config} | 264 ++++-----
 arch/powerpc/configs/mpc85xx_basic_defconfig       |  23 +
 arch/powerpc/configs/mpc85xx_defconfig             | 252 ---------
 arch/powerpc/configs/mpc85xx_smp_defconfig         | 244 --------
 arch/powerpc/configs/ppc64_defconfig               |   3 +
 arch/powerpc/configs/pseries_defconfig             |   6 +-
 arch/powerpc/include/asm/Kbuild                    |   1 -
 arch/powerpc/include/asm/archrandom.h              |  28 +-
 arch/powerpc/include/asm/cacheflush.h              |   7 +-
 arch/powerpc/include/asm/checksum.h                |  37 +-
 arch/powerpc/include/asm/compat.h                  |   7 +
 arch/powerpc/include/asm/device.h                  |  15 +-
 arch/powerpc/include/asm/dma-mapping.h             |  14 +-
 arch/powerpc/include/asm/iommu.h                   |  31 +-
 arch/powerpc/include/asm/machdep.h                 |   2 +-
 arch/powerpc/include/asm/opal-api.h                | 124 ++++-
 arch/powerpc/include/asm/opal.h                    |   8 +-
 arch/powerpc/include/asm/pci-bridge.h              |   1 +
 arch/powerpc/include/asm/pgtable-ppc64.h           |   8 +-
 arch/powerpc/include/asm/pgtable.h                 |  11 +
 arch/powerpc/include/asm/ppc-pci.h                 |   1 +
 arch/powerpc/include/asm/processor.h               |   1 -
 arch/powerpc/include/asm/pte-common.h              |   3 +-
 arch/powerpc/include/asm/reg.h                     |  12 +-
 arch/powerpc/include/asm/rtas.h                    |   1 +
 arch/powerpc/include/asm/spu_csa.h                 |   6 -
 arch/powerpc/include/asm/syscall.h                 |  54 +-
 arch/powerpc/include/asm/trace_clock.h             |  19 +
 arch/powerpc/include/uapi/asm/Kbuild               |   1 +
 arch/powerpc/include/uapi/asm/errno.h              |   2 -
 arch/powerpc/include/uapi/asm/sigcontext.h         |   4 +-
 arch/powerpc/kernel/Makefile                       |   1 +
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/dma-iommu.c                    |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c                  |   4 +-
 arch/powerpc/kernel/dma.c                          | 118 +++-
 arch/powerpc/kernel/eeh.c                          |  31 +-
 arch/powerpc/kernel/eeh_pe.c                       |  22 +
 arch/powerpc/kernel/entry_32.S                     |   7 +-
 arch/powerpc/kernel/entry_64.S                     |  28 +-
 arch/powerpc/kernel/exceptions-64e.S               |  13 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S      |  15 +-
 arch/powerpc/kernel/kvm.c                          |   1 -
 arch/powerpc/kernel/misc_64.S                      |  13 +-
 arch/powerpc/kernel/nvram_64.c                     |  10 +-
 arch/powerpc/kernel/pci-common.c                   |  72 +--
 arch/powerpc/kernel/process.c                      |  14 +-
 arch/powerpc/kernel/prom.c                         |  25 +-
 arch/powerpc/kernel/prom_init.c                    |  25 +-
 arch/powerpc/kernel/ptrace.c                       |  89 ++-
 arch/powerpc/kernel/rtas.c                         |  25 +-
 arch/powerpc/kernel/signal_32.c                    |   5 +
 arch/powerpc/kernel/signal_64.c                    |  21 +-
 arch/powerpc/kernel/trace_clock.c                  |  15 +
 arch/powerpc/lib/checksum_32.S                     |  16 -
 arch/powerpc/lib/checksum_64.S                     |  21 -
 arch/powerpc/lib/copy_32.S                         | 109 +++-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 +-
 arch/powerpc/mm/hash_low_64.S                      |   4 +-
 arch/powerpc/mm/hash_utils_64.c                    |  12 +-
 arch/powerpc/mm/hugetlbpage.c                      |   8 -
 arch/powerpc/mm/mem.c                              |  14 +-
 arch/powerpc/mm/numa.c                             |  16 +-
 arch/powerpc/mm/pgtable_64.c                       |  10 -
 arch/powerpc/mm/slb.c                              |  24 +-
 arch/powerpc/mm/tlb_low_64e.S                      |  10 +-
 arch/powerpc/oprofile/op_model_power4.c            |   4 +-
 arch/powerpc/perf/core-book3s.c                    |   4 +-
 arch/powerpc/perf/hv-24x7.c                        |  24 +-
 arch/powerpc/platforms/512x/Kconfig                |   4 +-
 arch/powerpc/platforms/85xx/c293pcie.c             |   4 -
 arch/powerpc/platforms/85xx/corenet_generic.c      |   2 +
 arch/powerpc/platforms/cell/Kconfig                |  15 -
 arch/powerpc/platforms/cell/spufs/file.c           |  55 --
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c    | 124 +----
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  12 +-
 arch/powerpc/platforms/powernv/opal-hmi.c          | 177 +++++-
 arch/powerpc/platforms/powernv/opal-power.c        | 147 ++++-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   4 +
 arch/powerpc/platforms/powernv/opal.c              |  47 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          | 147 ++---
 arch/powerpc/platforms/powernv/pci.c               |  11 -
 arch/powerpc/platforms/powernv/pci.h               |   7 +-
 arch/powerpc/platforms/powernv/powernv.h           |   6 -
 arch/powerpc/platforms/powernv/rng.c               |   2 +-
 arch/powerpc/platforms/powernv/setup.c             |  16 +-
 arch/powerpc/platforms/powernv/subcore.c           |   4 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |   3 +-
 arch/powerpc/platforms/pseries/iommu.c             |   3 +-
 arch/powerpc/platforms/pseries/ras.c               |   3 +-
 arch/powerpc/platforms/pseries/rng.c               |   2 +-
 arch/powerpc/platforms/pseries/setup.c             |  23 +-
 arch/powerpc/sysdev/cpm_common.c                   |   2 +-
 arch/powerpc/sysdev/dart_iommu.c                   |  16 +-
 arch/powerpc/sysdev/ppc4xx_hsta_msi.c              |   4 +-
 arch/powerpc/xmon/xmon.c                           |   8 +-
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-powernv.c                        | 345 ++++++++++++
 drivers/macintosh/therm_windtunnel.c               |   2 +
 drivers/macintosh/windfarm.h                       |   4 -
 drivers/macintosh/windfarm_core.c                  |  47 +-
 drivers/memory/fsl_ifc.c                           |  43 +-
 drivers/misc/cxl/Kconfig                           |   7 +-
 drivers/misc/cxl/Makefile                          |   2 +
 drivers/misc/cxl/api.c                             |  59 +-
 drivers/misc/cxl/context.c                         |  22 +-
 drivers/misc/cxl/cxl.h                             |  94 +++-
 drivers/misc/cxl/debugfs.c                         |   2 +-
 drivers/misc/cxl/file.c                            |  27 +-
 drivers/misc/cxl/irq.c                             |  56 +-
 drivers/misc/cxl/main.c                            |   1 +
 drivers/misc/cxl/native.c                          | 119 +++-
 drivers/misc/cxl/pci.c                             | 611 ++++++++++++++++-=
----
 drivers/misc/cxl/sysfs.c                           |  26 +
 drivers/misc/cxl/trace.h                           |  10 +-
 drivers/misc/cxl/vphb.c                            |  34 ++
 drivers/mtd/nand/fsl_ifc_nand.c                    | 258 ++++-----
 drivers/tty/hvc/hvsi.c                             |  46 +-
 include/linux/fsl_ifc.h                            |  50 ++
 include/misc/cxl.h                                 |  10 +
 include/uapi/misc/cxl.h                            |   4 +-
 tools/testing/selftests/powerpc/mm/Makefile        |   3 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c      |  15 +-
 146 files changed, 3560 insertions(+), 1998 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-powernv.txt
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
 create mode 100644 arch/powerpc/boot/dts/t1040d4rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t1042d4rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t104xd4rdb.dtsi
 create mode 100644 arch/powerpc/configs/85xx-32bit.config
 create mode 100644 arch/powerpc/configs/85xx-64bit.config
 create mode 100644 arch/powerpc/configs/85xx-hw.config
 create mode 100644 arch/powerpc/configs/85xx-smp.config
 create mode 100644 arch/powerpc/configs/altivec.config
 delete mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
 create mode 100644 arch/powerpc/configs/corenet_basic_defconfig
 rename arch/powerpc/configs/{corenet64_smp_defconfig =3D> fsl-emb-nonhw.co=
nfig} (50%)
 create mode 100644 arch/powerpc/configs/mpc85xx_basic_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_smp_defconfig
 create mode 100644 arch/powerpc/include/asm/trace_clock.h
 create mode 100644 arch/powerpc/kernel/trace_clock.c
 create mode 100644 drivers/leds/leds-powernv.c



--=-3bc6gVKk9HhXeYiWj2Qg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJV5+VnAAoJEFHr6jzI4aWA/ekQAKEMSkV3cDag2TxF0SCeO6Cl
i5ZLcE5lSz0IELGQjU+QJKFusZxmONj0loJwD/04Ln8jkvYDybVy3So15Pilfhd5
Ov+my+9EXWJWVj7/XiRSUCha0/QHJxMHALN9o9bEevk/qMdbjFbPkOqECsheF/0C
snRtv8d9WtlJFY+jesq4wRa2Auj52JXfET/UqcdbXsfxRkNBiAI2mbEuG2YsRO4L
1B45arFeiks3EBVXumOEP7pA1BUs8617q+dc2h+HnpE0Lk/ipiXb5YfQC/Uc77bx
/dKwRFscB3y1wwYSvv+1eZpi6BovHlkWl/swoKPW82HEcHIOLDR9ImzmgH72qEPt
obBzz+IE5gZjCS3M5AI5QaOsMZ2NI6LS5xwkUFq5xFYVmgVGqKk6o7i2keMAEaDD
UTB1VddgRfyvufNIQWRS/ko+FlHKlAHN9gqRUBN9xkEOmMoE17nASdLj4/VaZMqw
9Q9+SbFo01mcBElR/7eMWYBazqf6M7IAvPu55M8Fvu8So0FE4ClOvy+/03sDfQR3
3fKemItAj+04itmqx6v/vN6OEZIlQaiXbXyqTZWrCyP4HPO9M1XZ+/inVLgc6LeD
nwmOm4kmF8/puGrFoHN2qH/ODU9wEzgmrfCm/z2WXIkdjJ/VznqI9eKjPP4oJfll
DaAk/mCicegwxb4rU513
=aNZ9
-----END PGP SIGNATURE-----

--=-3bc6gVKk9HhXeYiWj2Qg--
