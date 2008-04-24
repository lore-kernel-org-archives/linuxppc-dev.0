Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18448.30941.453828.473019@cargo.ozlabs.ibm.com>
Date: Thu, 24 Apr 2008 22:11:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches pushed to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have put the following patches in the powerpc.git repository on the
master & powerpc-next branches (this includes some pulled from Kumar's
tree).  I plan to send a pull request to Linus tomorrow morning my
time, so if there are any others I've missed, or any that people don't
think should go in, let me know within the next 9 hours or so.

Paul.

Adrian Bunk (2):
      [POWERPC] drivers/of/of_i2c.c: Add MODULE_LICENSE
      [POWERPC] char/xilinx_hwicap/ section fix

Benjamin Herrenschmidt (3):
      [POWERPC] Add thread_info_cache_init() weak hook
      [POWERPC] Fix kernel stack allocation alignment
      [POWERPC] Use __weak macro for smp_setup_processor_id

Christoph Hellwig (1):
      [POWERPC] Fix new warnings arising from stacktrace patch

Geoff Levand (1):
      [POWERPC] PS3: Fix gelic net module dependency

Ishizaki Kou (9):
      [POWERPC] cell: Generalize io-workarounds code
      [POWERPC] celleb: Consolidate io-workarounds code
      [POWERPC] celleb: Move the files for celleb base support
      [POWERPC] celleb: Move the SCC related code for celleb
      [POWERPC] celleb: Move files for Beat hvcall interfaces
      [POWERPC] celleb: Move files for Beat mmu and iommu
      [POWERPC] celleb: Move a file for SPU on Beat
      [POWERPC] celleb: Move miscellaneous files for Beat
      [POWERPC] celleb: Add support for PCI Express

Josh Boyer (2):
      [POWERPC] 4xx: Fix duplicate phys_addr_t definition
      [POWERPC] Add strncmp to arch/ppc

Kay Sievers (1):
      [POWERPC] macintosh/windfarm: Fix platform driver hotplug/coldplug

Kumar Gala (8):
      [PPC] Remove mpc8272 ads board from arch/ppc
      [PPC] Remove mpc885ads and mpc86x ads boards from arch/ppc
      [POWERPC] ppc32: Fix errata for 603 CPUs
      [POWERPC] 85xx: Add support for relocatable kernel (and booting at non-zero)
      [POWERPC] Port fixmap from x86 and use for kmap_atomic
      [POWERPC] Clean up access to thread_info in assembly
      [POWERPC] Cleanup asm-offsets.c
      [POWERPC] Clean up misc_64.S

Michael Ellerman (9):
      [POWERPC] Add include of linux/of.h to numa.c
      [POWERPC] Add include of linux/of.h to os-area.c
      [POWERPC] Discourage people from fiddling with kernel data from prom_init
      [POWERPC] Use of_get_next_parent() in platforms/cell/axon_msi.c
      [POWERPC] Set udbg_console index to 0
      [POWERPC] Mark udbg console as CON_ANYTIME, ie. callable early in boot
      [POWERPC] Register udbg console early on pseries LPAR
      [POWERPC] Convert from DBG() to pr_debug() in platforms/pseries/
      [POWERPC] Add CONFIG_PPC_PSERIES_DEBUG to enable debugging for platforms/pseries

Paul Mackerras (1):
      Revert "[POWERPC] Add compat handler for PTRACE_GETSIGINFO"

Remi Machet (3):
      [POWERPC] Use default values if necessary in mv64x60 I2C initialization
      [POWERPC] Initialize all mv64x60 devices even if one fails
      [POWERPC] Fix mv64x60 early console code to use cell-index property

Timur Tabi (1):
      [POWERPC] Add Timur Tabi to the MAINTAINERS file

Tony Breeds (2):
      [POWERPC] Make iSeries spin on __secondary_hold_spinloop, like pSeries
      [POWERPC] Raise the upper limit of NR_CPUS and move the pacas into the BSS
