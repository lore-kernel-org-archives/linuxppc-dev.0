Return-Path: <SRS0=7Aff=NG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909BBECDE46
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 18:43:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E27BE20848
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Oct 2018 18:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E27BE20848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42hXvZ5knYzF3Hb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 27 Oct 2018 05:43:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42hXsN1x11zF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Oct 2018 05:42:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42hXsB3vkWz9sCW;
 Sat, 27 Oct 2018 05:41:50 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.20-1 tag
Date: Sat, 27 Oct 2018 05:41:49 +1100
Message-ID: <87ftwssg7m.fsf@concordia.ellerman.id.au>
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
Cc: ego@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com, daniel.vetter@ffwll.ch,
 fbarrat@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com,
 yamada.masahiro@socionext.com, mwb@linux.vnet.ibm.com, oohall@gmail.com,
 leitao@debian.org, aravinda@linux.vnet.ibm.com, rashmica.g@gmail.com,
 breno.leitao@gmail.com, robh@kernel.org, mikey@neuling.org,
 aneesh.kumar@linux.ibm.com, b.zolnierkie@samsung.com, yuehaibing@huawei.com,
 fthain@telegraphics.com.au, geert@linux-m68k.org, joel@jms.id.au,
 sjitindarsingh@gmail.com, nfont@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, dan.carpenter@oracle.com, arnd@arndb.de,
 amodra@gmail.com, mhairgrove@nvidia.com, npiggin@gmail.com, pvorel@suse.cz,
 anton@samba.org, dan.j.williams@intel.com, zhongjiang@huawei.com,
 hbathini@linux.ibm.com, dja@axtens.net, msuchanek@suse.de, geoff@infradead.org,
 linux-kernel@vger.kernel.org, sbobroff@linux.ibm.com,
 andrew.donnellan@au1.ibm.com, vaibhav@linux.ibm.com,
 ldufour@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull powerpc updates for 4.20:

