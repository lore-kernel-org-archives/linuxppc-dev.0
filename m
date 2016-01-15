Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA25B1A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 21:16:47 +1100 (AEDT)
Message-ID: <1452852990.23073.8.camel@ellerman.id.au>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.5-1 tag
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Pengbo.Li@freescale.com, alexandre.belloni@free-electrons.com,
 alistair@popple.id.au, andrew.donnellan@au1.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, anton@samba.org, arnd@arndb.de,
 boqun.feng@gmail.com, computersforpeace@gmail.com, danielwa@cisco.com,
 dja@axtens.net, gwshan@linux.vnet.ibm.com, harninder.rai@freescale.com,
 hongtao.jia@freescale.com, hughd@google.com, igal.liberman@freescale.com,
 imunsie@au1.ibm.com, john.ogness@linutronix.de, k.kozlowski@samsung.com,
 laurent@vivier.eu, ldufour@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
 luis@debethencourt.com, mikey@neuling.org,  nfont@linux.vnet.ibm.com,
 oss@buserror.net, paulus@ozlabs.org,  peterz@infradead.org,
 qiang.zhao@freescale.com, raghav@freescale.com,  rashmicy@gmail.com,
 robh@kernel.org, rostedt@goodmis.org, ruscur@russell.cc,
 scottwood@freescale.com, stewart@linux.vnet.ibm.com,
 ukrishn@linux.vnet.ibm.com,  ulrich.weigand@de.ibm.com,
 vaibhav@linux.vnet.ibm.com, vipin@linux.vnet.ibm.com
Date: Fri, 15 Jan 2016 21:16:30 +1100
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature";
 boundary="=-WJbcH+fj++FxWxD7fWEp"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-WJbcH+fj++FxWxD7fWEp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull powerpc updates for 4.5:

