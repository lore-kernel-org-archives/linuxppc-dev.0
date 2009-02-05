Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10D28DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 16:37:11 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n155b50j006601
	for <linuxppc-dev@ozlabs.org>; Wed, 4 Feb 2009 23:37:05 -0600
Subject: Commits pushed to test branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 16:37:04 +1100
Message-Id: <1233812224.4612.72.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've pushed these commits to the test branch. This include the next
branches from Kumar and Grant, which I'll move over to my "next" branch
soon, probably tomorrow, if the world doesn't end in the meantime.

The rest is picked up from patchwork, and will trickle up to "next" as I
see fit unless somebody hollers.

People are _MUCH_WELCOME_ to pull that test branch and test it, that's
the whole point of having it, so we can catch problems before their hit
the next branch that we can't rebase.

Further occurences of this announce won't be that verbose, though I
haven't decided on a proper format or subject tag yet :-)

Anton Vorontsov (2):
      powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
      powerpc/83xx: Add PCI-E support for all MPC83xx boards with PCI-E

Benjamin Herrenschmidt (3):
      powerpc: Rework I$/D$ coherency (v2)

Grant Likely (7):
      powerpc/5200: Stop using device_type and port-number properties
      powerpc/5200: Trim cruft from device trees
      powerpc/5200: Don't specify IRQF_SHARED in PSC UART driver
      powerpc/5200: Remove pr_debug() from hot paths in irq driver
      powerpc/5200: Refactor mpc5200 interrupt controller driver
      powerpc/5200: Rework GPT driver to also be an IRQ controller
      powerpc/5200: Add support for the Media5200 board from Freescale

Grzegorz Bernacki (1):
      powerpc/5200: Add support for the digsy MTC board.

Kumar Gala (3):
      powerpc/fsl-booke: Cleanup init/exception setup to be runtime
      powerpc/fsl: Ensure PCI_QUIRKS are enabled for FSL_PCI
      powerpc: Unify asm opcode definitions and support

Laurent Pinchart (1):
      cpm2: Round the baud-rate clock divider to the nearest integer.

Martyn Welch (3):
      powerpc/86xx: Board support for GE Fanuc SBC310
      powerpc/86xx: Default configutation for GE Fanuc's SBC310
      powerpc/86xx: Extend GE Fanuc GPIO driver for the SBC310

Michael Ellerman (7):
      powerpc: Remove unused ppc64_terminate_msg()
      powerpc: Allow debugging of LMBs with lmb=debug
      lmb: Rework lmb_dump_all() output
      powerpc/pseries: Fix MSI-X interrupt querying
      powerpc/pseries: Add support for ibm,req#msi-x
      powerpc/pseries: Check for MSI-X also in rtas_msi_pci_irq_fixup()
      powerpc/pseries: Return the number of MSIs we could allocate

Milton Miller (3):
      powerpc/numa: Avoid possible reference beyond prop. length in find_min_common_depth()
      powerpc/numa: Remove redundant find_cpu_node()
      powerpc/pseries: Remove write only variable in PCI DLPAR

Peter Korsgaard (1):
      powerpc: convert dts-bindings/fsl/dma.txt to dts-v1 syntax

Reynes Philippe (2):
      powerpc/83xx: Add i2c eeprom to dts for MPC837x RDB
      powerpc/83xx: Add gpio to MPC837x RDB

Trent Piepho (3):
      powerpc/fsl-booke: Remove code duplication in lowmem mapping
      powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
      powerpc/fsl-booke: Make CAM entries used for lowmem configurable

Wolfgang Grandegger (2):
      powerpc/85xx: TQM85xx - fix sensitivity of CAN interrupts
      powerpc/85xx: TQM85xx - add i2c device nodes for LM75