The following changes since commit 11da3a7f84f19c26da6f86af878298694ede0804:

  Linux 4.19-rc3 (2018-09-09 17:26:43 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-4.20-1

for you to fetch changes up to 58cfbac25b1fd2b76f94566aed28a3662b0ff8c6:

  Revert "selftests/powerpc: Fix out-of-tree build errors" (2018-10-26 21:5=
8:58 +1100)

- ------------------------------------------------------------------
powerpc updates for 4.20

Notable changes:

 - A large series to rewrite our SLB miss handling, replacing a lot of fair=
ly
   complicated asm with much fewer lines of C.

 - Following on from that, we now maintain a cache of SLB entries for each
   process and preload them on context switch. Leading to a 27% speedup for=
 our
   context switch benchmark on Power9.

 - Improvements to our handling of SLB multi-hit errors. We now print more =
debug
   information when they occur, and try to continue running by flushing the=
 SLB
   and reloading, rather than treating them as fatal.

 - Enable THP migration on 64-bit Book3S machines (eg. Power7/8/9).

 - Add support for physical memory up to 2PB in the linear mapping on 64-bit
   Book3S. We only support up to 512TB as regular system memory, otherwise =
the
   percpu allocator runs out of vmalloc space.

 - Add stack protector support for 32 and 64-bit, with a per-task canary.

 - Add support for PTRACE_SYSEMU and PTRACE_SYSEMU_SINGLESTEP.

 - Support recognising "big cores" on Power9, where two SMT4 cores are pres=
ented
   to us as a single SMT8 core.

 - A large series to cleanup some of our ioremap handling and PTE flags.

 - Add a driver for the PAPR SCM (storage class memory) interface, allowing
   guests to operate on SCM devices (acked by Dan).

 - Changes to our ftrace code to handle very large kernels, where we need t=
o use
   a trampoline to get to ftrace_caller().

Many other smaller enhancements and cleanups.

Thanks to:
  Alan Modra, Alistair Popple, Aneesh Kumar K.V, Anton Blanchard, Aravinda
  Prasad, Bartlomiej Zolnierkiewicz, Benjamin Herrenschmidt, Breno Leitao,
  C=C3=A9dric Le Goater, Christophe Leroy, Christophe Lombard, Dan Carpente=
r, Daniel
  Axtens, Finn Thain, Gautham R. Shenoy, Gustavo Romero, Haren Myneni, Hari
  Bathini, Jia Hongtao, Joel Stanley, John Allen, Laurent Dufour, Madhavan
  Srinivasan, Mahesh Salgaonkar, Mark Hairgrove, Masahiro Yamada, Michael
  Bringmann, Michael Neuling, Michal Suchanek, Murilo Opsfelder Araujo, Nat=
han
  Fontenot, Naveen N. Rao, Nicholas Piggin, Nick Desaulniers, Oliver O'Hall=
oran,
  Paul Mackerras, Petr Vorel, Rashmica Gupta, Reza Arbab, Rob Herring, Sam
  Bobroff, Samuel Mendoza-Jonas, Scott Wood, Stan Johnson, Stephen Rothwell,
  Stewart Smith, Suraj Jitindar Singh, Tyrel Datwyler, Vaibhav Jain, Vasant
  Hegde, YueHaibing, zhong jiang,

- ------------------------------------------------------------------
Alan Modra (1):
      powerpc/vdso: Correct call frame information

Aneesh Kumar K.V (10):
      powerpc/mm/book3s: Update pmd_present to look at _PAGE_PRESENT bit
      powerpc/mm/hugetlb/book3s: add _PAGE_PRESENT to hugepd pointer.
      powerpc/mm/book3s: Check for pmd_large instead of pmd_trans_huge
      arch/powerpc/mm/hash: validate the pte entries before handling the ha=
sh fault
      powerpc/mm/thp: update pmd_trans_huge to check for pmd_present
      powerpc/mm:book3s: Enable THP migration support
      powerpc/mm/hash: Rename get_ea_context to get_user_context
      powerpc/mm: Increase the max addressable memory to 2PB
      powerpc/mm: Make pte_pgprot return all pte bits
      powerpc/mm: Fix WARN_ON with THP NUMA migration

Anton Blanchard (4):
      powerpc/64: Remove static branch hints from memset()
      powerpc: Fix duplicate const clang warning in user access code
      powerpc/time: Use clockevents_register_device(), fixing an issue with=
 large decrementer
      powerpc/time: Add set_state_oneshot_stopped decrementer callback

Aravinda Prasad (1):
      powerpc/pseries: Export raw per-CPU VPA data via debugfs

Bartlomiej Zolnierkiewicz (1):
      powerpc: remove redundant 'default n' from Kconfig-s

Benjamin Herrenschmidt (13):
      powerpc/prom_init: Make of_workarounds static
      powerpc/prom_init: Make "fake_elf" const
      powerpc/prom_init: Make "default_colors" const
      powerpc/prom_init: Replace __initdata with __prombss when applicable
      powerpc/prom_init: Remove support for OPAL v2
      powerpc/prom_init: Move prom_radix_disable to __prombss
      powerpc/prom_init: Move ibm_arch_vec to __prombss
      powerpc/prom_init: Move const structures to __initconst
      powerpc/prom_init: Move a few remaining statics to appropriate sectio=
ns
      powerpc/prom_init: Move __prombss to it's own section and store it in=
 .bss
      powerpc: Check prom_init for disallowed sections
      powerpc/prom_init: Generate "phandle" instead of "linux, phandle"
      macintosh/windfarm_smu_sat: Fix debug output

Breno Leitao (11):
      powerpc/selftests: Wait all threads to join
      powerpc/tm: Fix HTM documentation
      powerpc/xive: Use xive_cpu->chip_id instead of looking it up again
      powerpc/iommu: Avoid derefence before pointer check
      selftests/powerpc: Do not fail with reschedule
      powerpc: Redefine TIF_32BITS thread flag
      powerpc/ptrace: Add support for PTRACE_SYSEMU
      selftests/powerpc: New PTRACE_SYSEMU test
      powerpc/powernv: Mark function as __noreturn
      powerpc/tm: Remove msr_tm_active()
      powerpc/tm: Print 64-bits MSR

Christophe Leroy (50):
      powerpc/traps: merge unrecoverable_exception() and nonrecoverable_exc=
eption()
      powerpc/32: add stack protector support
      powerpc/64: add stack protector support
      powerpc/mm: Don't report hugepage tables as memory leaks when using k=
memleak
      powerpc: Wire up memtest
      powerpc/64: properly initialise the stackprotector canary on SMP.
      powerpc/process: Fix sparse address space warnings
      powerpc/process: Add missing include of stacktrace.h
      powerpc/process: Fix interleaved output in show_user_instructions()
      powerpc/process: Constify the number of insns printed by show instruc=
tions functions.
      powerpc/32: Add ioremap_wt() and ioremap_coherent()
      drivers/video/fbdev: use ioremap_wc/wt() instead of __ioremap()
      drivers/block/z2ram: use ioremap_wt() instead of __ioremap(_PAGE_WRIT=
ETHRU)
      soc/fsl/qbman: use ioremap_cache() instead of ioremap_prot(0)
      powerpc: don't use ioremap_prot() nor __ioremap() unless really neede=
d.
      powerpc/mm: properly set PAGE_KERNEL flags in ioremap()
      powerpc: handover page flags with a pgprot_t parameter
      powerpc/mm: don't use _PAGE_EXEC in book3s/32
      powerpc/mm: move some nohash pte helpers in nohash/[32:64]/pgtable.h
      powerpc/mm: add pte helpers to query and change pte flags
      powerpc/mm: don't use _PAGE_EXEC for calling hash_preload()
      powerpc/mm: use pte helpers in generic code
      powerpc/mm: Split dump_pagelinuxtables flag_array table
      powerpc/mm: drop unused page flags
      powerpc/mm: move __P and __S tables in the common pgtable.h
      powerpc/book3s/32: do not include pte-common.h
      powerpc/mm: Move pte_user() into nohash/pgtable.h
      powerpc/mm: Distribute platform specific PAGE and PMD flags and defin=
itions
      powerpc/nohash/64: do not include pte-common.h
      powerpc/mm: Allow platforms to redefine some helpers
      powerpc/mm: Define platform default caches related flags
      powerpc/mm: Get rid of pte-common.h
      powerpc/8xx: change name of a few page flags to avoid confusion
      powerpc/book3s64: Avoid multiple endian conversion in pte helpers
      powerpc/book3e: redefine pte_mkprivileged() and pte_mkuser()
      powerpc/traps: fix machine check handlers to use pr_cont()
      powerpc/traps: remove redundant in_interrupt panic in die()
      powerpc/io: remove old GCC version implementation
      powerpc/book3s64: fix dump_linuxpagetables "present" flag
      powerpc/mm: Add missing tracepoint for tlbie
      powerpc/mm: Trace tlbia instruction
      powerpc/mm: fix missing prototypes in slice.c
      powerpc/mm: fix always true/false warning in slice.c
      powerpc/sysdev/ipic: check primary_ipic NULL pointer before using it
      powerpc/kgdb: add kgdb_arch_set/remove_breakpoint()
      powerpc/time: isolate scaled cputime accounting in dedicated function=
s.
      powerpc/time: Only set CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC64
      powerpc/time: no steal_time when CONFIG_PPC_SPLPAR is not selected
      powerpc/traps: restore recoverability of machine_check interrupts
      powerpc/msi: Fix compile error on mpc83xx

Christophe Lombard (1):
      ocxl: Fix access to the AFU Descriptor Data

Dan Carpenter (1):
      powerpc: Fix signedness bug in update_flash_db()

Daniel Axtens (1):
      powerpc/nohash: fix undefined behaviour when testing page size support

Finn Thain (7):
      macintosh: Use common code to access RTC
      macintosh/adb: Rework printk output again
      macintosh/via-macii: Synchronous bus reset
      macintosh/via-macii: Remove BUG_ON assertions
      macintosh/via-macii: Simplify locking
      macintosh/via-macii, macintosh/adb-iop: Modernize printk calls
      macintosh/via-macii, macintosh/adb-iop: Clean up whitespace

Gautham R. Shenoy (4):
      powerpc: Detect the presence of big-cores via "ibm, thread-groups"
      powerpc: Use cpu_smallcore_sibling_mask at SMT level on bigcores
      powerpc/cacheinfo: Report the correct shared_cpu_map on big-cores
      powerpc/rtas: Fix a potential race between CPU-Offline & Migration

Hari Bathini (1):
      powerpc/fadump: re-register firmware-assisted dump if already registe=
red

Joel Stanley (11):
      powerpc/powernv: Don't select the cpufreq governors
      powerpc/configs: Update skiroot defconfig
      powerpc/boot: Ensure _zimage_start is a weak symbol
      powerpc/perf: Quiet IMC PMU registration message
      powerpc: Disable -Wbuiltin-requires-header when setjmp is used
      powerpc/boot: Expose Kconfig symbols to wrapper
      powerpc/boot: Fix opal console in boot wrapper
      powerpc/boot: Disable vector instructions
      powerpc/boot: Build boot wrapper with optimisations
      powerpc/Makefile: Fix PPC_BOOK3S_64 ASFLAGS
      powerpc: Use SWITCH_FRAME_SIZE for prom and rtas entry

Laurent Dufour (3):
      powerpc/pseries/mm: Introducing FW_FEATURE_BLOCK_REMOVE
      powerpc/pseries/mm: factorize PTE slot computation
      powerpc/pseries/mm: call H_BLOCK_REMOVE

Mahesh Salgaonkar (5):
      powerpc/pseries: Define MCE error event section.
      powerpc/pseries: Flush SLB contents on SLB MCE errors.
      powerpc/pseries: Display machine check error details.
      powerpc/pseries: Dump the SLB contents on SLB MCE errors.
      powernv/pseries: consolidate code for mce early handling.

Mark Hairgrove (3):
      powerpc/powernv/npu: Reduce eieio usage when issuing ATSD invalidates
      powerpc/powernv/npu: Use size-based ATSD invalidates
      powerpc/powernv/npu: Remove atsd_threshold debugfs setting

Masahiro Yamada (1):
      powerpc: remove leftover code of old GCC version checks

Michael Bringmann (1):
      powerpc/pseries/mobility: Extend start/stop topology update scope

Michael Ellerman (23):
      Revert "convert SLB miss handlers to C" and subsequent commits
      powerpc/perf: Add missing break in power7_marked_instr_event()
      Merge branch 'fixes' into next
      powerpc/xmon: Show the stack protector canary in xmon
      powerpc: Fix stackprotector detection for non-glibc toolchains
      powerpc: Split user/kernel definitions of struct pt_regs
      powerpc/ptrace: Don't use sizeof(struct pt_regs) in ptrace code
      powerpc: Move core kernel logic into arch/powerpc/Kbuild
      powerpc: Add -Werror at arch/powerpc level
      powerpc/uapi: Fix sigcontext definition to use user_pt_regs
      powerpc/aout: Fix struct user definition to use user_pt_regs
      powerpc/time: Fix clockevent_decrementer initalisation for PR KVM
      selftests/powerpc: Fix out-of-tree build errors
      powerpc/mm/radix: Fix off-by-one in split mapping logic
      powerpc/mm/radix: Fix overuse of small pages in splitting logic
      powerpc/mm/radix: Fix small page at boundary when splitting
      powerpc/mm/radix: Remove the retry in the split mapping logic
      powerpc/mm/radix: Simplify split mapping logic
      powerpc/mm/radix: Display if mappings are exec or not
      powerpc/mm: Fix page table dump to work on Radix
      selftests/powerpc: Add a test of wild bctr
      powerpc: Fix stack protector crashes on CPU hotplug
      Revert "selftests/powerpc: Fix out-of-tree build errors"

Michael Neuling (2):
      powerpc/tm: Fix HFSCR bit for no suspend case
      powerpc/tm: Reformat comments

Michal Suchanek (1):
      powerpc/64s: consolidate MCE counter increment.

Nathan Fontenot (4):
      powerpc/pseries/memory-hotplug: Only update DT once per memory DLPAR =
request
      powerpc/pseries: Remove prrn_work workqueue
      powerpc/pseries: Remove unneeded uses of dlpar work queue
      powerpc/pseries: Disable CPU hotplug across migrations

Naveen N. Rao (7):
      powerpc/pseries: Fix DTL buffer registration
      powerpc/pseries: Fix how we iterate over the DTL entries
      powerpc: Add support for function error injection
      powerpc64/module elfv1: Set opd addresses after module relocation
      selftests/powerpc: Move UCONTEXT_NIA() into utils.h
      selftests/powerpc: Add test to verify rfi flush across a system call
      powerpc/ftrace: Handle large kernel configs

Nicholas Piggin (26):
      powerpc/64s/hash: Fix stab_rr off by one initialization
      powerpc/64s/hash: avoid the POWER5 < DD2.1 slb invalidate workaround =
on POWER8/9
      powerpc/64s/hash: move POWER5 < DD2.1 slbie workaround where it is ne=
eded
      powerpc/64s/hash: remove the vmalloc segment from the bolted SLB
      powerpc/64s/hash: Use POWER6 SLBIA IH=3D1 variant in switch_slb
      powerpc/64s/hash: Use POWER9 SLBIA IH=3D3 variant in switch_slb
      powerpc/64s/hash: convert SLB miss handlers to C
      powerpc/64s/hash: remove user SLB data from the paca
      powerpc/64s/hash: SLB allocation status bitmaps
      powerpc/64s: xmon do not dump hash fields when using radix mode
      powerpc/64s/hash: provide arch_setup_exec hooks for hash slice setup
      powerpc/64s/hash: Add a SLB preload cache
      powerpc: remove old GCC version checks
      powerpc: consolidate -mno-sched-epilog into FTRACE flags
      powerpc: avoid -mno-sched-epilog on GCC 4.9 and newer
      powerpc/64s/hash: Do not use PPC_INVALIDATE_ERAT on CPUs before POWER9
      powerpc/64s/radix: Explicitly flush ERAT with local LPID invalidation
      powerpc/64: Interrupts save PPR on stack rather than thread_struct
      powerpc/64s/hash: Convert SLB miss handlers to C
      powerpc/64s/hash: Add SLB allocation status bitmaps
      powerpc/64s/hash: Provide arch_setup_exec() hooks for hash slice setup
      powerpc/64s/hash: Add a SLB preload cache
      powerpc/64s/hash: Simplify slb_flush_and_rebolt()
      powerpc/64s/hash: Add some SLB debugging tests
      powerpc/64s/radix: Fix radix__flush_tlb_collapsed_pmd double flushing=
 pmd
      powerpc/64/module: REL32 relocation range check

Oliver O'Halloran (3):
      powerpc/rtasd: Improve unknown error logging
      powerpc/pseries: PAPR persistent memory support
      powerpc/pseries: Add driver for PAPR SCM regions

Petr Vorel (1):
      powerpc/config: Enable CONFIG_PRINTK_TIME

Rashmica Gupta (1):
      powerpc/memtrace: Remove memory in chunks

Rob Herring (4):
      powerpc/cell: Use irq_of_parse_and_map() helper
      powerpc/pseries: Use of_irq_get helper() in request_event_sources_irq=
s()
      macintosh: Convert to using %pOFn instead of device_node.name
      powerpc: Convert to using %pOFn instead of device_node.name

Sam Bobroff (14):
      powerpc/eeh: Fix possible null deref in eeh_dump_dev_log()
      powerpc/eeh: Fix null deref for devices removed during EEH
      powerpc/eeh: Fix use of EEH_PE_KEEP on wrong field
      powerpc/eeh: Cleanup EEH_POSTPONED_PROBE
      powerpc/eeh: Cleanup unused field in eeh_dev
      powerpc/eeh: Cleanup eeh_add_virt_device()
      powerpc/eeh: Cleanup list_head field names
      powerpc/eeh: Cleanup field names in eeh_rmv_data
      powerpc/eeh: Cleanup logic in eeh_rmv_from_parent_pe()
      powerpc/eeh: Cleanup eeh_enabled()
      powerpc/eeh: Cleanup unnecessary eeh_pe_state_mark_with_cfg()
      powerpc/eeh: Cleanup eeh_pe_state_mark()
      powerpc/eeh: Cleanup eeh_ops.wait_state()
      powerpc/eeh: Cleanup control flow in eeh_handle_normal_event()

Suraj Jitindar Singh (2):
      powerpc/prom: Remove VLA in prom_check_platform_support()
      powerpc/pseries: Remove VLA from lparcfg_write()

Vaibhav Jain (1):
      powerpc/powernv: Make possible for user to force a full ipl cec reboot

YueHaibing (2):
      powerpc: Remove duplicated include from pci_32.c
      powerpc/pseries/memory-hotplug: Fix return value type of find_aa_index

zhong jiang (1):
      powerpc/xive: Move a dereference below a NULL test


 Documentation/admin-guide/kernel-parameters.txt    |   2 +-
 arch/m68k/mac/misc.c                               |  75 +-
 arch/powerpc/Kbuild                                |  16 +
 arch/powerpc/Kconfig                               |  19 +-
 arch/powerpc/Kconfig.debug                         |   6 -
 arch/powerpc/Makefile                              |  91 +--
 arch/powerpc/boot/.gitignore                       |   1 +
 arch/powerpc/boot/Makefile                         |  11 +-
 arch/powerpc/boot/crt0.S                           |   4 +-
 arch/powerpc/boot/opal.c                           |   8 -
 arch/powerpc/boot/serial.c                         |   1 +
 arch/powerpc/configs/g5_defconfig                  |   1 +
 arch/powerpc/configs/maple_defconfig               |   1 +
 arch/powerpc/configs/powernv_defconfig             |   4 +
 arch/powerpc/configs/ppc64_defconfig               |   4 +
 arch/powerpc/configs/ps3_defconfig                 |   1 +
 arch/powerpc/configs/pseries_defconfig             |   1 +
 arch/powerpc/configs/skiroot_defconfig             | 154 ++--
 arch/powerpc/include/asm/accounting.h              |   4 +
 arch/powerpc/include/asm/asm-prototypes.h          |   3 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       | 152 +++-
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |   2 +-
 arch/powerpc/include/asm/book3s/64/hash.h          |   8 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h       |   3 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h      |  95 ++-
 arch/powerpc/include/asm/book3s/64/mmu.h           |   4 +-
 arch/powerpc/include/asm/book3s/64/pgtable-64k.h   |   3 +
 arch/powerpc/include/asm/book3s/64/pgtable.h       | 181 +++--
 arch/powerpc/include/asm/cputhreads.h              |   2 +
 arch/powerpc/include/asm/cputime.h                 |   1 -
 arch/powerpc/include/asm/drmem.h                   |   5 +
 arch/powerpc/include/asm/eeh.h                     |  24 +-
 arch/powerpc/include/asm/error-injection.h         |  13 +
 arch/powerpc/include/asm/exception-64s.h           |  17 +-
 arch/powerpc/include/asm/firmware.h                |   5 +-
 arch/powerpc/include/asm/fixmap.h                  |   2 +-
 arch/powerpc/include/asm/hvcall.h                  |  11 +-
 arch/powerpc/include/asm/io.h                      |  33 +-
 arch/powerpc/include/asm/kgdb.h                    |   5 +-
 arch/powerpc/include/asm/machdep.h                 |   3 +-
 arch/powerpc/include/asm/mce.h                     |   3 +
 arch/powerpc/include/asm/mmu.h                     |  15 +
 arch/powerpc/include/asm/mmu_context.h             |   2 +-
 arch/powerpc/include/asm/mpic.h                    |   7 +
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  69 +-
 arch/powerpc/include/asm/nohash/32/pte-40x.h       |  43 ++
 arch/powerpc/include/asm/nohash/32/pte-44x.h       |  30 +
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |  87 ++-
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h |  33 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |  41 +-
 arch/powerpc/include/asm/nohash/pgtable.h          | 100 ++-
 arch/powerpc/include/asm/nohash/pte-book3e.h       |  41 ++
 arch/powerpc/include/asm/opal-api.h                |   1 +
 arch/powerpc/include/asm/paca.h                    |  18 +-
 arch/powerpc/include/asm/pgtable.h                 |  29 +
 arch/powerpc/include/asm/ppc-pci.h                 |   1 +
 arch/powerpc/include/asm/processor.h               |   7 +-
 arch/powerpc/include/asm/pte-common.h              | 219 ------
 arch/powerpc/include/asm/ptrace.h                  |  36 +
 arch/powerpc/include/asm/reg.h                     |   7 +-
 arch/powerpc/include/asm/rtas.h                    |  15 +
 arch/powerpc/include/asm/slice.h                   |   1 +
 arch/powerpc/include/asm/smp.h                     |  11 +
 arch/powerpc/include/asm/sparsemem.h               |  11 -
 arch/powerpc/include/asm/stackprotector.h          |  38 +
 arch/powerpc/include/asm/thread_info.h             |  17 +-
 arch/powerpc/include/asm/trace.h                   |  15 +
 arch/powerpc/include/asm/uaccess.h                 |   6 +-
 arch/powerpc/include/asm/user.h                    |   2 +-
 arch/powerpc/include/uapi/asm/ptrace.h             |  11 +-
 arch/powerpc/include/uapi/asm/sigcontext.h         |   6 +-
 arch/powerpc/kernel/Makefile                       |  13 +-
 arch/powerpc/kernel/asm-offsets.c                  |  19 +-
 arch/powerpc/kernel/btext.c                        |   2 +-
 arch/powerpc/kernel/cacheinfo.c                    |  37 +-
 arch/powerpc/kernel/crash_dump.c                   |   2 +-
 arch/powerpc/kernel/eeh.c                          |  42 +-
 arch/powerpc/kernel/eeh_dev.c                      |   2 -
 arch/powerpc/kernel/eeh_driver.c                   | 237 +++----
 arch/powerpc/kernel/eeh_pe.c                       | 160 +++--
 arch/powerpc/kernel/entry_32.S                     |   4 +-
 arch/powerpc/kernel/entry_64.S                     |  33 +-
 arch/powerpc/kernel/exceptions-64s.S               | 244 ++-----
 arch/powerpc/kernel/fadump.c                       |   4 +-
 arch/powerpc/kernel/head_8xx.S                     |   6 +-
 arch/powerpc/kernel/io-workarounds.c               |   4 +-
 arch/powerpc/kernel/iommu.c                        |   2 +-
 arch/powerpc/kernel/isa-bridge.c                   |   6 +-
 arch/powerpc/kernel/kgdb.c                         |  43 +-
 arch/powerpc/kernel/mce.c                          |   9 +-
 arch/powerpc/kernel/mce_power.c                    |   9 +-
 arch/powerpc/kernel/module.c                       |   8 +
 arch/powerpc/kernel/module_64.c                    |  14 +-
 arch/powerpc/kernel/pci_32.c                       |   1 -
 arch/powerpc/kernel/pci_64.c                       |   2 +-
 arch/powerpc/kernel/process.c                      |  90 ++-
 arch/powerpc/kernel/prom_init.c                    | 223 ++----
 arch/powerpc/kernel/prom_init_check.sh             |  16 +
 arch/powerpc/kernel/ptrace.c                       |  68 +-
 arch/powerpc/kernel/rtas.c                         |  13 +-
 arch/powerpc/kernel/rtasd.c                        |  25 +-
 arch/powerpc/kernel/setup-common.c                 |   3 +
 arch/powerpc/kernel/setup_64.c                     |  18 +-
 arch/powerpc/kernel/smp.c                          | 245 ++++++-
 arch/powerpc/kernel/swsusp_asm64.S                 |   2 +-
 arch/powerpc/kernel/time.c                         | 104 +--
 arch/powerpc/kernel/tm.S                           |  75 +-
 arch/powerpc/kernel/trace/Makefile                 |   4 +-
 arch/powerpc/kernel/trace/ftrace.c                 | 261 ++++++-
 arch/powerpc/kernel/trace/ftrace_64.S              |  12 +
 arch/powerpc/kernel/traps.c                        | 123 ++--
 arch/powerpc/kernel/vdso32/datapage.S              |   1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S          |   1 +
 arch/powerpc/kernel/vdso64/datapage.S              |   1 +
 arch/powerpc/kernel/vdso64/gettimeofday.S          |   1 +
 arch/powerpc/kernel/vmlinux.lds.S                  |  16 +-
 arch/powerpc/kvm/Makefile                          |   2 -
 arch/powerpc/lib/Makefile                          |   4 +-
 arch/powerpc/lib/code-patching.c                   |   3 +-
 arch/powerpc/lib/error-inject.c                    |  16 +
 arch/powerpc/lib/mem_64.S                          |   4 +-
 arch/powerpc/mm/8xx_mmu.c                          |   5 +-
 arch/powerpc/mm/Makefile                           |  13 +-
 arch/powerpc/mm/dma-noncoherent.c                  |   2 +-
 arch/powerpc/mm/dump_linuxpagetables-8xx.c         |  82 +++
 arch/powerpc/mm/dump_linuxpagetables-book3s64.c    | 120 ++++
 arch/powerpc/mm/dump_linuxpagetables-generic.c     |  82 +++
 arch/powerpc/mm/dump_linuxpagetables.c             | 167 +----
 arch/powerpc/mm/dump_linuxpagetables.h             |  19 +
 arch/powerpc/mm/hash_native_64.c                   |   4 +-
 arch/powerpc/mm/hash_utils_64.c                    |  13 +-
 arch/powerpc/mm/hugepage-hash64.c                  |   6 +
 arch/powerpc/mm/hugetlbpage-hash64.c               |   4 +
 arch/powerpc/mm/hugetlbpage.c                      |  13 +-
 arch/powerpc/mm/mem.c                              |  13 +-
 arch/powerpc/mm/mmu_context_book3s64.c             |   9 +
 arch/powerpc/mm/mmu_decl.h                         |   6 +-
 arch/powerpc/mm/numa.c                             |   6 +
 arch/powerpc/mm/pgtable-book3e.c                   |   9 +-
 arch/powerpc/mm/pgtable-book3s64.c                 |  11 +-
 arch/powerpc/mm/pgtable-hash64.c                   |   7 +-
 arch/powerpc/mm/pgtable-radix.c                    |  65 +-
 arch/powerpc/mm/pgtable.c                          |  32 +-
 arch/powerpc/mm/pgtable_32.c                       |  70 +-
 arch/powerpc/mm/pgtable_64.c                       |  57 +-
 arch/powerpc/mm/ppc_mmu_32.c                       |   2 +-
 arch/powerpc/mm/slb.c                              | 784 +++++++++++++++--=
----
 arch/powerpc/mm/slb_low.S                          | 335 ---------
 arch/powerpc/mm/slice.c                            |  38 +-
 arch/powerpc/mm/tlb-radix.c                        |   2 +-
 arch/powerpc/mm/tlb_nohash.c                       |   3 +
 arch/powerpc/oprofile/Makefile                     |   1 -
 arch/powerpc/perf/Makefile                         |   1 -
 arch/powerpc/perf/imc-pmu.c                        |   2 +-
 arch/powerpc/perf/power7-pmu.c                     |   1 +
 arch/powerpc/platforms/40x/Kconfig                 |   9 -
 arch/powerpc/platforms/44x/Kconfig                 |  22 -
 arch/powerpc/platforms/44x/fsp2.c                  |   8 +-
 arch/powerpc/platforms/4xx/ocm.c                   |   7 +-
 arch/powerpc/platforms/82xx/Kconfig                |   1 -
 arch/powerpc/platforms/85xx/smp.c                  |   4 +-
 arch/powerpc/platforms/8xx/machine_check.c         |   4 +-
 arch/powerpc/platforms/Kconfig                     |  21 -
 arch/powerpc/platforms/Kconfig.cputype             |   5 +-
 arch/powerpc/platforms/Makefile                    |   2 -
 arch/powerpc/platforms/cell/Kconfig                |   3 -
 arch/powerpc/platforms/cell/spu_manage.c           |  25 +-
 arch/powerpc/platforms/embedded6xx/wii.c           |   2 +-
 arch/powerpc/platforms/maple/Kconfig               |   1 -
 arch/powerpc/platforms/pasemi/Kconfig              |   1 -
 arch/powerpc/platforms/pasemi/dma_lib.c            |   2 +-
 arch/powerpc/platforms/powermac/Makefile           |   3 +-
 arch/powerpc/platforms/powermac/time.c             | 126 +---
 arch/powerpc/platforms/powernv/Kconfig             |   6 -
 arch/powerpc/platforms/powernv/eeh-powernv.c       |  62 +-
 arch/powerpc/platforms/powernv/memtrace.c          |  21 +-
 arch/powerpc/platforms/powernv/npu-dma.c           | 198 +++---
 arch/powerpc/platforms/powernv/opal-powercap.c     |   3 +-
 .../powerpc/platforms/powernv/opal-sensor-groups.c |   4 +-
 arch/powerpc/platforms/powernv/opal-sysparam.c     |   2 +-
 arch/powerpc/platforms/powernv/opal.c              |   2 +-
 arch/powerpc/platforms/powernv/setup.c             |  47 +-
 arch/powerpc/platforms/ps3/Kconfig                 |   2 -
 arch/powerpc/platforms/ps3/os-area.c               |   2 +-
 arch/powerpc/platforms/ps3/spu.c                   |   3 +-
 arch/powerpc/platforms/pseries/Kconfig             |   9 +-
 arch/powerpc/platforms/pseries/Makefile            |   3 +-
 arch/powerpc/platforms/pseries/dlpar.c             |  41 +-
 arch/powerpc/platforms/pseries/dtl.c               |   4 +-
 arch/powerpc/platforms/pseries/eeh_pseries.c       |  66 +-
 arch/powerpc/platforms/pseries/event_sources.c     |  40 +-
 arch/powerpc/platforms/pseries/firmware.c          |   2 +
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |  28 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c    | 116 ++-
 arch/powerpc/platforms/pseries/ibmebus.c           |   2 +-
 arch/powerpc/platforms/pseries/lpar.c              | 295 +++++++-
 arch/powerpc/platforms/pseries/lparcfg.c           |   5 +-
 arch/powerpc/platforms/pseries/mobility.c          |  23 +-
 arch/powerpc/platforms/pseries/msi.c               |   3 +-
 arch/powerpc/platforms/pseries/papr_scm.c          | 345 +++++++++
 arch/powerpc/platforms/pseries/pci.c               |   1 +
 arch/powerpc/platforms/pseries/pmem.c              | 164 +++++
 arch/powerpc/platforms/pseries/pseries.h           |  11 +-
 arch/powerpc/platforms/pseries/ras.c               | 308 +++++++-
 arch/powerpc/platforms/pseries/setup.c             |  14 +
 arch/powerpc/platforms/pseries/vio.c               |  27 +-
 arch/powerpc/sysdev/Kconfig                        |   5 -
 arch/powerpc/sysdev/Makefile                       |   3 -
 arch/powerpc/sysdev/fsl_85xx_cache_sram.c          |   8 +-
 arch/powerpc/sysdev/ipic.c                         |   2 +-
 arch/powerpc/sysdev/xics/Makefile                  |   1 -
 arch/powerpc/sysdev/xive/Kconfig                   |   3 -
 arch/powerpc/sysdev/xive/Makefile                  |   1 -
 arch/powerpc/sysdev/xive/common.c                  |   7 +-
 arch/powerpc/sysdev/xive/native.c                  |  11 +-
 arch/powerpc/xmon/Makefile                         |   5 +-
 arch/powerpc/xmon/xmon.c                           |  56 +-
 drivers/block/z2ram.c                              |   3 +-
 drivers/macintosh/adb-iop.c                        |  50 +-
 drivers/macintosh/adb.c                            |   8 +-
 drivers/macintosh/adbhid.c                         |  53 +-
 drivers/macintosh/macio_asic.c                     |   8 +-
 drivers/macintosh/macio_sysfs.c                    |   8 +-
 drivers/macintosh/via-cuda.c                       |  35 +
 drivers/macintosh/via-macii.c                      | 352 +++++----
 drivers/macintosh/via-pmu.c                        |  33 +
 drivers/macintosh/windfarm_smu_controls.c          |   4 +-
 drivers/macintosh/windfarm_smu_sat.c               |  25 +-
 drivers/misc/ocxl/config.c                         |   4 +-
 drivers/pci/hotplug/pnv_php.c                      |   2 +-
 drivers/pcmcia/electra_cf.c                        |   2 +-
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   2 +-
 drivers/video/fbdev/chipsfb.c                      |   3 +-
 drivers/video/fbdev/controlfb.c                    |   5 +-
 drivers/video/fbdev/platinumfb.c                   |   5 +-
 drivers/video/fbdev/valkyriefb.c                   |  12 +-
 include/linux/cuda.h                               |   4 +
 include/linux/pmu.h                                |   4 +
 tools/testing/selftests/powerpc/Makefile           |   3 +-
 tools/testing/selftests/powerpc/include/reg.h      |   1 +
 tools/testing/selftests/powerpc/include/utils.h    |  18 +
 tools/testing/selftests/powerpc/mm/.gitignore      |   3 +-
 tools/testing/selftests/powerpc/mm/Makefile        |   4 +-
 tools/testing/selftests/powerpc/mm/wild_bctr.c     | 155 ++++
 .../powerpc/primitives/load_unaligned_zeropad.c    |   8 -
 tools/testing/selftests/powerpc/ptrace/Makefile    |   2 +-
 .../selftests/powerpc/ptrace/ptrace-syscall.c      | 228 ++++++
 tools/testing/selftests/powerpc/security/Makefile  |   9 +
 .../testing/selftests/powerpc/security/rfi_flush.c | 132 ++++
 tools/testing/selftests/powerpc/tm/tm-tmspr.c      |  27 +-
 .../testing/selftests/powerpc/tm/tm-unavailable.c  |   9 +-
 tools/testing/selftests/powerpc/tm/tm.h            |   9 +
 tools/testing/selftests/powerpc/utils.c            | 152 ++++
 253 files changed, 6305 insertions(+), 3400 deletions(-)
 create mode 100644 arch/powerpc/Kbuild
 create mode 100644 arch/powerpc/include/asm/error-injection.h
 delete mode 100644 arch/powerpc/include/asm/pte-common.h
 create mode 100644 arch/powerpc/include/asm/stackprotector.h
 create mode 100644 arch/powerpc/lib/error-inject.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-8xx.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-book3s64.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables-generic.c
 create mode 100644 arch/powerpc/mm/dump_linuxpagetables.h
 delete mode 100644 arch/powerpc/mm/slb_low.S
 create mode 100644 arch/powerpc/platforms/pseries/papr_scm.c
 create mode 100644 arch/powerpc/platforms/pseries/pmem.c
 create mode 100644 tools/testing/selftests/powerpc/mm/wild_bctr.c
 create mode 100644 tools/testing/selftests/powerpc/ptrace/ptrace-syscall.c
 create mode 100644 tools/testing/selftests/powerpc/security/Makefile
 create mode 100644 tools/testing/selftests/powerpc/security/rfi_flush.c
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJb017dAAoJEFHr6jzI4aWAnlQP/3upt08ScW29U3UWx6e+c5za
l1tj/tCzsNz6QfPBgHdPk0GGE7ZdBKAaqtXzx0OaboGg5D1467MnUU1zkh1jx53Q
/BmuWDCiWLOv7VGb7YIsYZg7XztfkwTRilZnw4J2Y6UQanYC5ebOMtu0ze6fiYey
ETmnWHCDb4yluX/RFRHthcqAjNFD1r6w4JPIVYMde19l2POlrDTnKyb/K5uAwUm/
Wr622G4BJZz5nfXPWR5VZMDto4/n+ZOLwRtF9wirqWuP18KB2uRfCxawzzKyR6oS
Bwd15zT5jz/sWeqbIvAkf7ROTZfHr55XgdZ4VDexjGuVkbnp8ri9niI3xEc0ojT1
bRtMds89BFoiSqraY8HdPBpdEP879JvQz0+T+PArHRkMXcXFvW16WaB4awtPNnl5
ga+QnQ6z8IPzYomWgNLTv+eMXbSK8A7gChcIaEtDRDOswVTIDp8yew3mtE3rwOkC
Fvnbf7PYav5lYjGfaPaV5+EaE2wlu+FQHpXmI+H/G4mLxtkUe6XR19Q7Q/XkRzY+
uP/TAziGVBjygGm4PM7bxh+f8HTXRKtfLB6Ota7ud0nLrGj7CjroMUm6dgrcS4Xz
FAaz/qmvnO0aVWOkxUvG3wwYhpzo2DyQLS99oi+t5VIOWupCBFySLc8UZSuWzK1G
3lbQqXAcSuYohCP0dgZH
=3DupUr
-----END PGP SIGNATURE-----