The following changes since commit 1ec218373b8ebda821aec00bb156a9c94fad9cd4=
:

  Linux 4.4-rc2 (2015-11-22 16:45:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powe=
rpc-4.5-1

for you to fetch changes up to be6bfc29bc759670fb3a2519325c4ab2edf259c9:

  Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/scot=
twood/linux into next (2016-01-14 09:55:01 +1100)

----------------------------------------------------------------
powerpc updates for 4.5

 - Ground work for the new Power9 MMU from Aneesh Kumar K.V
 - Optimise FP/VMX/VSX context switching from Anton Blanchard

 - Various cleanups from Krzysztof Kozlowski, John Ogness, Rashmica Gupta,
   Russell Currey, Gavin Shan, Daniel Axtens, Michael Neuling, Andrew Donne=
llan
 - Allow wrapper to work on non-english system from Laurent Vivier
 - Add rN aliases to the pt_regs_offset table from Rashmica Gupta
 - Fix module autoload for rackmeter & axonram drivers from Luis de Bethenc=
ourt
 - Include KVM guest test in all interrupt vectors from Paul Mackerras
 - Fix DSCR inheritance over fork() from Anton Blanchard
 - Make value-returning atomics & {cmp}xchg* & their atomic_ versions fully=
 ordered from Boqun Feng
 - Print MSR TM bits in oops messages from Michael Neuling
 - Add TM signal return & invalid stack selftests from Michael Neuling
 - Limit EPOW reset event warnings from Vipin K Parashar
 - Remove the Cell QPACE code from Rashmica Gupta
 - Append linux_banner to exception information in xmon from Rashmica Gupta
 - Add selftest to check if VSRs are corrupted from Rashmica Gupta
 - Remove broken GregorianDay() from Daniel Axtens
 - Import Anton's context_switch2 benchmark into selftests from Michael Ell=
erman
 - Add selftest script to test HMI functionality from Daniel Axtens
 - Remove obsolete OPAL v2 support from Stewart Smith
 - Make enter_rtas() private from Michael Ellerman
 - PPR exception cleanups from Michael Ellerman
 - Add page soft dirty tracking from Laurent Dufour
 - Add support for Nvlink NPUs from Alistair Popple
 - Add support for kexec on 476fpe from Alistair Popple
 - Enable kernel CPU dlpar from sysfs from Nathan Fontenot
 - Copy only required pieces of the mm_context_t to the paca from Michael N=
euling
 - Add a kmsg_dumper that flushes OPAL console output on panic from Russell=
 Currey
 - Implement save_stack_trace_regs() to enable kprobe stack tracing from St=
even Rostedt
 - Add HWCAP bits for Power9 from Michael Ellerman
 - Fix _PAGE_PTE breaking swapoff from Aneesh Kumar K.V
 - Fix _PAGE_SWP_SOFT_DIRTY breaking swapoff from Hugh Dickins
 - scripts/recordmcount.pl: support data in text section on powerpc from Ul=
rich Weigand
 - Handle R_PPC64_ENTRY relocations in modules from Ulrich Weigand

 - cxl: Fix possible idr warning when contexts are released from Vaibhav Ja=
in
 - cxl: use correct operator when writing pcie config space values from And=
rew Donnellan
 - cxl: Fix DSI misses when the context owning task exits from Vaibhav Jain
 - cxl: fix build for GCC 4.6.x from Brian Norris
 - cxl: use -Werror only with CONFIG_PPC_WERROR from Brian Norris
 - cxl: Enable PCI device ID for future IBM CXL adapter from Uma Krishnan

 - Freescale updates from Scott: Highlights include moving QE code out of
   arch/powerpc (to be shared with arm), device tree updates, and minor fix=
es.

----------------------------------------------------------------
Alistair Popple (7):
      Revert "powerpc/pci: Remove unused struct pci_dn.pcidev field"
      powerpc: Add __raw_rm_writeq() function
      powerpc/powernv: Add support for Nvlink NPUs
      powerpc/476fpe: Add support for kexec
      powerpc/powernv: Fix update of NVLink DMA mask
      powerpc/powernv: Change NPU PE# assignment
      powerpc/powernv: Reserve PE#0 on NPU

Andrew Donnellan (3):
      cxl: use correct operator when writing pcie config space values
      powerpc: Fix style of self-test config prompts
      powerpc/powernv: Fix minor off-by-one error in opal_mce_check_early_r=
ecovery()

Aneesh Kumar K.V (31):
      powerpc/mm: Fix infinite loop in hash fault with 4K page size
      powerpc/mm: move pte headers to book3s directory
      powerpc/mm: make a separate copy for book3s
      powerpc/mm: Move hash specific pte width and other defines to book3s
      powerpc/mm: Delete booke bits from book3s
      powerpc/mm: Don't have generic headers introduce functions touching p=
te bits
      powerpc/mm: Drop pte-common.h from BOOK3S 64
      powerpc/mm: Don't use pte_val as lvalue
      powerpc/mm: Don't use pmd_val, pud_val and pgd_val as lvalue
      powerpc/mm: Move hash64 PTE bits from book3s/64/pgtable.h to hash.h
      powerpc/mm: Move PTE bits from generic functions to hash64 functions.
      powerpc/booke: Move nohash headers
      powerpc/mm: Convert 4k hash insert to C
      powerpc/mm: Remove the dependency on pte bit position in asm code
      powerpc/mm: Don't track subpage valid bit in pte_t
      powerpc/mm: Remove pte_val usage for the second half of pgtable_t
      powerpc/mm: Increase the width of #define
      powerpc/mm: Convert __hash_page_64K to C
      powerpc/mm: Convert 4k insert from asm to C
      powerpc/mm: Add helper for converting pte bit to hpte bits
      powerpc/mm: Move WIMG update to helper.
      powerpc/mm: Move hugetlb related headers
      powerpc/mm: Move THP headers around
      powerpc/mm: Add a _PAGE_PTE bit
      powerpc/mm: Don't hardcode page table size
      powerpc/mm: Don't hardcode the hash pte slot shift
      powerpc/nohash: Update 64K nohash config to have 32 pte fragement
      powerpc/nohash: we don't use real_pte_t for nohash
      powerpc/mm: Use H_READ with H_READ_4
      powerpc/mm: Don't open code pgtable_t size
      powerpc/mm: Fix _PAGE_PTE breaking swapoff

Anton Blanchard (22):
      powerpc: Don't disable kernel FP/VMX/VSX MSR bits on context switch
      powerpc: Don't disable MSR bits in do_load_up_transact_*() functions
      powerpc: Create context switch helpers save_sprs() and restore_sprs()
      powerpc: Remove redundant mflr in _switch
      powerpc: Remove UP only lazy floating point and vector optimisations
      powerpc: Simplify TM restore checks
      powerpc: Create mtmsrd_isync()
      powerpc: Remove NULL task struct pointer checks in FP and vector code
      powerpc: Move part of giveup_fpu,altivec,spe into c
      powerpc: Move part of giveup_vsx into c
      crypto: vmx: Only call enable_kernel_vsx()
      powerpc: Create msr_check_and_{set,clear}()
      powerpc: Create disable_kernel_{fp,altivec,vsx,spe}()
      powerpc: Add ppc_strict_facility_enable boot option
      powerpc: Remove fp_enable() and vec_enable(), use msr_check_and_{set,=
 clear}()
      powerpc: create giveup_all()
      powerpc: create flush_all_to_thread()
      powerpc: Rearrange __switch_to()
      powerpc: clean up asm/switch_to.h
      powerpc: Call check_if_tm_restore_required() in enable_kernel_*()
      powerpc: Call restore_sprs() before _switch()
      powerpc: Fix DSCR inheritance over fork()

Boqun Feng (2):
      powerpc: Make value-returning atomics fully ordered
      powerpc: Make {cmp}xchg* and their atomic_ versions fully ordered

Brian Norris (2):
      cxl: fix build for GCC 4.6.x
      cxl: use -Werror only with CONFIG_PPC_WERROR

Daniel Axtens (3):
      powerpc: Remove broken GregorianDay()
      selftests/powerpc: Add script to test HMI functionality
      powerpc: Add missing calls to va_end()

Daniel Walker (1):
      powerpc/85xx: mpc85xx ADS: remove pci exclude

Gavin Shan (1):
      powerpc/powernv: Fix M64 resource name in /proc/iomem

Harninder Rai (2):
      powerpc/fsl: Add PCI node in device tree of bsc9132qds
      powerpc/85xx: Add PCIe controller support for bsc9132qds

Hongtao Jia (3):
      dt-bindings: Add QorIQ TMU thermal bindings
      powerpc/mpc85xx: Add TMU device tree support for T1040/T1042
      powerpc/mpc85xx: Add TMU device tree support for T1023/T1024

Hugh Dickins (1):
      powerpc/mm: fix _PAGE_SWP_SOFT_DIRTY breaking swapoff

Igal Liberman (1):
      powerpc/mpc85xx: Update B4 FMan MURAM size

John Ogness (2):
      powerpc/powermac: set IRQF_NO_THREAD for xmon/cascade handlers
      powerpc/powermac: IRQF_NO_SUSPEND not IRQF_TIMER for non-timer

Krzysztof Kozlowski (1):
      powerpc/powernv: Drop owner assignment from platform_driver

Laurent Dufour (1):
      powerpc/mm: Add page soft dirty tracking

Laurent Vivier (1):
      powerpc/boot: allow wrapper to work on non-english system

Luis de Bethencourt (2):
      powerpc/rackmeter: Fix module autoload for OF platform driver
      powerpc/axonram: Fix module autoload for OF platform driver

Michael Ellerman (21):
      Merge tag 'powerpc-4.4-3' into next
      selftests/powerpc: Move get_auxv_entry() into utils.c
      selftests/powerpc: Add have_hwcap2() helper
      selftests/powerpc: Move TM helpers into tm.h
      selftests/powerpc: Skip tm-resched-dscr if we don't have TM
      selftests/powerpc: Move pick_online_cpu() up into utils.c
      selftests/powerpc: Import Anton's context_switch2 benchmark
      selftests/powerpc: Make context_switch do something with no args
      selftests/powerpc: Make context_switch touch FP/altivec/vector by def=
ault
      powerpc/rtas: Add rtas_call_unlocked()
      powerpc/xmon: Use rtas_call_unlocked() in xmon
      powerpc/pseries: Use rtas_call_unlocked() in pseries hotplug
      powerpc/rtas: Use rtas_call_unlocked() in call_rtas_display_status()
      powerpc/rtas: Make enter_rtas() private
      powerpc/kernel: Drop HMT_MEDIUM_PPR_DISCARD
      powerpc/kernel: Open code HMT_MEDIUM_LOW_HAS_PPR
      powerpc/kernel: Open code SET_DEFAULT_THREAD_PPR
      powerpc/kernel: Combine vec/loc for STD_EXCEPTION_PSERIES
      powerpc: Fix build break due to paca mm_context_t changes
      powerpc: Add HWCAP bits for Power9
      Merge branch 'next' of git://git.kernel.org/.../scottwood/linux into =
next

Michael Neuling (8):
      powerpc/tm: Block signal return setting invalid MSR state
      powerpc/tm: Check for already reclaimed tasks
      powerpc: Print MSR TM bits in oops messages
      selftests/powerpc: Add TM signal return test
      selftests/powerpc: Add TM signal with invalid stack test
      powerpc: Add function to copy mm_context_t to the paca
      powerpc: Copy only required pieces of the mm_context_t to the paca
      powerpc/powernv: Only delay opal_rtc_read() retry when necessary

Nathan Fontenot (7):
      powerpc/pseries: Verify CPU doesn't exist before adding
      powerpc/pseries: Consolidate CPU hotplug code to hotplug-cpu.c
      powerpc/pseries: Factor out common cpu hotplug code
      powerpc/pseries: Update CPU hotplug error recovery
      powerpc/pseries: Add CPU dlpar remove functionality
      powerpc/pseries: Add CPU dlpar add functionality
      powerpc/pseries: Enable kernel CPU dlpar from sysfs

Paul Mackerras (1):
      powerpc/64: Include KVM guest test in all interrupt vectors

Raghav Dogra (1):
      powerpc/fsl_lbc: removal of dead code

Rashmica Gupta (6):
      powerpc: Remove unused function trace_syscall()
      powerpc: Standardise on NR_syscalls rather than __NR_syscalls.
      powerpc: Add rN aliases to the pt_regs_offset table.
      powerpc/cell: Remove the Cell QPACE code
      powerpc/xmon: Append linux_banner to exception information in xmon.
      selftests/powerpc: Add test to check if VSRs are corrupted

Russell Currey (3):
      powerpc/powernv: Add a kmsg_dumper that flushes console output on pan=
ic
      powerpc/powernv: Remove misleading comment in pci.c
      powerpc/powernv: Fix OPAL_CONSOLE_FLUSH prototype and usages

Scott Wood (2):
      powerpc/e6500: add locking to hugetlb
      MAINTAINERS: Update Scott Wood's e-mail address

Steven Rostedt (1):
      powerpc: Implement save_stack_trace_regs() to enable kprobe stack tra=
cing

Stewart Smith (3):
      powerpc/powernv: panic() on OPAL < V3
      powerpc/powernv: Remove OPALv2 firmware define and references
      powerpc/powernv: remove FW_FEATURE_OPALv3 and just use FW_FEATURE_OPA=
L

Ulrich Weigand (2):
      scripts/recordmcount.pl: support data in text section on powerpc
      powerpc/module: Handle R_PPC64_ENTRY relocations

Uma Krishnan (1):
      cxl: Enable PCI device ID for future IBM CXL adapter

Vaibhav Jain (2):
      cxl: Fix possible idr warning when contexts are released
      cxl: Fix DSI misses when the context owning task exits

Vipin K Parashar (1):
      powerpc/pseries: Limit EPOW reset event warnings

Zhao Qiang (7):
      genalloc:support memory-allocation with bytes-alignment to genalloc
      genalloc:support allocating specific region
      CPM/QE: use genalloc to manage CPM/QE muram
      QE/CPM: move muram management functions to qe_common
      QE: use subsys_initcall to init qe
      QE: Move QE from arch/powerpc to drivers/soc
      powerpc/p1010rdb: Update dts for pcie interrupt-map

li pengbo (1):
      powerpc/85xx: Enable TWR_P102x in mpc85xx_basic_defconfig

 Documentation/devicetree/bindings/serial/8250.txt  |    1 -
 .../devicetree/bindings/thermal/qoriq-thermal.txt  |   63 ++
 Documentation/kernel-parameters.txt                |    6 +
 MAINTAINERS                                        |    7 +-
 arch/powerpc/Kconfig                               |    4 +-
 arch/powerpc/Kconfig.debug                         |    6 +-
 arch/powerpc/boot/Makefile                         |    2 -
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi           |    5 +
 arch/powerpc/boot/dts/fsl/bsc9132qds.dts           |   15 +
 arch/powerpc/boot/dts/fsl/bsc9132si-post.dtsi      |   28 +
 arch/powerpc/boot/dts/fsl/bsc9132si-pre.dtsi       |    1 +
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi            |   16 +
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        |   86 ++
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1024si-post.dtsi        |    2 +-
 arch/powerpc/boot/dts/fsl/t102xsi-pre.dtsi         |    2 +
 arch/powerpc/boot/dts/fsl/t1040d4rdb.dts           |    2 +-
 arch/powerpc/boot/dts/fsl/t1040qds.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1040rdb.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   94 ++
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |    2 +-
 arch/powerpc/boot/dts/fsl/t1042qds.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb.dts             |    2 +-
 arch/powerpc/boot/dts/fsl/t1042rdb_pi.dts          |    2 +-
 arch/powerpc/boot/dts/fsl/t1042si-post.dtsi        |    2 +-
 arch/powerpc/boot/dts/fsl/t104xsi-pre.dtsi         |    4 +
 arch/powerpc/boot/wrapper                          |    2 +-
 arch/powerpc/configs/mpc85xx_basic_defconfig       |    1 +
 arch/powerpc/configs/ppc64_defconfig               |    1 -
 arch/powerpc/crypto/aes-spe-glue.c                 |    1 +
 arch/powerpc/crypto/sha1-spe-glue.c                |    1 +
 arch/powerpc/crypto/sha256-spe-glue.c              |    1 +
 .../include/asm/{pte-hash32.h =3D> book3s/32/hash.h} |    6 +-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  482 ++++++++++
 arch/powerpc/include/asm/book3s/64/hash-4k.h       |  132 +++
 arch/powerpc/include/asm/book3s/64/hash-64k.h      |  312 ++++++
 arch/powerpc/include/asm/book3s/64/hash.h          |  551 +++++++++++
 arch/powerpc/include/asm/book3s/64/pgtable.h       |  300 ++++++
 arch/powerpc/include/asm/book3s/pgtable.h          |   29 +
 arch/powerpc/include/asm/cmpxchg.h                 |   16 +-
 arch/powerpc/include/asm/cpm.h                     |   44 +-
 arch/powerpc/include/asm/exception-64s.h           |   40 +-
 arch/powerpc/include/asm/firmware.h                |    5 +-
 arch/powerpc/include/asm/io.h                      |   11 +
 arch/powerpc/include/asm/mmu-hash64.h              |    2 +-
 .../asm/{pgtable-ppc32.h =3D> nohash/32/pgtable.h}   |   25 +-
 arch/powerpc/include/asm/{ =3D> nohash/32}/pte-40x.h |    6 +-
 arch/powerpc/include/asm/{ =3D> nohash/32}/pte-44x.h |    6 +-
 arch/powerpc/include/asm/{ =3D> nohash/32}/pte-8xx.h |    6 +-
 .../include/asm/{ =3D> nohash/32}/pte-fsl-booke.h    |    6 +-
 .../{pgtable-ppc64-4k.h =3D> nohash/64/pgtable-4k.h} |   12 +-
 .../64/pgtable-64k.h}                              |   27 +-
 .../asm/{pgtable-ppc64.h =3D> nohash/64/pgtable.h}   |  336 +------
 arch/powerpc/include/asm/nohash/pgtable.h          |  252 +++++
 arch/powerpc/include/asm/{ =3D> nohash}/pte-book3e.h |    6 +-
 arch/powerpc/include/asm/opal-api.h                |    3 +-
 arch/powerpc/include/asm/opal.h                    |    3 +
 arch/powerpc/include/asm/paca.h                    |   29 +-
 arch/powerpc/include/asm/page.h                    |   86 +-
 arch/powerpc/include/asm/pci-bridge.h              |    1 +
 arch/powerpc/include/asm/pci.h                     |    4 +
 arch/powerpc/include/asm/pgalloc-32.h              |   34 +-
 arch/powerpc/include/asm/pgalloc-64.h              |   27 +-
 arch/powerpc/include/asm/pgtable.h                 |  200 +---
 arch/powerpc/include/asm/plpar_wrappers.h          |   17 +
 arch/powerpc/include/asm/ppc_asm.h                 |   18 -
 arch/powerpc/include/asm/processor.h               |    9 +-
 arch/powerpc/include/asm/pte-common.h              |    5 +
 arch/powerpc/include/asm/pte-hash64-4k.h           |   17 -
 arch/powerpc/include/asm/pte-hash64-64k.h          |  102 --
 arch/powerpc/include/asm/pte-hash64.h              |   54 --
 arch/powerpc/include/asm/reg.h                     |   18 +
 arch/powerpc/include/asm/rtas.h                    |    3 +-
 arch/powerpc/include/asm/switch_to.h               |   65 +-
 arch/powerpc/include/asm/synch.h                   |    2 +-
 arch/powerpc/include/asm/time.h                    |    1 -
 arch/powerpc/include/asm/unistd.h                  |    3 +-
 arch/powerpc/include/asm/vdso_datapage.h           |    2 +-
 arch/powerpc/include/uapi/asm/cputable.h           |    2 +
 arch/powerpc/include/uapi/asm/elf.h                |    2 +
 arch/powerpc/kernel/align.c                        |    2 +
 arch/powerpc/kernel/asm-offsets.c                  |   10 +-
 arch/powerpc/kernel/entry_64.S                     |   89 +-
 arch/powerpc/kernel/exceptions-64s.S               |   77 +-
 arch/powerpc/kernel/fpu.S                          |   73 +-
 arch/powerpc/kernel/head_fsl_booke.S               |   42 +-
 arch/powerpc/kernel/idle_power7.S                  |    7 -
 arch/powerpc/kernel/misc_32.S                      |    2 +
 arch/powerpc/kernel/module_64.c                    |   27 +
 arch/powerpc/kernel/ppc_ksyms.c                    |    6 -
 arch/powerpc/kernel/process.c                      |  559 +++++++----
 arch/powerpc/kernel/prom_init.c                    |    1 +
 arch/powerpc/kernel/ptrace.c                       |    1 +
 arch/powerpc/kernel/rtas.c                         |   59 +-
 arch/powerpc/kernel/signal_32.c                    |   36 +-
 arch/powerpc/kernel/signal_64.c                    |   26 +-
 arch/powerpc/kernel/stacktrace.c                   |    7 +
 arch/powerpc/kernel/swsusp.c                       |    4 +-
 arch/powerpc/kernel/systbl_chk.c                   |    2 +-
 arch/powerpc/kernel/systbl_chk.sh                  |    2 +-
 arch/powerpc/kernel/time.c                         |   36 +-
 arch/powerpc/kernel/traps.c                        |    7 -
 arch/powerpc/kernel/vdso.c                         |    2 +-
 arch/powerpc/kernel/vdso32/datapage.S              |    2 +-
 arch/powerpc/kernel/vdso64/datapage.S              |    2 +-
 arch/powerpc/kernel/vector.S                       |  112 +--
 arch/powerpc/kvm/book3s_hv.c                       |    5 +-
 arch/powerpc/kvm/book3s_paired_singles.c           |    1 +
 arch/powerpc/kvm/book3s_pr.c                       |   21 +-
 arch/powerpc/kvm/booke.c                           |    4 +
 arch/powerpc/lib/vmx-helper.c                      |    2 +
 arch/powerpc/lib/xor_vmx.c                         |    4 +
 arch/powerpc/mm/40x_mmu.c                          |   10 +-
 arch/powerpc/mm/Makefile                           |    9 +-
 arch/powerpc/mm/hash64_4k.c                        |  123 +++
 arch/powerpc/mm/hash64_64k.c                       |  322 +++++++
 arch/powerpc/mm/hash_low_64.S                      | 1003 ----------------=
