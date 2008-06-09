Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18509.7300.937733.860323@cargo.ozlabs.ibm.com>
Date: Mon, 9 Jun 2008 22:05:24 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: More commits added to powerpc.git powerpc-next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here is the list of commits that have been added to the powerpc-next
and master branches of the powerpc.git repository since the last such
message from me.  It includes the much-acked removal of arch/ppc and
include/asm-ppc, commits pulled from Josh Boyer's tree and Kumar
Gala's tree, plus various other things.  Sharp-eyed readers will
notice that I have started using the "powerpc:" prefix as promised.

Paul.

Anton Vorontsov (2):
      [POWERPC] fsl_msi: few (mostly cosmetic) fixes
      powerpc/mpic: Fix ambiguous else statement

Benjamin Herrenschmidt (1):
      powerpc: Free a PTE bit on ppc64 with 64K pages

Bryan O'Donoghue (1):
      [POWERPC] 83xx: Add support for Analogue & Micro ASP837E board

David Gibson (1):
      [POWERPC] Convert remaining dts-v0 files to v1

Emil Medve (1):
      powerpc: Add the PC speaker only when requested

Jason Jin (4):
      [POWERPC] Update booting-without-of for Freescale PCIe MSI
      [POWERPC] fsl: PCIe MSI support for 83xx/85xx/86xx processors.
      [POWERPC] 86xx: Enable MSI support for MPC8610HPCD board
      [POWERPC] 85xx: Enable MSI support for 85xxds board

Josh Boyer (2):
      [POWERPC] 4xx: Fix PCI mem in rainier DTS
      [POWERPC] 4xx: Fix compiler warning on DCR_NATIVE only builds

Kumar Gala (5):
      [POWERPC] Cleanup mpic nodes in .dts
      [POWERPC] 85xx: Add next-level-cache property
      [POWERPC] Move to runtime allocated exception stacks
      [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
      [POWERPC] 40x/Book-E: Save/restore volatile exception registers

Michael Ellerman (4):
      powerpc: Rework Axon MSI setup so we can avoid freeing the irq_host
      powerpc: Rework ipic_init() so we can avoid freeing the irq_host
      powerpc: Rework qe_ic_init() so we can avoid freeing the irq_host
      powerpc: Fix irq_alloc_host() reference counting and callers

Paul Mackerras (2):
      powerpc: Remove arch/ppc and include/asm-ppc

Remi Machet (5):
      powerpc: DTS file for the C2K
      powerpc: Boot code for the C2K
      powerpc: C2K board driver
      powerpc: Default configuration for C2K
      powerpc: Add C2K to configuration

Rune Torgersen (1):
      powerpc: Check that TASK_SIZE does not overlap KERNEL_START

Sean MacLennan (2):
      [POWERPC] PIKA Warp: Update DTS to support Rev B boards
      [POWERPC] PIKA Warp: Update platform code to support Rev B boards

Stephen Neuendorffer (1):
      [POWERPC] Refactor DCR code

Stephen Rothwell (2):
      of_serial: Use linux/of_platform.h instead of asm
      platinumfb: Use linux/of_{device,platform}.h instead of asm

Timur Tabi (3):
      [POWERPC] fsl: Add warning for unrecognized I2C nodes in the device tree
      [POWERPC] fsl: Add CS4270 i2c data to fsl_soc.c
      [POWERPC] fsl: Update fsl_soc to use cell-index property of I2C nodes

Trent Piepho (1):
      powerpc: Improve (in|out)_[bl]eXX() asm code
