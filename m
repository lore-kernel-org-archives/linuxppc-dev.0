Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB18CDDFEA
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 17:26:09 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n4L7Q0DP001093
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 02:26:01 -0500
Subject: next branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 21 May 2009 17:26:00 +1000
Message-Id: <1242890760.5109.1.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I updated my "next" branch with the following patches. If something
older than a week old is missing (and not already delegated to a
maintainer on patchwork) please let me know.

Anton Blanchard (1):
      powerpc: Improve decrementer accuracy

Anton Vorontsov (6):
      powerpc/85xx: Add PCI IDs for MPC8569 family processors
      powerpc/85xx: Fix mpc8569emds crypto node to include SNOW unit
      powerpc/85xx: Fix reg & interrupts for mpc8569emds localbus added NAND
      powerpc/85xx: Add eSDHC support for MPC8569E-MDS boards
      powerpc/85xx: Enable Serial RapidIO for MPC85xx MDS boards
      powerpc/85xx: Add STMicro M25P40 serial flash support for MPC8569E-MDS

Becky Bruce (3):
      powerpc/86xx: Add 36-bit device tree for mpc8641hpcn
      powerpc: make dma_window_* in pci_controller struct avail on 32b
      powerpc: Use sg->dma_length in sg_dma_len() macro on 32-bit

Geert Uytterhoeven (1):
      powerpc: Keep track of emulated instructions

Geoff Levand (1):
      powerpc/ps3: Use smp_request_message_ipi

Haiying Wang (7):
      powerpc/85xx: clean up for mpc8568_mds name
      powerpc/qe: update risc allocation for QE
      net/ucc_geth: update riscTx and riscRx in ucc_geth
      powerpc/qe: update QE Serial Number
      net/ucc_geth: Assign six threads to Rx for UEC
      powerpc/85xx: Add MPC8569MDS board support
      powerpc/qe: add new qe properties for QE based chips

Jan Blunck (1):
      powerpc/spufs: Remove double check for non-negative dentry

Kumar Gala (32):
      powerpc/fsl: Remove cell-index from PCI nodes
      powerpc: Refactor board check for PCI quirks on FSL boards with uli1575
      powerpc/fsl: use of_iomap() for rstcr mapping
      powerpc/85xx: Add binding for LAWs and ECM
      powerpc/85xx: Add new LAW & ECM device tree nodes for all 85xx systems
      powerpc/86xx: Add binding for LAWs and MCM
      powerpc/86xx: Add new LAW & MCM device tree nodes for all 86xx systems
      powerpc/cpm: Remove some cruft code and defines
      powerpc/86xx: clean up smp init code
      powerpc/fsl: Removed reg property from 85xx/86xx soc node
      fsldma: Fix compile warnings
      powerpc/85xx: Add MSI nodes for MPC8568/9 MDS systems
      powerpc/fsl: Support unique MSI addresses per PCIe Root Complex
      powerpc/8xxx: Update PCI outbound window addresses for 36-bit configs
      powerpc/fsl_rio: Fix compile warnings
      powerpc/fsl: Update FSL esdhc binding
      powerpc/85xx: Add P2020DS board support
      powerpc/fsl: Setup PCI inbound window based on actual amount of memory
      powerpc: Fix up elf_read_implies_exec() usage
      powerpc/pci: Clean up direct access to sysdata by indirect ops
      powerpc/pci: Clean up direct access to sysdata by FSL platforms
      powerpc/pci: Clean up direct access to sysdata by 52xx platforms
      powerpc/pci: Clean up direct access to sysdata by 4xx platforms
      powerpc/pci: Clean up direct access to sysdata by CHRP platforms
      powerpc/pci: Clean up direct access to sysdata on tsi108 platforms
      powerpc/pci: Clean up direct access to sysdata by powermac platforms
      powerpc/pci: Clean up direct access to sysdata by RTAS
      powerpc/pci: Clean up direct access to sysdata by celleb platforms
      powerpc/pci: Move pseries code into pseries platform specific area
      powerpc/pci: Cleanup some minor cruft
      powerpc/pci: Remove redundant pcnet32 fixup
      powerpc/pci: clean up direct access to sysdata by iseries platform

Li Yang (2):
      powerpc/fsl_rio: use LAW address from device tree
      rapidio: fix section mismatch warnings

Michael Ellerman (7):
      powerpc/oprofile: Remove unused dump_pmcs() in FSL oprofile
      powerpc/irq: Move #ifdef'ed body of do_IRQ() into a separate function
      powerpc/irq: Move stack overflow check into a separate function
      powerpc/irq: Move get_irq() comment into header
      powerpc/irq: Remove fallback to __do_IRQ()
      powerpc/powermac: Use generic_handle_irq() in gatwick_action()
      powerpc/irq: We don't need __do_IRQ() anymore

Michael Neuling (2):
      powerpc: Cleanup macros in ppc-opcode.h
      powerpc: Move VSX load/stores into ppc-opcode.h

Milton Miller (2):
      powerpc: Enable MMU feature sections for inline asm
      powerpc: Add 2.06 tlbie mnemonics

Robert Jennings (1):
      powerpc/pseries: CMO unused page hinting

Sean MacLennan (1):
      powerpc: Update Warp to use leds-gpio driver

Tony Breeds (1):
      powerpc/mpic: Cleanup mpic_find() implementation

Vinay Sridhar (1):
      powerpc/xmon: Add dl command to dump contents of __log_buf