----
 arch/powerpc/mm/hash_native_64.c                   |   10 +
 arch/powerpc/mm/hash_utils_64.c                    |  119 +--
 arch/powerpc/mm/hugepage-hash64.c                  |   22 +-
 arch/powerpc/mm/hugetlbpage-book3e.c               |   46 +
 arch/powerpc/mm/hugetlbpage-hash64.c               |   33 +-
 arch/powerpc/mm/hugetlbpage.c                      |   76 +-
 arch/powerpc/mm/init_64.c                          |    4 -
 arch/powerpc/mm/pgtable.c                          |    4 +
 arch/powerpc/mm/pgtable_64.c                       |   28 +-
 arch/powerpc/mm/slb.c                              |    2 +-
 arch/powerpc/mm/slice.c                            |    3 +-
 arch/powerpc/platforms/83xx/km83xx.c               |    6 +-
 arch/powerpc/platforms/83xx/misc.c                 |    2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    6 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |    6 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |    6 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |    7 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c          |    8 +-
 arch/powerpc/platforms/85xx/common.c               |    3 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |    2 +-
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   15 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |    4 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |    4 +-
 arch/powerpc/platforms/85xx/twr_p102x.c            |    4 +-
 arch/powerpc/platforms/Kconfig                     |   13 +-
 arch/powerpc/platforms/cell/Kconfig                |    5 -
 arch/powerpc/platforms/cell/Makefile               |    4 -
 arch/powerpc/platforms/cell/qpace_setup.c          |  148 ---
 arch/powerpc/platforms/cell/spufs/run.c            |    2 +-
 arch/powerpc/platforms/maple/time.c                |    2 +-
 arch/powerpc/platforms/powermac/bootx_init.c       |    1 +
 arch/powerpc/platforms/powermac/pic.c              |    3 +-
 arch/powerpc/platforms/powernv/Makefile            |    3 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c       |    4 +-
 arch/powerpc/platforms/powernv/idle.c              |    2 +-
 arch/powerpc/platforms/powernv/npu-dma.c           |  348 +++++++
 arch/powerpc/platforms/powernv/opal-kmsg.c         |   75 ++
 arch/powerpc/platforms/powernv/opal-prd.c          |    1 -
 arch/powerpc/platforms/powernv/opal-rtc.c          |    5 +-
 arch/powerpc/platforms/powernv/opal-wrappers.S     |    1 +
 arch/powerpc/platforms/powernv/opal-xscom.c        |    2 +-
 arch/powerpc/platforms/powernv/opal.c              |   41 +-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  216 ++++-
 arch/powerpc/platforms/powernv/pci.c               |    6 +-
 arch/powerpc/platforms/powernv/pci.h               |   19 +
 arch/powerpc/platforms/powernv/setup.c             |   12 +-
 arch/powerpc/platforms/powernv/smp.c               |   74 +-
 arch/powerpc/platforms/pseries/dlpar.c             |  197 +---
 arch/powerpc/platforms/pseries/hotplug-cpu.c       |  550 ++++++++++-
 arch/powerpc/platforms/pseries/lpar.c              |   64 +-
 arch/powerpc/platforms/pseries/pseries.h           |    9 +
 arch/powerpc/platforms/pseries/ras.c               |   55 +-
 arch/powerpc/sysdev/Makefile                       |    1 -
 arch/powerpc/sysdev/axonram.c                      |    1 +
 arch/powerpc/sysdev/cpm_common.c                   |  158 +--
 arch/powerpc/sysdev/fsl_lbc.c                      |    2 -
 arch/powerpc/sysdev/fsl_pci.c                      |   13 +
 arch/powerpc/xmon/xmon.c                           |   18 +-
 drivers/cpufreq/powernv-cpufreq.c                  |    2 +-
 drivers/cpuidle/cpuidle-powernv.c                  |    2 +-
 drivers/crypto/vmx/aes.c                           |    6 +-
 drivers/crypto/vmx/aes_cbc.c                       |    6 +-
 drivers/crypto/vmx/aes_ctr.c                       |    6 +-
 drivers/crypto/vmx/ghash.c                         |   12 +-
 drivers/macintosh/rack-meter.c                     |    1 +
 drivers/macintosh/via-pmu.c                        |    5 +-
 drivers/misc/cxl/Makefile                          |    3 +-
 drivers/misc/cxl/api.c                             |    6 +-
 drivers/misc/cxl/context.c                         |   15 +-
 drivers/misc/cxl/cxl.h                             |   15 +
 drivers/misc/cxl/fault.c                           |  129 ++-
 drivers/misc/cxl/file.c                            |   25 +-
 drivers/misc/cxl/pci.c                             |    1 +
 drivers/misc/cxl/vphb.c                            |    2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |    2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |    8 +-
 drivers/net/ethernet/freescale/ucc_geth.h          |    8 +-
 drivers/rtc/rtc-opal.c                             |    2 +-
 drivers/soc/Kconfig                                |    1 +
 drivers/soc/Makefile                               |    1 +
 drivers/soc/fsl/Makefile                           |    6 +
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/Kconfig   |   11 +
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/Makefile  |    4 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/gpio.c    |    2 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe.c      |   17 +-
 drivers/soc/fsl/qe/qe_common.c                     |  235 +++++
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_ic.c   |    5 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_ic.h   |    4 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_io.c   |    2 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/ucc.c     |    6 +-
 .../qe_lib =3D> drivers/soc/fsl/qe}/ucc_fast.c       |    8 +-
 .../qe_lib =3D> drivers/soc/fsl/qe}/ucc_slow.c       |    8 +-
 .../sysdev/qe_lib =3D> drivers/soc/fsl/qe}/usb.c     |    4 +-
 drivers/spi/spi-fsl-cpm.c                          |    2 +-
 drivers/tty/serial/ucc_uart.c                      |    2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |    2 +-
 drivers/usb/host/fhci-hcd.c                        |    2 +-
 drivers/usb/host/fhci-hub.c                        |    2 +-
 drivers/usb/host/fhci-sched.c                      |    2 +-
 drivers/usb/host/fhci.h                            |    4 +-
 include/linux/genalloc.h                           |   38 +-
 .../include/asm =3D> include/soc/fsl/qe}/immap_qe.h  |    0
 .../include/asm =3D> include/soc/fsl/qe}/qe.h        |   52 +-
 .../include/asm =3D> include/soc/fsl/qe}/qe_ic.h     |    0
 .../include/asm =3D> include/soc/fsl/qe}/ucc.h       |    4 +-
 .../include/asm =3D> include/soc/fsl/qe}/ucc_fast.h  |    6 +-
 .../include/asm =3D> include/soc/fsl/qe}/ucc_slow.h  |    6 +-
 lib/genalloc.c                                     |   93 +-
 lib/raid6/altivec.uc                               |    1 +
 scripts/recordmcount.pl                            |    3 +-
 .../selftests/powerpc/benchmarks/.gitignore        |    1 +
 .../testing/selftests/powerpc/benchmarks/Makefile  |    5 +-
 .../selftests/powerpc/benchmarks/context_switch.c  |  466 +++++++++
 .../powerpc/dscr/dscr_inherit_exec_test.c          |    8 -
 .../selftests/powerpc/dscr/dscr_inherit_test.c     |    8 -
 tools/testing/selftests/powerpc/harness.c          |   43 -
 tools/testing/selftests/powerpc/pmu/Makefile       |    4 +-
 tools/testing/selftests/powerpc/pmu/ebb/Makefile   |    3 +-
 tools/testing/selftests/powerpc/pmu/ebb/ebb.c      |    3 +-
 tools/testing/selftests/powerpc/pmu/lib.c          |   26 -
 tools/testing/selftests/powerpc/pmu/lib.h          |    1 -
 tools/testing/selftests/powerpc/scripts/hmi.sh     |   89 ++
 tools/testing/selftests/powerpc/tm/.gitignore      |    3 +
 tools/testing/selftests/powerpc/tm/Makefile        |    4 +-
 .../testing/selftests/powerpc/tm/tm-resched-dscr.c |    3 +
 .../selftests/powerpc/tm/tm-signal-msr-resv.c      |   74 ++
 .../testing/selftests/powerpc/tm/tm-signal-stack.c |   76 ++
 tools/testing/selftests/powerpc/tm/tm-syscall.c    |   13 +-
 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c    |  103 ++
 tools/testing/selftests/powerpc/tm/tm.h            |   34 +
 tools/testing/selftests/powerpc/utils.c            |   87 ++
 tools/testing/selftests/powerpc/utils.h            |    7 +
 251 files changed, 6859 insertions(+), 3853 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/qoriq-thermal=
