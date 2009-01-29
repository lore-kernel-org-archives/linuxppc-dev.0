Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 312CBDE486
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 16:10:39 +1100 (EST)
Date: Wed, 28 Jan 2009 23:10:33 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'next' branch (for 2.6.30)
Message-ID: <Pine.LNX.4.64.0901282309450.28856@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git next

to receive the following updates:

 Documentation/powerpc/dts-bindings/fsl/dma.txt |   34
 arch/powerpc/Kconfig                           |   19
 arch/powerpc/boot/dts/gef_sbc310.dts           |  364 +++++
 arch/powerpc/boot/dts/mpc8315erdb.dts          |   64
 arch/powerpc/boot/dts/mpc8377_mds.dts          |   64
 arch/powerpc/boot/dts/mpc8377_rdb.dts          |   70 +
 arch/powerpc/boot/dts/mpc8378_mds.dts          |   64
 arch/powerpc/boot/dts/mpc8378_rdb.dts          |   70 +
 arch/powerpc/boot/dts/mpc8379_rdb.dts          |    6
 arch/powerpc/configs/86xx/gef_sbc310_defconfig | 1613 +++++++++++++++++++++++++
 arch/powerpc/include/asm/reg_booke.h           |    1
 arch/powerpc/kernel/Makefile                   |    1
 arch/powerpc/kernel/cpu_setup_fsl_booke.S      |   31
 arch/powerpc/kernel/cputable.c                 |    8
 arch/powerpc/kernel/head_booke.h               |    6
 arch/powerpc/kernel/head_fsl_booke.S           |   81 -
 arch/powerpc/mm/fsl_booke_mmu.c                |   93 -
 arch/powerpc/platforms/83xx/mpc831x_rdb.c      |    2
 arch/powerpc/platforms/83xx/mpc837x_mds.c      |   10
 arch/powerpc/platforms/83xx/mpc837x_rdb.c      |    2
 arch/powerpc/platforms/86xx/Kconfig            |   10
 arch/powerpc/platforms/86xx/Makefile           |    1
 arch/powerpc/platforms/86xx/gef_gpio.c         |   36
 arch/powerpc/platforms/86xx/gef_sbc310.c       |  230 +++
 arch/powerpc/sysdev/cpm2.c                     |    3
 arch/powerpc/sysdev/fsl_pci.c                  |  244 +++
 drivers/watchdog/Kconfig                       |    2
 include/linux/pci_ids.h                        |    8
 28 files changed, 3003 insertions(+), 134 deletions(-)

Anton Vorontsov (2):
      powerpc/fsl_pci: Add MPC83xx PCI-E controller RC mode support
      powerpc/83xx: Add PCI-E support for all MPC83xx boards with PCI-E

Kumar Gala (2):
      powerpc/fsl-booke: Cleanup init/exception setup to be runtime
      powerpc/fsl: Ensure PCI_QUIRKS are enabled for FSL_PCI

Laurent Pinchart (1):
      cpm2: Round the baud-rate clock divider to the nearest integer.

Martyn Welch (3):
      powerpc/86xx: Board support for GE Fanuc SBC310
      powerpc/86xx: Default configutation for GE Fanuc's SBC310
      powerpc/86xx: Extend GE Fanuc GPIO driver for the SBC310

Peter Korsgaard (1):
      powerpc: convert dts-bindings/fsl/dma.txt to dts-v1 syntax

Reynes Philippe (1):
      powerpc/83xx: Add i2c eeprom to dts for MPC837x RDB

Trent Piepho (3):
      powerpc/fsl-booke: Remove code duplication in lowmem mapping
      powerpc/fsl-booke: Allow larger CAM sizes than 256 MB
      powerpc/fsl-booke: Make CAM entries used for lowmem configurable
