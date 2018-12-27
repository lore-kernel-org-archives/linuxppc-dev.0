Return-Path: <SRS0=TJyh=PE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6FC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 12:01:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C46452148D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 12:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46452148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43QT2Q22hvzDqGp
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 23:01:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43QSyr0zkxzDqFv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 22:58:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43QSyc3Rqzz9sCX;
 Thu, 27 Dec 2018 22:58:00 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.21-1 tag
Date: Thu, 27 Dec 2018 22:58:06 +1100
Message-ID: <87o997xju9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alexandre.belloni@bootlin.com, darren@stevens-zone.net,
 geert+renesas@glider.be, aik@ozlabs.ru, linuxram@us.ibm.com,
 viresh.kumar@linaro.org, ldv@altlinux.org, maddy@linux.vnet.ibm.com,
 oohall@gmail.com, leitao@debian.org, hch@lst.de, robh@kernel.org,
 sabyasachi.linux@gmail.com, aneesh.kumar@linux.ibm.com, yuehaibing@huawei.com,
 elfring@users.sourceforge.net, diana.craciun@nxp.com, tiny.windzz@gmail.com,
 firoz.khan@linaro.org, joel@jms.id.au, mahesh@linux.vnet.ibm.com,
 ravi.bangoria@linux.ibm.com, arnd@arndb.de, sfr@canb.auug.org.au,
 alistair@popple.id.au, groug@kaod.org, oss@buserror.net,
 alex.williamson@redhat.com, dja@axtens.net, andy.tang@nxp.com,
 malat@debian.org, linux-kernel@vger.kernel.org, sboyd@kernel.org,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.ibm.com,
 sathnaga@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull powerpc updates for 4.21:

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.21-1

for you to fetch changes up to 12526b0d6c580df860b31e59d68e5696e16c6e5b:

  Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/sc=
ottwood/linux into next (2018-12-24 14:14:45 +1100)


There are two conflicts I'm aware of.

The first is in arch/powerpc/mm/fault.c, the resolution is to add the 0xe00=
 case
to the switch and use the pr_alert() version of the printk.

The other is in arch/powerpc/kernel/iommu.c, where we deleted some code tha=
t was
modified in the iommu tree to use a new accessor.

cheers

- ------------------------------------------------------------------
powerpc updates for 4.21

Notable changes:

 - Mitigations for Spectre v2 on some Freescale (NXP) CPUs.

 - A large series adding support for pass-through of Nvidia V100 GPUs to gu=
ests
   on Power9.

 - Another large series to enable hardware assistance for TLB table walk on
   MPC8xx CPUs.

 - Some preparatory changes to our DMA code, to make way for further cleanu=
ps
   from Christoph.

 - Several fixes for our Transactional Memory handling discovered by fuzzin=
g the
   signal return path.

 - Support for generating our system call table(s) from a text file like ot=
her
   architectures.

 - A fix to our page fault handler so that instead of generating a WARN_ON_=
ONCE,
   user accesses of kernel addresses instead print a ratelimited and
   appropriately scary warning.

 - A cosmetic change to make our unhandled page fault messages more similar=
 to
   other arches and also more compact and informative.

 - Freescale updates from Scott:
   "Highlights include elimination of legacy clock bindings use from dts
    files, an 83xx watchdog handler, fixes to old dts interrupt errors, and
    some minor cleanup."

And many clean-ups, reworks and minor fixes etc.

Thanks to:
 Alexandre Belloni, Alexey Kardashevskiy, Andrew Donnellan, Aneesh Kumar K.=
V,
 Arnd Bergmann, Benjamin Herrenschmidt, Breno Leitao, Christian Lamparter,
 Christophe Leroy, Christoph Hellwig, Daniel Axtens, Darren Stevens, David
 Gibson, Diana Craciun, Dmitry V. Levin, Firoz Khan, Geert Uytterhoeven, Gr=
eg
 Kurz, Gustavo Romero, Hari Bathini, Joel Stanley, Kees Cook, Madhavan
 Srinivasan, Mahesh Salgaonkar, Markus Elfring, Mathieu Malaterre, Michal
 Such=C3=A1nek, Naveen N. Rao, Nick Desaulniers, Oliver O'Halloran, Paul Ma=
ckerras,
 Ram Pai, Ravi Bangoria, Rob Herring, Russell Currey, Sabyasachi Gupta, Sam
 Bobroff, Satheesh Rajendran, Scott Wood, Segher Boessenkool, Stephen Rothw=
ell,
 Tang Yuantian, Thiago Jung Bauermann, Yangtao Li, Yuantian Tang, Yue Haibi=
ng.

- ------------------------------------------------------------------
Alexandre Belloni (2):
      powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"
      powerpc/fsl-rio: fix spelling mistake "reserverd" -> "reserved"

Alexey Kardashevskiy (26):
      powerpc/powernv/ioda: Allocate indirect TCE levels of cached userspac=
e addresses on demand
      powerpc/powernv/npu: Remove unused headers and a macro.
      vfio/spapr_tce: Get rid of possible infinite loop
      powerpc/powernv/ioda1: Remove dead code for a single device PE
      powerpc/powernv/ioda: Reduce a number of hooks in pnv_phb
      powerpc/powernv/eeh/npu: Fix uninitialized variables in opal_pci_eeh_=
