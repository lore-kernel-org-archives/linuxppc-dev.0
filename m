Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB62CDDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 13:32:43 +1000 (EST)
Date: Wed, 4 Jun 2008 22:32:38 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0806042232040.23796@blarg.am.freescale.net>
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

 Documentation/powerpc/booting-without-of.txt |   49 -
 arch/powerpc/boot/Makefile                   |    3
 arch/powerpc/boot/dts/asp834x-redboot.dts    |  247 +++++
 arch/powerpc/boot/dts/ksi8560.dts            |    3
 arch/powerpc/boot/dts/mpc7448hpc2.dts        |    2
 arch/powerpc/boot/dts/mpc8540ads.dts         |    5
 arch/powerpc/boot/dts/mpc8541cds.dts         |    5
 arch/powerpc/boot/dts/mpc8544ds.dts          |   21
 arch/powerpc/boot/dts/mpc8548cds.dts         |    5
 arch/powerpc/boot/dts/mpc8555cds.dts         |    5
 arch/powerpc/boot/dts/mpc8560ads.dts         |    3
 arch/powerpc/boot/dts/mpc8568mds.dts         |    5
 arch/powerpc/boot/dts/mpc8572ds.dts          |   22
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |   18
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    2
 arch/powerpc/boot/dts/sbc8548.dts            |    5
 arch/powerpc/boot/dts/sbc8560.dts            |    5
 arch/powerpc/boot/dts/storcenter.dts         |    1
 arch/powerpc/boot/dts/stx_gp3_8560.dts       |    4
 arch/powerpc/boot/dts/tqm8540.dts            |    4
 arch/powerpc/boot/dts/tqm8541.dts            |    4
 arch/powerpc/boot/dts/tqm8555.dts            |    4
 arch/powerpc/boot/dts/tqm8560.dts            |    4
 arch/powerpc/boot/redboot-83xx.c             |   60 +
 arch/powerpc/boot/wrapper                    |    6
 arch/powerpc/configs/asp8347_defconfig       | 1214 +++++++++++++++++++++++++++
 arch/powerpc/kernel/asm-offsets.c            |   23
 arch/powerpc/kernel/entry_32.S               |  138 ++-
 arch/powerpc/kernel/head_40x.S               |   24
 arch/powerpc/kernel/head_44x.S               |    9
 arch/powerpc/kernel/head_booke.h             |  100 +-
 arch/powerpc/kernel/head_fsl_booke.S         |    9
 arch/powerpc/kernel/irq.c                    |   33
 arch/powerpc/kernel/setup_32.c               |   24
 arch/powerpc/platforms/83xx/Kconfig          |    9
 arch/powerpc/platforms/83xx/Makefile         |    1
 arch/powerpc/platforms/83xx/asp834x.c        |   90 ++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c     |    4
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |    3
 arch/powerpc/sysdev/Makefile                 |    3
 arch/powerpc/sysdev/fsl_msi.c                |  429 +++++++++
 arch/powerpc/sysdev/fsl_msi.h                |   42
 arch/powerpc/sysdev/fsl_pci.c                |   12
 arch/powerpc/sysdev/fsl_soc.c                |   15
 include/asm-powerpc/irq.h                    |   13
 45 files changed, 2552 insertions(+), 135 deletions(-)

Anton Vorontsov (1):
      [POWERPC] fsl_msi: few (mostly cosmetic) fixes

Bryan O'Donoghue (1):
      [POWERPC] 83xx: Add support for Analogue & Micro ASP837E board

Jason Jin (4):
      [POWERPC] Update booting-without-of for Freescale PCIe MSI
      [POWERPC] fsl: PCIe MSI support for 83xx/85xx/86xx processors.
      [POWERPC] 86xx: Enable MSI support for MPC8610HPCD board
      [POWERPC] 85xx: Enable MSI support for 85xxds board

Kumar Gala (5):
      [POWERPC] Cleanup mpic nodes in .dts
      [POWERPC] 85xx: Add next-level-cache property
      [POWERPC] Move to runtime allocated exception stacks
      [POWERPC] Rework EXC_LEVEL_EXCEPTION_PROLOG code
      [POWERPC] 40x/Book-E: Save/restore volatile exception registers

Timur Tabi (3):
      [POWERPC] fsl: Add warning for unrecognized I2C nodes in the device tree
      [POWERPC] fsl: Add CS4270 i2c data to fsl_soc.c
      [POWERPC] fsl: Update fsl_soc to use cell-index property of I2C nodes
