Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18537.30774.608486.268257@cargo.ozlabs.ibm.com>
Date: Tue, 1 Jul 2008 10:20:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits added to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following commits have been added to the master and powerpc-next
branches of the powerpc.git repository.  This includes patches pulled
from Kumar's and Josh's trees.

Paul.

Adrian Bunk (3):
      drivers/macintosh: Various cleanups
      powerpc: Don't export asm/asm-compat.h to userspace
      powerpc: asm/elf.h: Reduce userspace header

Andrew Lewis (1):
      powerpc: Prevent memory corruption due to cache invalidation of unaligned DMA buffer

Andy Whitcroft (1):
      powerpc: Add 64 bit version of huge_ptep_set_wrprotect

Anton Vorontsov (9):
      powerpc/sysdev: implement FSL GTM support
      powerpc/QE: add support for QE USB clocks routing
      powerpc/QE: prepare QE PIO code for GPIO LIB support
      powerpc/QE: implement support for the GPIO LIB API
      powerpc/83xx: new board support: MPC8360E-RDK
      powerpc/QE: switch to the cpm_muram implementation
      powerpc/QE: qe_reset should be __init
      powerpc/QE: use arch_initcall to probe QUICC Engine GPIOs
      powerpc: Implement OF PCI address accessors stubs for CONFIG_PCI=n

Arnd Bergmann (4):
      powerpc: Provide dummy crash_shutdown_register
      powerpc/pseries: Call pseries_kexec_setup only on pseries
      powerpc/cell: Disable ptcal in case of crash kdump
      powerpc: Increase CRASH_HANDLER_MAX

Bart Van Assche (1):
      powerpc: Make sure that include/asm-powerpc/spinlock.h does not trigger compilation warnings

Becky Bruce (3):
      powerpc: Silly spelling fix in pgtable-ppc32
      powerpc: Change BAT code to use phys_addr_t
      powerpc: Get rid of bitfields in ppc_bat struct

Benjamin Herrenschmidt (1):
      powerpc: Free a PTE bit on ppc64 with 64K pages

Bernhard Walle (1):
      powerpc: Remove experimental status of kdump on 64-bit powerpc

Daniel Walker (2):
      macintosh/therm_windtunnel: Convert semaphore to mutex
      macintosh/media bay: Convert semaphore to mutex

Dave Kleikamp (1):
      powerpc: hash_huge_page() should get the WIMG bits from the lpte

Giuseppe Coviello (2):
      powerpc/4xx: Sam440ep support
      powerpc/4xx: Convert Sam440ep DTS to dts-v1

Imre Kaloz (1):
      powerpc/4xx: MTD support for the AMCC Taishan Board

Jerone Young (1):
      powerpc/booke: Fix definitions for dbcr[1-2] and dbsr registers

Joel Schopp (2):
      powerpc: Add cputable entry for Power7 architected mode
      powerpc: Tell firmware we support architecture V2.06

Josh Boyer (2):
      Revert "[POWERPC] 4xx: Fix 460GT support to not enable FPU"
      powerpc/4xx: Workaround for PPC440EPx/GRx PCI_28 Errata

Julia Lawall (1):
      drivers/macintosh/smu.c: Improve error handling

Kumar Gala (12):
      powerpc/booke: Fix some comments related to debug level exceptions
      powerpc/booke: Add support for new e500mc core
      powerpc/85xx: add DOZE/NAP support for e500 core
      powerpc/e500mc: flush L2 on NAP for e500mc
      cpm_uart: fix whitespace issues
      cpm_uart: Remove !CONFIG_PPC_CPM_NEW_BINDING code
      powerpc/cpm: Remove !CONFIG_PPC_CPM_NEW_BINDING code
      powerpc/kprobes: Some minor fixes
      powerpc/booke: Add kprobes support for booke style processors
      powerpc: Add dma nodes to 83xx, 85xx and 86xx boards
      powerpc: Move common module code into its own file
      powerpc/bootwrapper: Pad .dtb by default

Michael Ellerman (14):
      powerpc: Move code patching code into arch/powerpc/lib/code-patching.c
      powerpc: Allow create_branch() to return errors
      powerpc: Make create_branch() return errors if the branch target is too large
      powerpc: Add ppc_function_entry() which gets the entry point for a function
      powerpc: Add new code patching routines
      powerpc: Add tests of the code patching routines
      powerpc: Add PPC_NOP_INSTR, a hash define for the preferred nop instruction
      powerpc: Split out do_feature_fixups() from cputable.c
      powerpc: Consolidate CPU and firmware feature fixup macros
      powerpc: Consolidate feature fixup macros for 64/32 bit
      powerpc: Introduce infrastructure for feature sections with alternatives
      powerpc: Add logic to patch alternative feature sections
      powerpc: Add self-tests of the feature fixup code
      powerpc: Use an alternative feature section in entry_64.S

Michael Neuling (10):
      powerpc: Add cputable entry for POWER7
      powerpc: Fix MSR setting in 32 bit signal code
      powerpc: Add macros to access floating point registers in thread_struct.
      powerpc: Move altivec_unavailable
      powerpc: Make load_up_fpu and load_up_altivec callable
      powerpc: Introduce VSX thread_struct and CONFIG_VSX
      powerpc: Add VSX CPU feature
      powerpc: Add VSX assembler code macros
      powerpc: Add VSX context save/restore, ptrace and signal support
      powerpc: Add CONFIG_VSX config option

Nick Piggin (2):
      powerpc: Optimise smp_wmb on 64-bit processors
      spufs: Convert nopfn to fault

Paul Mackerras (1):
      powerpc: Only demote individual slices rather than whole process

Scott Wood (1):
      powerpc: Fix copy-and-paste error in clrsetbits_le16

Segher Boessenkool (1):
      powerpc: Get rid of CROSS32{AS,LD,OBJCOPY}

Stefan Roese (1):
      powerpc/4xx: PCIe driver now detects if a port is disabled via the dev-tree

Stephen Rothwell (7):
      viotape: Use unlocked_ioctl
      pasemi-rng: Use linux/of_platform.h instead of asm
      hwmon: Use linux/of_platform.h instead of asm
      macintosh: Use linux/of_{device,platform}.h instead of asm
      drivers/net: Use linux/of_{device,platform}.h instead of asm
      pcmcia: Use linux/of_{device,platform}.h instead of asm
      powerpc: Explicitly copy elements of pt_regs

Tony Breeds (1):
      powerpc: Change the default link address for pSeries zImage kernels

Valentine Barshak (1):
      powerpc/4xx: Fix resource issue in warp-nand.c

Vitaly Bordug (1):
      powerpc/85xx: Update pin setup for 8560ads

Wolfgang Grandegger (4):
      powerpc/85xx: correct vendor prefix in DTS files for TQM85xx modules
      powerpc/85xx: add board support for the TQM8548 modules
      powerpc/85xx: support for the TQM8548 module using the big Flash
      powerpc/85xx: add local bus nodes for Flash and CAN to tqm8560.dts