freeze_status
      powerpc/ioda/npu: Call skiboot's hot reset hook when disabling NPU2
      powerpc/mm/iommu/vfio_spapr_tce: Change mm_iommu_get to reference a r=
egion
      powerpc/vfio/iommu/kvm: Do not pin device memory
      powerpc/powernv: Move npu struct from pnv_phb to pci_controller
      powerpc/powernv/npu: Move OPAL calls away from context manipulation
      powerpc/pseries/iommu: Use memory@ nodes in max RAM address calculati=
on
      powerpc/pseries/npu: Enable platform support
      powerpc/pseries: Remove IOMMU API support for non-LPAR systems
      powerpc/powernv/pseries: Rework device adding to IOMMU groups
      powerpc/iommu_api: Move IOMMU groups setup to a single place
      powerpc/powernv: Reference iommu_table while it is linked to a group
      powerpc/powernv/npu: Move single TVE handling to NPU PE
      powerpc/powernv/npu: Convert NPU IOMMU helpers to iommu_table_group_o=
ps
      powerpc/powernv/npu: Add compound IOMMU groups
      powerpc/powernv/npu: Add release_ownership hook
      powerpc/powernv/npu: Check mmio_atsd array bounds when populating
      powerpc/powernv/npu: Fault user page into the hypervisor's pagetable
      vfio_pci: Allow mapping extra regions
      vfio_pci: Allow regions to add own capabilities
      vfio_pci: Add NVIDIA GV100GL [Tesla V100 SXM2] subdriver

Aneesh Kumar K.V (1):
      powerpc/mm/hash: Handle user access of kernel address gracefully

Arnd Bergmann (1):
      powerpc: eeh_event: convert semaphore to completion

Benjamin Herrenschmidt (2):
      powerpc/44x/bamboo: Fix PCI range
      powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=3Dy

Breno Leitao (20):
      powerpc/64s: Include cpu header
      powerpc/eeh: Declare pci_ers_result_name() as static
      powerpc/xive: Define xive_do_source_eoi as static
      powerpc/xmon: Define static functions
      powerpc/lib: Declare static methods
      powerpc/scom: Return NULL instead of 0
      powerpc/perf: Declare static identifier a such
      powerpc/pkey: Define functions as static
      powerpc/mm: Remove extern from function definition
      selftests/powerpc: Allocate base registers
      selftests/powerpc: Create a new SKIP_IF macro
      selftests/powerpc: Skip test instead of failing
      powerpc/xmon: Fix invocation inside lock region
      powerpc/pseries/cpuidle: Fix preempt warning
      powerpc/mm: remove unused function prototype
      powerpc/tm: Set MSR[TS] just prior to recheckpoint
      powerpc/tm: Save MSR to PACA before RFID
      powerpc/tm: Print scratch value
      powerpc/tm: Unset MSR[TS] if not recheckpointing
      selftests/powerpc: Add checks for transactional sigreturn

Christoph Hellwig (10):
      powerpc: allow NOT_COHERENT_CACHE for amigaone
      powerpc/dma: properly wire up the unmap_page and unmap_sg methods
      crypto4xx_core: don't abuse __dma_sync_page
      powerpc/dma: remove the unused ARCH_HAS_DMA_MMAP_COHERENT define
      powerpc/dma: remove the unused ISA_DMA_THRESHOLD export
      powerpc/dma: remove the unused dma_iommu_ops export
      powerpc/dma: split the two __dma_alloc_coherent implementations
      cxl: drop the dma_set_mask callback from vphb
      powerpc: use mm zones more sensibly
      powerpc/fsl_pci: simplify fsl_pci_dma_set_mask

Christophe Leroy (55):
      drivers/cpufreq: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
      powerpc: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
      powerpc/kconfig: remove CONFIG_6xx
      powerpc/32: Remove #ifdef CONFIG_PPC_STD_MMU_32 in asm/book3s/32/pgta=