.txt
 rename arch/powerpc/include/asm/{pte-hash32.h =3D> book3s/32/hash.h} (93%)
 create mode 100644 arch/powerpc/include/asm/book3s/32/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash-4k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash-64k.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/hash.h
 create mode 100644 arch/powerpc/include/asm/book3s/64/pgtable.h
 create mode 100644 arch/powerpc/include/asm/book3s/pgtable.h
 rename arch/powerpc/include/asm/{pgtable-ppc32.h =3D> nohash/32/pgtable.h}=
 (96%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/pte-40x.h (95%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/pte-44x.h (96%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/pte-8xx.h (95%)
 rename arch/powerpc/include/asm/{ =3D> nohash/32}/pte-fsl-booke.h (88%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h =3D> nohash/64/pgtable=
-4k.h} (92%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h =3D> nohash/64/pgtabl=
e-64k.h} (64%)
 rename arch/powerpc/include/asm/{pgtable-ppc64.h =3D> nohash/64/pgtable.h}=
 (51%)
 create mode 100644 arch/powerpc/include/asm/nohash/pgtable.h
 rename arch/powerpc/include/asm/{ =3D> nohash}/pte-book3e.h (95%)
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-4k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64-64k.h
 delete mode 100644 arch/powerpc/include/asm/pte-hash64.h
 create mode 100644 arch/powerpc/mm/hash64_4k.c
 create mode 100644 arch/powerpc/mm/hash64_64k.c
 delete mode 100644 arch/powerpc/mm/hash_low_64.S
 delete mode 100644 arch/powerpc/platforms/cell/qpace_setup.c
 create mode 100644 arch/powerpc/platforms/powernv/npu-dma.c
 create mode 100644 arch/powerpc/platforms/powernv/opal-kmsg.c
 create mode 100644 drivers/soc/fsl/Makefile
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/Kconfig (54%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/Makefile (69%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/gpio.c (99%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe.c (98%)
 create mode 100644 drivers/soc/fsl/qe/qe_common.c
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_ic.c (99%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_ic.h (97%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/qe_io.c (99%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/ucc.c (98%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/ucc_fast.c (98=
%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/ucc_slow.c (98=
%)
 rename {arch/powerpc/sysdev/qe_lib =3D> drivers/soc/fsl/qe}/usb.c (96%)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/immap_qe.h (100%=
)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/qe.h (95%)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/qe_ic.h (100%)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/ucc.h (96%)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/ucc_fast.h (98%)
 rename {arch/powerpc/include/asm =3D> include/soc/fsl/qe}/ucc_slow.h (99%)
 create mode 100644 tools/testing/selftests/powerpc/benchmarks/context_swit=
ch.c
 create mode 100755 tools/testing/selftests/powerpc/scripts/hmi.sh
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-stack.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-vmxcopy.c
 create mode 100644 tools/testing/selftests/powerpc/tm/tm.h
 create mode 100644 tools/testing/selftests/powerpc/utils.c

--=-WJbcH+fj++FxWxD7fWEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAABAgAGBQJWmMb+AAoJEFHr6jzI4aWAf2IP/RU3jFEexEI0JQlbg2hRK1TS
/6xwgPj740YayYNqjgjW+iKHZa5rJEgpVI4F5MvpgNgID33GQDAlEkeGm6eDReT5
uG5HxqxMhCZFX3paX7xDiPxnbEO7Zp5WrGzCNRKJW8dRND4THJFPrsS6IfGQpsye
wqYH9Z5G+Jm6fb0VS/cCfn57dcWcurrcD7ZIlfk/WwVXq47c4/UnrqcDP9PEylAR
RMGAB0MXpKdc4+Vz8f4dfSnBkdg3xFK8dA31nnMvyS2nh5ZFlIRcquH9iBy/X4I3
7vYpSBQUupnwufIyFY95rtpByYdGNGrI2bR7XFjZnHlD97ZayDv4rTvTnf6b69CE
b0kNtSH/18sQHxoOLY8M9QCOd16zSFG4oajZX4coPHnAV2+Ol3zZ8ntLmJPsO5Fc
qeegOcThng4STykaihv9OJ9Aa5J90w1A5Kf7j+lP6LqBunNeeUFXgb3oXlqTisGd
U0oiI08/GVmarRGsEO7fLARx80cwkI7mdyBEM1g5qsachvs1vh3agh7uBxdT38l8
2bhvKoLju3KReXNsOOV869lqCmRcIRhdb4orJ5ebXnfawqbf7VFcRXFNkNzH+/1M
VBw3uZqoN0VQCa5JWm+sYlifNVtxfAF2cLBmKKdtPLGSuk3aRnaLwkGd6N/QkUs2
pho37UgczDUFYD7VRnuR
=tCwr
-----END PGP SIGNATURE-----

--=-WJbcH+fj++FxWxD7fWEp--
