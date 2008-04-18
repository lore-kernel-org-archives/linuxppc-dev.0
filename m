Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
Date: Fri, 18 Apr 2008 21:38:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have pushed out the following commits to the master and powerpc-next
branches of the powerpc.git tree.  This includes commits from Kumar's
and Jeremy's trees.

I am intending to ask Linus to pull the powerpc-next branch once we
have the breakage from the OF helpers for i2c patch sorted out.

Paul.

Alexander van Heukelum (1):
      [POWERPC] Use asm-generic/bitops/find.h in bitops.h

Anton Vorontsov (9):
      [POWERPC] QE: UCC nodes cleanup
      [POWERPC] fsl_elbc_nand: factor out localbus defines
      [POWERPC] fsl_lbc: implement few UPM routines
      [POWERPC] QE: implement qe_muram_offset
      [POWERPC] QE: immap_qe.h should include asm/io.h
      [POWERPC] QE: export qe_get_brg_clk()
      [POWERPC] QE: fix sparse warnings
      [POWERPC] 83xx: mpc837x_rdb: add simple-bus compatible matching
      [POWERPC] 83xx: mpc8315 - fix USB UTMI Host setup

Benjamin Herrenschmidt (3):
      [POWERPC] Fix device-tree locking vs. interrupts
      [POWERPC] Move stackframe definitions to common header
      [POWERPC] irqtrace support for 64-bit powerpc

Christoph Hellwig (1):
      [POWERPC] Stacktrace support for lockdep

Gerhard Stenzel (1):
      [POWERPC] spufs: fix incorrect file descriptors in SPU coredump note names

Haiying Wang (1):
      [POWERPC] 85xx: Fix the size of qe muram for MPC8568E

Jeremy Kerr (3):
      [POWERPC] spufs: add newline to signal{1,2}_type files
      [POWERPC] spufs: reacquire LS pointer in spu_process_callback
      [POWERPC] spufs: save MFC command channel before purging MFC queue

Kumar Gala (8):
      [POWERPC] Rework Book-E debug exception handling
      [POWERPC] 83xx/85xx: Reorganize defconfigs
      [POWERPC] Make Book-E debug handling SMP safe
      [POWERPC] 83xx: Enable FCM NAND and OF partitions in defconfig
      [POWERPC] 85xx: Fix compile warning
      [POWERPC] 85xx: Convert dts to v1 syntax
      [POWERPC] 85xx: minor .dts cleanups
      [POWERPC] fsl: Convert dts to v1 syntax

Laurent Pinchart (6):
      [POWERPC] cpm_uart: Allocate DPRAM memory for SMC ports on CPM2-based platforms.
      [POWERPC] Add bootwrapper function to get virtual reg from the device tree.
      [POWERPC] cpm-serial: Relocate CPM buffer descriptors and SMC parameter ram.
      [POWERPC] ep8248e: Reference SMC parameter RAM base in the device tree.
      [POWERPC] CPM2: Reset the CPM when early debugging is not enabled.
      [POWERPC] CPM: Move opcodes common to CPM1 and CPM2 to include/asm-powerpc/cpm.h

Michael Ellerman (4):
      [POWERPC] Move xics_setup_8259_cascade() into platforms/pseries/setup.c
      [POWERPC] Turn xics_setup_8259_cascade() into a generic pseries_setup_i8259_cascade()
      [POWERPC] Use pseries_setup_i8259_cascade() in pseries_mpic_init_IRQ()
      [POWERPC] Simplify xics direct/lpar irq_host setup

Olof Johansson (1):
      [POWERPC] Remove unused __max_memory variable

Paul Gortmaker (5):
      [POWERPC] 86xx: Add support for Wind River SBC8641D board
      [POWERPC] 86xx: Add defconfig for Wind River SBC8641D board
      [POWERPC] 86xx: Add device tree source for Wind River SBC8641D
      [POWERPC] 86xx: mark functions static, other minor cleanups
      [POWERPC] 86xx: mpc86xx_hpcn - Temporarily accept old dts node identifier.

Paul Mackerras (1):
      [POWERPC] Optimize fls64() on 64-bit processors

Scott Wood (4):
      [POWERPC] CPM: Always use new binding.
      [POWERPC] fsl_soc: Factor fsl_get_sys_freq() out of the wdt and spi inits.
      [POWERPC] cuboot-pq2: PCI fixes
      [POWERPC] 83xx: mpc8313erdb - Enable FCM NAND and OF partitions in defconfig

Sebastian Siewior (1):
      [POWERPC] 85xx: Enable DMA engine on the MPC8544 DS

Timur Tabi (1):
      [POWERPC] Make rheap safe for spinlocks

Trent Piepho (1):
      [POWERPC] Make pci_bus_to_host()'s struct pci_bus * argument const