ble.h
      powerpc: change CONFIG_PPC_STD_MMU_32 to CONFIG_PPC_BOOK3S_32
      powerpc: change CONFIG_PPC_STD_MMU to CONFIG_PPC_BOOK3S
      powerpc/kconfig: remove PPC_STD_MMU_32 and PPC_STD_MMU
      powerpc/book3s32: Remove CONFIG_BOOKE dependent code
      powerpc/8xx: Remove PTE_ATOMIC_UPDATES
      powerpc/mm: Move pte_fragment_alloc() to a common location
      powerpc/mm: Avoid useless lock with single page fragments
      powerpc/mm: move platform specific mmu-xxx.h in platform directories
      powerpc/mm: Move pgtable_t into platform headers
      powerpc/mm: add helpers to get/set mm.context->pte_frag
      powerpc/mm: Extend pte_fragment functionality to PPC32
      powerpc/mm: enable the use of page table cache of order 0
      powerpc/mm: replace hugetlb_cache by PGT_CACHE(PTE_T_ORDER)
      powerpc/mm: fix a warning when a cache is common to PGD and hugepages
      powerpc/mm: remove unnecessary test in pgtable_cache_init()
      powerpc/8xx: Move SW perf counters in first 32kb of memory
      powerpc/8xx: Temporarily disable 16k pages and hugepages
      powerpc/8xx: Use hardware assistance in TLB handlers
      powerpc/8xx: Enable 8M hugepage support with HW assistance
      powerpc/8xx: Enable 512k hugepage support with HW assistance
      powerpc/8xx: reintroduce 16K pages with HW assistance
      powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers
      powerpc/8xx: regroup TLB handler routines
      powerpc/mm: dump segment registers on book3s/32
      powerpc/mm: dump block address translation on book3s/32
      lib: fix build failure in CONFIG_DEBUG_VIRTUAL test
      powerpc: implement CONFIG_DEBUG_VIRTUAL
      powerpc/mm: remove unused variable
      powerpc: simplify patch_instruction_site() and patch_branch_site()
      powerpc: add modify_instruction() and modify_instruction_site()
      powerpc/32: use patch_site_addr() in machine_init()
      powerpc/book3s/32: Use MMU_FTR_HPTE_TABLE in head_32.S
      powerpc/book3s/32: Use patch_site to patch hash functions
      powerpc/8xx: use modify_instruction_site()
      powerpc/signal: Use code patching instead of hardcoding
      powerpc/44x: use patch_sites for TLB handlers patching
      powerpc/smp: Use code patching to restore reset vector
      powerpc/mm: Eliminate not possible mmu features at compile time
      powerpc/book3s/32: fix number of bats in p/v_block_mapped()
      powerpc/8xx: add exception frame marker
      powerpc/xmon: fix dump_segments()
      powerpc: remove remaining bits from CONFIG_APUS
      powerpc/uaccess: fix warning/error with access_ok()
      powerpc/mm: define an empty slice_init_new_context_exec()
      powerpc/mm: add exec protection on powerpc 603
      powerpc/prom: fix early DEBUG messages
      powerpc/mm: Make NULL pointer deferences explicit on bad page faults.
      powerpc/prom: move the device tree if not in declared memory.
      powerpc/8xx: Allow pinning IMMR TLB when using early debug console
      powerpc/mm: Fix reporting of kernel execute faults on the 8xx
      powerpc/83xx: handle machine check caused by watchdog timer

Daniel Axtens (1):
      powerpc: mark 64-bit PD_HUGE constant as unsigned long

Darren Stevens (4):
      powerpc/pasemi: Add PCI initialisation for Nemo board.
      powerpc/pasemi: Add Nemo board IRQ initroutine
      powerpc/pasemi: Add Nemo board device init code.
      powerpc/pasemi: Add Nemo board IRQ initroutine

Diana Craciun (11):
      powerpc/fsl: Add infrastructure to fixup branch predictor flush
      powerpc/fsl: Add macro to flush the branch predictor
      powerpc/fsl: Fix spectre_v2 mitigations reporting
      powerpc/fsl: Emulate SPRN_BUCSR register
      powerpc/fsl: Add nospectre_v2 command line argument
      powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)
      powerpc/fsl: Flush the branch predictor at each kernel entry (32 bit)
      powerpc/fsl: Flush branch predictor when entering KVM
      powerpc/fsl: Enable runtime patching if nospectre_v2 boot arg is used
      powerpc/fsl: Update Spectre v2 reporting
      powerpc/fsl: Add FSL_PPC_BOOK3E as supported arch for nospectre_v2 bo=
ot arg

Dmitry V. Levin (1):
      powerpc/ptrace: Combine SYSCALL_EMU & SYSCALL_TRACE handling

Firoz Khan (5):
      powerpc: add __NR_syscalls along with NR_syscalls
      powerpc: move macro definition from asm/systbl.h
      powerpc: split compat syscall table out from native table
      powerpc: add system call table generation support
      powerpc: generate uapi header and system call table files

Geert Uytterhoeven (1):
      powerpc: Typo s/use use/use/

Greg Kurz (4):
      ocxl: Fix endiannes bug in ocxl_link_update_pe()
      ocxl: Clarify error path in setup_xsl_irq()
      ocxl/afu_irq: Don't include <asm/pnv-ocxl.h>
      ocxl: Fix endiannes bug in read_afu_name()

Joel Stanley (3):
      powerpc/math-emu: Update macros from GCC
      raid6/ppc: Fix build for clang
      powerpc/32: Avoid unsupported flags with clang

Madhavan Srinivasan (6):
      powerpc/perf: Fix thresholding counter data for unknown type
      powerpc/perf: Update perf_regs structure to include SIER
      powerpc/perf: Cleanup cache_sel bits comment
      powerpc/perf: Fix unit_sel/cache_sel checks
      powerpc/perf: Add constraints for power9 l2/l3 bus events
      powerpc/perf: Remove l2 bus events from HW cache event array

Mahesh Salgaonkar (4):
      powerpc/powernv: Move opal_power_control_init() call in opal_init().
      powerpc/fadump: Reservationless firmware assisted dump
      powerpc/fadump: Throw proper error message on fadump registration fai=
lure
      powerpc/fadump: Do not allow hot-remove memory from fadump reserved a=
rea.

Markus Elfring (4):
      powerpc/4xx: Combine four seq_printf() calls into two in ocm_debugfs_=
