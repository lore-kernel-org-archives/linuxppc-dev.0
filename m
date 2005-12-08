Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17303.53564.160668.376061@cargo.ozlabs.ibm.com>
Date: Thu, 8 Dec 2005 17:22:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc64-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: patches in powerpc.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is a list of patches currently in the powerpc.git tree that
aren't already in Linus' tree.

Paul.

Adrian Bunk:
      PPC_PREP: remove unneeded exports

Andy Whitcroft:
      powerpc: powermac adb fix dependency on btext_drawchar
      powerpc: powermac adb fix udbg_adb_use_btext warning
      powerpc32: clean up available memory models
      powerpc32: fix definition of distribute_irqs

Arnd Bergmann:
      spufs: The SPU file system, base
      spufs: cooperative scheduler support
      spufs: Make all exports GPL-only
      spufs: fix local store page refcounting
      spufs: Fix oops when spufs module is not loaded
      spufs: Turn off debugging output
      spufs: Improved SPU preemptability.
      spufs: Improved SPU preemptability [part 2].
      spufs: fix mailbox polling
      cell: add platform detection code

Benjamin Herrenschmidt:
      powerpc: Merge align.c (#2)
      powerpc: Add OF address parsing code (#2)
      powerpc: serial port discovery (#2)
      powerpc: Unify udbg (#2)
      powerpc: Add back support for booting from BootX (#2)
      powerpc: convert macio_asic to use prom_parse
      powerpc: Fix g5 build with xmon
      powerpc: More serial probe fixes (#2)
      powerpc: udbg updates
      powerpc: Update OF address parsers
      powerpc: Fix a huge page bug
      powerpc: Remove debug code in hash path

David Gibson:
      powerpc: Remove imalloc.h
      powerpc: Make hugepage mappings respect hint addresses
      is_aligned_hugepage_range() cleanup
      powerpc: Remove ItLpRegSave area from the paca
      powerpc: Remove some unneeded fields from the paca

David Woodhouse:
      syscall entry/exit revamp
      ppc64 syscall_exit_work: call the save_nvgprs function, not its descriptor.
      powerpc: serial port discovery: cope with broken firmware
      Save NVGPRS in 32-bit signal frame
      Fix code that saves NVGPRS in 32-bit signal frame
      ppc: Make ARCH=ppc build again with new syscall path

Heiko J Schick:
      powerpc: IBMEBUS bus support

Hugh Dickins:
      mm: powerpc ptlock comments
      mm: powerpc init_mm without ptlock

Kumar Gala:
      powerpc: moved ipic code to arch/powerpc
      powerpc: Add support for building uImages
      powerpc: Fix suboptimal uImage target

linas:
      powerpc/pseries: dlpar-add crash on null pointer deref
      powerpc: minor cleanup of void ptr deref

Linas Vepstas:
      powerpc: PCI hotplug common code elimination
      powerpc: make pcibios_claim_one_bus available to other code
      powerpc: migrate common PCI hotplug code
      PCI Error Recovery: header file patch
      powerpc: PCI Error Recovery: PPC64 core recovery routines
      powerpc: Split out PCI address cache to its own file
      powerpc: Add "partitionable endpoint" support
      powerpc: remove bogus printk
      powerpc: Remove duplicate code
      powerpc: bugfix: fill in uninitialized field
      powerpc: Use PE configuration address consistently
      powerpc: set up the RTAS token just like the rest of them.
      powerpc: Don't continue with PCI Error recovery if slot reset failed.
      powerpc: handle multifunction PCI devices properly
      powerpc: IOMMU: don't ioremap null addresses
      powerpc: Save device BARs much earlier in the boot sequence
      powerpc: get rid of per_cpu EEH counters

Marcelo Tosatti:
      ppc32: m8xx watchdog update
      powerpc/8xx: Fix m8xx_wdt issues

Mark Nutter:
      spufs: switchable spu contexts
      kernel-side context switch code for spufs
      spufs: add spu-side context switch code

Michael Ellerman:
      powerpc: Merge kexec
      powerpc: Propagate regs through to machine_crash_shutdown
      powerpc: Add a is_kernel_addr() macro
      powerpc: Separate usage of KERNELBASE and PAGE_OFFSET
      powerpc: Add CONFIG_CRASH_DUMP
      powerpc: Create a trampoline for the fwnmi vectors
      powerpc: Reroute interrupts from 0 + offset to PHYSICAL_START + offset
      powerpc: Fixups for kernel linked at 32 MB
      powerpc: Add arch dependent basic infrastructure for Kdump.
      powerpc: Parse crashkernel= parameter in first kernel
      powerpc: Add arch-dependent copy_oldmem_page
      powerpc: Add support for "linux,usable-memory" on memory nodes

Michal Ostrowski:
      powerpc/pseries: Fix TCE building with 64k pagesize

Mike Kravetz:
      Remove SPAN_OTHER_NODES config definition
      powerpc: Minor numa memory code cleanup
      powerpc: Minor numa memory code cleanup
      powerpc: numa placement for dynamically added memory
      powerpc/pseries: boot failures on numa if no memory on node

Olaf Hering:
      powerpc: correct the NR_CPUS description text

Olof Johansson:
      powerpc: remove redundant code in stab init

Otavio Salvador:
      ppc: removed unused variable i from code.

Paul Mackerras:
      powerpc: Update __NR_syscalls to account for SPU syscalls
      ppc: remove duplicate bseip.h
      powerpc: Fix up some compile errors in the PCI error recovery code
      powerpc/pseries: Optimize IOMMU setup
      ppc: Build in all three of powermac, PREP and CHRP support
      Revert "powerpc: Minor numa memory code cleanup"
      powerpc: Fix typo in head_64.S

Stephen Rothwell:
      powerpc: remove arch/powerpc/include hack for 64 bit
      powerpc: cleanup iseries irq.c
      powerpc: use end_IRQ for iseries irqs
      powerpc: partly merge iseries do_IRQ
      powerpc: reduce include in irq.c
      powerpc: more iseries irq work
      powerpc: fix for "Update OF address parsers"
