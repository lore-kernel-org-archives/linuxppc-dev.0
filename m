Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99941DDF7C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 04:36:20 +1000 (EST)
Date: Fri, 19 Sep 2008 13:36:15 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next'
Message-ID: <Pine.LNX.4.64.0809191335400.27399@blarg.am.freescale.net>
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

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git powerpc-next

to receive the following updates:

 Documentation/powerpc/dts-bindings/fsl/ssi.txt  |   15
 arch/powerpc/boot/dts/gef_sbc610.dts            |  260 +++
 arch/powerpc/boot/dts/mgcoge.dts                |  174 ++
 arch/powerpc/boot/dts/mgsuvd.dts                |  163 ++
 arch/powerpc/boot/dts/mpc836x_mds.dts           |   23
 arch/powerpc/boot/dts/mpc8610_hpcd.dts          |    8
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig |   79 +
 arch/powerpc/configs/86xx/gef_sbc610_defconfig  | 1654 ++++++++++++++++++++++++
 arch/powerpc/configs/mgcoge_defconfig           |  900 +++++++++++++
 arch/powerpc/configs/mgsuvd_defconfig           |  872 ++++++++++++
 arch/powerpc/kernel/head_fsl_booke.S            |   26
 arch/powerpc/kernel/sysfs.c                     |    6
 arch/powerpc/mm/fsl_booke_mmu.c                 |    5
 arch/powerpc/platforms/82xx/Kconfig             |    8
 arch/powerpc/platforms/82xx/Makefile            |    1
 arch/powerpc/platforms/82xx/mgcoge.c            |  129 +
 arch/powerpc/platforms/85xx/sbc8560.c           |    2
 arch/powerpc/platforms/86xx/Kconfig             |    9
 arch/powerpc/platforms/86xx/Makefile            |    1
 arch/powerpc/platforms/86xx/gef_sbc610.c        |  149 ++
 arch/powerpc/platforms/8xx/Kconfig              |    6
 arch/powerpc/platforms/8xx/Makefile             |    1
 arch/powerpc/platforms/8xx/mgsuvd.c             |   92 +
 arch/powerpc/sysdev/cpm1.c                      |   74 -
 drivers/serial/Kconfig                          |   36
 drivers/serial/cpm_uart/cpm_uart_core.c         |    3
 drivers/serial/cpm_uart/cpm_uart_cpm1.c         |    6
 drivers/serial/cpm_uart/cpm_uart_cpm2.c         |    6
 drivers/serial/ucc_uart.c                       |    4
 include/math-emu/op-2.h                         |    2
 include/math-emu/op-common.h                    |   12
 include/math-emu/soft-fp.h                      |   19
 32 files changed, 4656 insertions(+), 89 deletions(-)

Anton Vorontsov (1):
      powerpc/83xx: mpc836x_mds: add support for the nor flash

Becky Bruce (2):
      powerpc/85xx: fix build warning, remove silly cast
      cpm_uart: Pass actual dev ptr to dma_* in ucc and cpm_uart serial

Heiko Schocher (2):
      powerpc: Add support for the MPC852 based mgsuvd board from keymile.
      powerpc: Add support for mpc8247 based board MGCOGE from keymile.

Jochen Friedrich (1):
      powerpc/cpm1: Fix race condition in CPM1 GPIO library.

Kumar Gala (5):
      serial/cpm_uart: Remove dead Kconfig options
      math-emu: Fix compiler warnings
      math-emu: Add support for reporting exact invalid exception
      powerpc: Fix build warnings introduced by PMC support on 32-bit
      powerpc/fsl-booke: Fixup 64-bit PTE reading for SMP support

Martyn Welch (2):
      powerpc: Board support for GE Fanuc SBC610
      powerpc: Default configuration for GE Fanuc SBC610

Paul Gortmaker (1):
      powerpc/sbc8560: fix compile warning on CPM pin array

Timur Tabi (1):
      powerpc: add SSI-to-DMA properties to Freescale MPC8610 HPCD device tree