show()
      powerpc/4xx: Use seq_putc() in ocm_debugfs_show()
      powerpc/4xx: Delete error message for a ENOMEM in two functions
      powerpc/4xx: Delete an unnecessary return statement in two functions

Mathieu Malaterre (3):
      powerpc/32: Add .data..Lubsan_data*/.data..Lubsan_type* sections expl=
icitly
      powerpc/mm: remove const type qualifier from function =E2=80=98pud_pf=
n=E2=80=99
      powerpc/32: Move the old 6xx -mcpu logic before the TARGET_CPU logic

Michael Ellerman (10):
      Merge branch 'fixes' into next
      powerpc/configs: Remove unnecessary ftrace symbols
      powerpc/configs: Update ppc64_defconfig with savedefconfig
      Merge branch 'fixes' into next
      powerpc/ipic: Remove unused ipic_set_priority()
      powerpc/configs: Don't enable PPC_EARLY_DEBUG in defconfigs
      powerpc: Add some documentation of ISA versions
      powerpc/pseries: Fix node leak in update_lmb_associativity_index()
      powerpc/mm: Remove very old comment in hash-4k.h
      Merge branch 'next' of https://git.kernel.org/.../scottwood/linux int=
o next

Oliver O'Halloran (2):
      powerpc/powernv: Remove PCI_MSI ifdef checks
      powerpc/zImage: Also check for stdout-path

Ram Pai (1):
      powerpc/pkeys: Fix handling of pkey state across fork()

Ravi Bangoria (1):
      Powerpc/perf: Wire up PMI throttling

Rob Herring (9):
      powerpc: Rework btext_find_display to use of_stdout and device_type h=
elpers
      powerpc: Use device_type helpers to access the node type
      macintosh: windfarm: Another convert to using %pOFn instead of device=
_node.name
      macintosh: Use device_type helpers to access the node type
      cxl: Use device_type helpers to access the node type
      powerpc/pseries/pmem: Convert to %pOFn instead of device_node.name
      powerpc: Use of_node_name_eq for node name comparisons
      ide: Use of_node_name_eq for node name comparisons
      macintosh: Use of_node_name_{eq, prefix} for node name comparisons

Russell Currey (1):
      powerpc/tools/checkpatch: Ignore DT_SPLIT_BINDING_PATCH

Sabyasachi Gupta (2):
      powerpc/pasemi: Use dma_zalloc_coherent()
      arch/powerpc/fsl_rmu: Use dma_zalloc_coherent

Satheesh Rajendran (3):
      powerpc/configs: Add CONFIG_NR_CPUS to ppc64_defconfig
      powerpc/configs: Add missing config symbols for ppc64_defconfig
      powerpc/configs: Add KVM guest defconfig

Scott Wood (4):
      powerpc/fsl: Use new clockgen binding
      powerpc/dts/fsl: Fix dtc-flagged interrupt errors
      powerpc/configs/85xx: Enable CONFIG_DEBUG_KERNEL
      Revert "powerpc/fsl_pci: simplify fsl_pci_dma_set_mask"

Stephen Rothwell (1):
      powerpc: annotate implicit fall throughs

Yangtao Li (2):
      powerpc/powernv/vas: Use DEFINE_SHOW_ATTRIBUTE macro
      powerpc/fadump: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yuantian Tang (1):
      clk: qoriq: add more compatibles strings

Yue Haibing (1):
      powerpc/85xx: Drop pointless static qualifier

YueHaibing (2):
      powerpc64/ftrace: Drop pointless static qualifier in is_b_op()
      powerpc/eeh: Fix debugfs_simple_attr.cocci warnings


 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 .../devicetree/bindings/clock/qoriq-clock.txt      |   6 +
 Documentation/powerpc/firmware-assisted-dump.txt   |  17 +-
 Documentation/powerpc/isa-versions.rst             |  74 +++
 arch/powerpc/Kconfig                               |  15 +-
 arch/powerpc/Makefile                              |  28 +-
 arch/powerpc/boot/dts/bamboo.dts                   |   4 +-
 arch/powerpc/boot/dts/fsl/b4420si-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/b4860si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |  15 -
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts         | 128 ++---
 arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts     | 128 ++---
 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi      |   2 +
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi        |  18 -
 arch/powerpc/boot/dts/fsl/p2041si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi        |  18 -
 arch/powerpc/boot/dts/fsl/p3041si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi        |  70 ---
 arch/powerpc/boot/dts/fsl/p4080si-pre.dtsi         |  16 +-
 arch/powerpc/boot/dts/fsl/p5020si-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi        |  18 -
 arch/powerpc/boot/dts/fsl/p5040si-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi     |  47 --
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi     |  30 --
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |  16 -
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |   4 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |  44 --
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi        |  22 -
 arch/powerpc/boot/dts/fsl/t208xsi-pre.dtsi         |   8 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi        |  61 ---
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi         |  24 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |   4 -
 arch/powerpc/boot/serial.c                         |   3 +-
 arch/powerpc/configs/fsl-emb-nonhw.config          |   1 +
 arch/powerpc/configs/g5_defconfig                  |   1 -
 arch/powerpc/configs/guest.config                  |  13 +
 arch/powerpc/configs/maple_defconfig               |   1 -
 arch/powerpc/configs/pmac32_defconfig              |   1 -
 arch/powerpc/configs/ppc64_defconfig               |  81 +--
 arch/powerpc/configs/ppc6xx_defconfig              |   1 -
 arch/powerpc/configs/pseries_defconfig             |   2 -
 arch/powerpc/include/asm/Kbuild                    |   4 +
 arch/powerpc/include/asm/asm-prototypes.h          |   1 -
 arch/powerpc/include/asm/book3s/32/hash.h          |   1 +
 arch/powerpc/include/asm/book3s/32/mmu-hash.h      |  15 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  40 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  46 +-
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   6 +-
 arch/powerpc/include/asm/book3s/64/mmu.h           |   9 +
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   6 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   2 +-
 arch/powerpc/include/asm/cache.h                   |   2 +-
 arch/powerpc/include/asm/code-patching.h           |  23 +-
 arch/powerpc/include/asm/cputable.h                |   9 +-
 arch/powerpc/include/asm/dma-mapping.h             |   7 -
 arch/powerpc/include/asm/fadump.h                  |   7 +-
 arch/powerpc/include/asm/feature-fixups.h          |  12 +
 arch/powerpc/include/asm/hugetlb.h                 |  15 +-
 arch/powerpc/include/asm/io.h                      |  13 +-
 arch/powerpc/include/asm/iommu.h                   |  17 +-
 arch/powerpc/include/asm/ipic.h                    |   1 -
 arch/powerpc/include/asm/mmu.h                     |  49 +-
 arch/powerpc/include/asm/mmu_context.h             |  32 +-
 arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-40x.h |   0
 arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-44x.h |   3 +
 arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-8xx.h |   4 +
 arch/powerpc/include/asm/nohash/32/mmu.h           |  25 +
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |  27 +-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  15 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |   2 +-
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   3 -
 arch/powerpc/include/asm/nohash/64/mmu.h           |  12 +
 arch/powerpc/include/asm/nohash/64/pgalloc.h       |   5 +-
 arch/powerpc/include/asm/{ =3D> nohash}/mmu-book3e.h |   0
 arch/powerpc/include/asm/nohash/mmu.h              |  11 +
 arch/powerpc/include/asm/nohash/pgtable.h          |   4 +
 arch/powerpc/include/asm/opal.h                    |   1 +
 arch/powerpc/include/asm/page.h                    |  18 +-
 arch/powerpc/include/asm/page_32.h                 |   3 +-
 arch/powerpc/include/asm/pci-bridge.h              |   1 +
 arch/powerpc/include/asm/pci.h                     |   4 +
 arch/powerpc/include/asm/perf_event.h              |   3 +
 arch/powerpc/include/asm/perf_event_server.h       |   2 +
 arch/powerpc/include/asm/pgtable-types.h           |   4 +
 arch/powerpc/include/asm/pgtable.h                 |  32 +-
 arch/powerpc/include/asm/ppc-opcode.h              |   1 +
 arch/powerpc/include/asm/ppc_asm.h                 |  29 +-
 arch/powerpc/include/asm/reg.h                     |   4 +-
 arch/powerpc/include/asm/setup.h                   |   7 +
 arch/powerpc/include/asm/sfp-machine.h             |  92 ++--
 arch/powerpc/include/asm/slice.h                   |  14 +-
 arch/powerpc/include/asm/syscall.h                 |   3 +-
 arch/powerpc/include/asm/systbl.h                  | 396 ---------------
 arch/powerpc/include/asm/time.h                    |   2 +-
 arch/powerpc/include/asm/tlb.h                     |   2 +-
 arch/powerpc/include/asm/uaccess.h                 |   2 +-
 arch/powerpc/include/asm/unistd.h                  |   3 +-
 arch/powerpc/include/uapi/asm/Kbuild               |   2 +
 arch/powerpc/include/uapi/asm/perf_regs.h          |   1 +
 arch/powerpc/include/uapi/asm/unistd.h             | 389 +-------------
 arch/powerpc/kernel/Makefile                       |  12 +-
 arch/powerpc/kernel/btext.c                        |  16 +-
 arch/powerpc/kernel/cacheinfo.c                    |   2 +-
 arch/powerpc/kernel/cpu_setup_6xx.S                |   2 +-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S          |   2 +-
 arch/powerpc/kernel/cputable.c                     |  10 +-
 arch/powerpc/kernel/dma-iommu.c                    |   2 -
 arch/powerpc/kernel/dma-swiotlb.c                  |   6 +-
 arch/powerpc/kernel/dma.c                          |  31 +-
 arch/powerpc/kernel/eeh.c                          |  20 +-
 arch/powerpc/kernel/eeh_driver.c                   |   2 +-
 arch/powerpc/kernel/eeh_event.c                    |   9 +-
 arch/powerpc/kernel/entry_32.S                     |  10 +-
 arch/powerpc/kernel/entry_64.S                     |  16 +-
 arch/powerpc/kernel/exceptions-64e.S               |  26 +-
 arch/powerpc/kernel/exceptions-64s.S               |   2 +-
 arch/powerpc/kernel/fadump.c                       | 154 +++++-
 arch/powerpc/kernel/head_32.S                      |  20 +-
 arch/powerpc/kernel/head_44x.S                     |  11 +-
 arch/powerpc/kernel/head_8xx.S                     | 369 +++++---------
 arch/powerpc/kernel/head_booke.h                   |   6 +
 arch/powerpc/kernel/head_fsl_booke.S               |  15 +
 arch/powerpc/kernel/iommu.c                        |  69 +--
 arch/powerpc/kernel/isa-bridge.c                   |   3 +-
 arch/powerpc/kernel/legacy_serial.c                |  10 +-
 arch/powerpc/kernel/misc_32.S                      |   4 +-
 arch/powerpc/kernel/nvram_64.c                     |   1 +
 arch/powerpc/kernel/pci_of_scan.c                  |  11 +-
 arch/powerpc/kernel/pmc.c                          |   2 +-
 arch/powerpc/kernel/prom.c                         |  10 +-
 arch/powerpc/kernel/ptrace.c                       |  54 +-
 arch/powerpc/kernel/security.c                     |  29 +-
 arch/powerpc/kernel/setup-common.c                 |   7 +-
 arch/powerpc/kernel/setup_32.c                     |   6 +-
 arch/powerpc/kernel/signal_32.c                    |  50 +-
 arch/powerpc/kernel/signal_64.c                    |  71 ++-
 arch/powerpc/kernel/syscalls/Makefile              |  63 +++
 arch/powerpc/kernel/syscalls/syscall.tbl           | 427 ++++++++++++++++
 arch/powerpc/kernel/syscalls/syscallhdr.sh         |  37 ++
 arch/powerpc/kernel/syscalls/syscalltbl.sh         |  36 ++
 arch/powerpc/kernel/sysfs.c                        |   2 +-
 arch/powerpc/kernel/systbl.S                       |  40 +-
 arch/powerpc/kernel/systbl_chk.c                   |  60 ---
 arch/powerpc/kernel/trace/ftrace.c                 |   2 +-
 arch/powerpc/kernel/traps.c                        |   3 +-
 arch/powerpc/kernel/vdso.c                         |   7 +-
 arch/powerpc/kernel/vmlinux.lds.S                  |  18 +-
 arch/powerpc/kvm/book3s_64_vio.c                   |  18 +-
 arch/powerpc/kvm/bookehv_interrupts.S              |   4 +
 arch/powerpc/kvm/e500.h                            |   2 +-
 arch/powerpc/kvm/e500_emulate.c                    |   7 +
 arch/powerpc/lib/code-patching.c                   |  16 -
 arch/powerpc/lib/feature-fixups.c                  |  27 +-
 arch/powerpc/mm/44x_mmu.c                          |  14 +-
 arch/powerpc/mm/8xx_mmu.c                          |  10 +-
 arch/powerpc/mm/Makefile                           |  11 +-
 arch/powerpc/mm/dma-noncoherent.c                  |  15 +-
 arch/powerpc/mm/dump_bats.c                        | 173 +++++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c     |   2 -
 arch/powerpc/mm/dump_sr.c                          |  64 +++
 arch/powerpc/mm/fault.c                            |  49 +-
 arch/powerpc/mm/hash_low_32.S                      |  33 +-
 arch/powerpc/mm/hugetlbpage.c                      |  40 +-
 arch/powerpc/mm/init-common.c                      |  56 +-
 arch/powerpc/mm/mem.c                              |  51 +-
 arch/powerpc/mm/mmu_context.c                      |  10 +
 arch/powerpc/mm/mmu_context_book3s64.c             |  15 -
 arch/powerpc/mm/mmu_context_iommu.c                | 110 +++-
 arch/powerpc/mm/mmu_context_nohash.c               |   4 +-
 arch/powerpc/mm/mmu_decl.h                         |   2 +-
 arch/powerpc/mm/numa.c                             |   2 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |  88 +---
 arch/powerpc/mm/pgtable-frag.c                     | 119 +++++
 arch/powerpc/mm/pgtable.c                          |  26 +-
 arch/powerpc/mm/pgtable_32.c                       |  29 +-
 arch/powerpc/mm/pkeys.c                            |  25 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |  51 +-
 arch/powerpc/mm/tlb_low_64e.S                      |   7 +
 arch/powerpc/oprofile/Makefile                     |   2 +-
 arch/powerpc/oprofile/common.c                     |   2 +-
 arch/powerpc/perf/core-book3s.c                    |  39 +-
 arch/powerpc/perf/imc-pmu.c                        |   6 +-
 arch/powerpc/perf/isa207-common.c                  |  58 ++-
 arch/powerpc/perf/isa207-common.h                  |   9 +-
 arch/powerpc/perf/perf_regs.c                      |   7 +
 arch/powerpc/perf/power9-pmu.c                     |  22 +-
 arch/powerpc/platforms/44x/warp.c                  |   6 +-
 arch/powerpc/platforms/4xx/ocm.c                   |  17 +-
 arch/powerpc/platforms/4xx/pci.c                   |   7 +-
 arch/powerpc/platforms/512x/Kconfig                |   2 +-
 arch/powerpc/platforms/52xx/Kconfig                |   2 +-
 arch/powerpc/platforms/52xx/efika.c                |   6 +-
 arch/powerpc/platforms/82xx/Kconfig                |   4 +-
 arch/powerpc/platforms/83xx/Kconfig                |   2 +-
 arch/powerpc/platforms/83xx/misc.c                 |  17 +
 arch/powerpc/platforms/85xx/corenet_generic.c      |  10 -
 arch/powerpc/platforms/85xx/qemu_e500.c            |   9 -
 arch/powerpc/platforms/85xx/t1042rdb_diu.c         |   2 +-
 arch/powerpc/platforms/86xx/Kconfig                |   2 +-
 arch/powerpc/platforms/86xx/mpc86xx_smp.c          |   3 +-
 arch/powerpc/platforms/Kconfig                     |   8 +-
 arch/powerpc/platforms/Kconfig.cputype             |  21 +-
 arch/powerpc/platforms/amigaone/Kconfig            |   2 +-
 arch/powerpc/platforms/cell/cbe_regs.c             |   6 +-
 arch/powerpc/platforms/cell/setup.c                |   5 +-
 arch/powerpc/platforms/cell/spu_callbacks.c        |  17 +-
 arch/powerpc/platforms/cell/spu_manage.c           |  10 +-
 arch/powerpc/platforms/chrp/Kconfig                |   2 +-
 arch/powerpc/platforms/chrp/pci.c                  |   4 +-
 arch/powerpc/platforms/chrp/setup.c                |  10 +-
 arch/powerpc/platforms/embedded6xx/Kconfig         |   2 +-
 arch/powerpc/platforms/maple/pci.c                 |   6 +-
 arch/powerpc/platforms/pasemi/dma_lib.c            |   4 +-
 arch/powerpc/platforms/pasemi/pci.c                |  66 +++
 arch/powerpc/platforms/pasemi/setup.c              |  86 ++++
 arch/powerpc/platforms/powermac/cache.S            |   4 +-
 arch/powerpc/platforms/powermac/feature.c          |  14 +-
 arch/powerpc/platforms/powermac/low_i2c.c          |  11 +-
 arch/powerpc/platforms/powermac/pci.c              |  27 +-
 arch/powerpc/platforms/powermac/pfunc_base.c       |   7 +-
 arch/powerpc/platforms/powermac/pic.c              |   6 +-
 arch/powerpc/platforms/powermac/setup.c            |  10 +-
 arch/powerpc/platforms/powermac/sleep.S            |   4 +-
 arch/powerpc/platforms/powermac/smp.c              |   3 +-
 arch/powerpc/platforms/powermac/udbg_adb.c         |   2 +-
 arch/powerpc/platforms/powermac/udbg_scc.c         |   2 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |   8 +-
 arch/powerpc/platforms/powernv/npu-dma.c           | 564 +++++++++++++++++=
----
 arch/powerpc/platforms/powernv/opal-power.c        |   3 +-
 arch/powerpc/platforms/powernv/opal.c              |   5 +-
 arch/powerpc/platforms/powernv/pci-ioda-tce.c      |   5 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          | 265 ++++------
 arch/powerpc/platforms/powernv/pci.c               |  49 +-
 arch/powerpc/platforms/powernv/pci.h               |  36 +-
 arch/powerpc/platforms/powernv/vas-debug.c         |  28 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    |  16 +-
 arch/powerpc/platforms/pseries/iommu.c             |  88 ++--
 arch/powerpc/platforms/pseries/pci.c               |  22 +
 arch/powerpc/platforms/pseries/pmem.c              |   8 +-
 arch/powerpc/platforms/pseries/setup.c             |  12 +-
 arch/powerpc/platforms/pseries/vio.c               |  27 +-
 arch/powerpc/sysdev/Makefile                       |   2 +-
 arch/powerpc/sysdev/fsl_rio.h                      |   2 +-
 arch/powerpc/sysdev/fsl_rmu.c                      |   4 +-
 arch/powerpc/sysdev/ipic.c                         |  28 -
 arch/powerpc/sysdev/scom.c                         |   4 +-
 arch/powerpc/sysdev/xive/common.c                  |   2 +-
 arch/powerpc/tools/checkpatch.sh                   |   1 +
 arch/powerpc/xmon/xmon.c                           |  33 +-
 drivers/cpufreq/pmac32-cpufreq.c                   |   4 +-
 drivers/cpuidle/cpuidle-pseries.c                  |   8 +-
 drivers/crypto/amcc/crypto4xx_core.c               |   2 +-
 drivers/ide/pmac.c                                 |   2 +-
 drivers/macintosh/ans-lcd.c                        |   2 +-
 drivers/macintosh/macio_asic.c                     |  35 +-
 drivers/macintosh/macio_sysfs.c                    |  18 +-
 drivers/macintosh/rack-meter.c                     |  13 +-
 drivers/macintosh/via-pmu.c                        |   4 +-
 drivers/macintosh/windfarm_fcu_controls.c          |  14 +-
 drivers/macintosh/windfarm_lm87_sensor.c           |   4 +-
 drivers/macintosh/windfarm_smu_controls.c          |   4 +-
 drivers/macintosh/windfarm_smu_sat.c               |   9 +-
 drivers/macintosh/windfarm_smu_sensors.c           |  15 +-
 drivers/misc/cxl/pci.c                             |   4 +-
 drivers/misc/cxl/vphb.c                            |  12 -
 drivers/misc/ocxl/afu_irq.c                        |   1 -
 drivers/misc/ocxl/config.c                         |   2 +-
 drivers/misc/ocxl/link.c                           |  25 +-
 drivers/vfio/pci/Kconfig                           |   6 +
 drivers/vfio/pci/Makefile                          |   1 +
 drivers/vfio/pci/trace.h                           | 102 ++++
 drivers/vfio/pci/vfio_pci.c                        |  42 +-
 drivers/vfio/pci/vfio_pci_nvlink2.c                | 482 ++++++++++++++++++
 drivers/vfio/pci/vfio_pci_private.h                |  20 +
 drivers/vfio/vfio_iommu_spapr_tce.c                |  74 +--
 include/linux/mmzone.h                             |   2 +-
 include/uapi/linux/vfio.h                          |  42 ++
 lib/raid6/Makefile                                 |  15 +
 lib/test_debug_virtual.c                           |   1 +
 tools/arch/powerpc/include/uapi/asm/perf_regs.h    |   1 +
 tools/perf/arch/powerpc/include/perf_regs.h        |   3 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |   1 +
 tools/testing/selftests/powerpc/include/utils.h    |  10 +
 tools/testing/selftests/powerpc/ptrace/core-pkey.c |   5 +-
 .../testing/selftests/powerpc/ptrace/ptrace-gpr.c  |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-gpr.c       |   4 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spd-tar.c   |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spd-vsx.c   |   3 +-
 .../selftests/powerpc/ptrace/ptrace-tm-spr.c       |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-tar.c       |   2 +-
 .../selftests/powerpc/ptrace/ptrace-tm-vsx.c       |   3 +-
 tools/testing/selftests/powerpc/tm/.gitignore      |   1 +
 tools/testing/selftests/powerpc/tm/Makefile        |   2 +-
 .../selftests/powerpc/tm/tm-signal-sigreturn-nt.c  |  46 ++
 296 files changed, 4689 insertions(+), 3411 deletions(-)
 create mode 100644 Documentation/powerpc/isa-versions.rst
 create mode 100644 arch/powerpc/configs/guest.config
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-40x.h (100%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-44x.h (98%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/mmu-8xx.h (98%)
 create mode 100644 arch/powerpc/include/asm/nohash/32/mmu.h
 create mode 100644 arch/powerpc/include/asm/nohash/64/mmu.h
 rename arch/powerpc/include/asm/{ =3D> nohash}/mmu-book3e.h (100%)
 create mode 100644 arch/powerpc/include/asm/nohash/mmu.h
 delete mode 100644 arch/powerpc/include/asm/systbl.h
 create mode 100644 arch/powerpc/kernel/syscalls/Makefile
 create mode 100644 arch/powerpc/kernel/syscalls/syscall.tbl
 create mode 100644 arch/powerpc/kernel/syscalls/syscallhdr.sh
 create mode 100644 arch/powerpc/kernel/syscalls/syscalltbl.sh
 delete mode 100644 arch/powerpc/kernel/systbl_chk.c
 create mode 100644 arch/powerpc/mm/dump_bats.c
 create mode 100644 arch/powerpc/mm/dump_sr.c
 create mode 100644 arch/powerpc/mm/pgtable-frag.c
 create mode 100644 drivers/vfio/pci/trace.h
 create mode 100644 drivers/vfio/pci/vfio_pci_nvlink2.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-sigreturn-=
nt.c
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcJL3eAAoJEFHr6jzI4aWAom8P/RNu5cmjgbl2WIgke+xZDb8M
FR868yMM7VFryQJ9bQ6hXMMF5RDD6mn4c/NBk61l5SgcsCfIa6gM5uiwp8T64/DC
t6qZ9XNL99dTU3R5PEI8MBDOcGci0E9hDDKZAD7Ez9kuyeOWf7OP5Rk5xOiCp7Gv
HADB81eXk+9GXFVKwEsludg7WaYCB2fthNWLDf4WTocHUadonR+NsvSntZUBU2Vl
f59VVzBekROBo23WuAi+wnPEu8dbzMeQPsrsQWUBSru7KS2tZXKsU5+N5cql5gMn
QCNwf/L52zgoFiroOyYHuXLAgd7xxDP4nrZhJTZmWH81P3ej+g3HN0GdJbci0+Rh
6RdNi3U/KlH+DZGGIAmulwpUBCxyyNi/aY46zaoGPMSw+EJwpT15A9IG+dHn9Oba
owUf66LXELmdkT0KpqhEjk/PI05ySINcQRmX0+Ar2eiUL8JeXc3bqDngr0Q/bbSv
ZkUnuglxrIuw/UInM2X7fR3uR6Hok8mEhzDuYhxRnMTv+BTYMeYIpSljFq5juoxF
v2wsrAkqS/T16vo75WHqWjAXUpUAWr9ODXisivdNC/Yrt1qfEv+8Cg+QjsC4V6e9
8dYB89FxENEy0h9WGuJ9jdar8N1rgcKFSCcgddsNz7XqI8LlKY0wCv1r2KifB6or
Ietwk+gAlOzJCxyDyjU/
=3D8AUI
-----END PGP SIGNATURE-----
