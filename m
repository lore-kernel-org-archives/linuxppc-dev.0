Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A2AEADDE17
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 06:55:48 +1000 (EST)
Date: Thu, 13 Sep 2007 15:55:35 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from for-2.6.24
Message-ID: <Pine.LNX.4.64.0709131554530.29675@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.24' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.24

to receive the following updates:

 arch/powerpc/boot/dts/holly.dts                  |    1
 arch/powerpc/boot/dts/kuroboxHD.dts              |    6
 arch/powerpc/boot/dts/kuroboxHG.dts              |    6
 arch/powerpc/boot/dts/lite5200.dts               |   49
 arch/powerpc/boot/dts/lite5200b.dts              |   59
 arch/powerpc/boot/dts/mpc7448hpc2.dts            |   17
 arch/powerpc/boot/dts/mpc8272ads.dts             |    5
 arch/powerpc/boot/dts/mpc8313erdb.dts            |   63
 arch/powerpc/boot/dts/mpc832x_mds.dts            |  122 -
 arch/powerpc/boot/dts/mpc832x_rdb.dts            |   72 -
 arch/powerpc/boot/dts/mpc8349emitx.dts           |   98 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts         |   47
 arch/powerpc/boot/dts/mpc834x_mds.dts            |  243 +--
 arch/powerpc/boot/dts/mpc836x_mds.dts            |  123 -
 arch/powerpc/boot/dts/mpc8540ads.dts             |  175 +-
 arch/powerpc/boot/dts/mpc8541cds.dts             |  196 +--
 arch/powerpc/boot/dts/mpc8544ds.dts              |  377 +++--
 arch/powerpc/boot/dts/mpc8548cds.dts             |  404 +++---
 arch/powerpc/boot/dts/mpc8555cds.dts             |  196 +--
 arch/powerpc/boot/dts/mpc8560ads.dts             |  185 +-
 arch/powerpc/boot/dts/mpc8568mds.dts             |    4
 arch/powerpc/boot/dts/mpc8572ds.dts              |  404 ++++++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts           |  275 ++--
 arch/powerpc/boot/dts/mpc866ads.dts              |    5
 arch/powerpc/boot/dts/mpc885ads.dts              |    5
 arch/powerpc/boot/dts/prpmc2800.dts              |    1
 arch/powerpc/configs/mpc8544_ds_defconfig        |    2
 arch/powerpc/configs/mpc8572_ds_defconfig        | 1496 +++++++++++++++++++++++
 arch/powerpc/kernel/align.c                      |  250 +++
 arch/powerpc/kernel/cputable.c                   |   23
 arch/powerpc/kernel/entry_32.S                   |    4
 arch/powerpc/kernel/head_32.S                    |   17
 arch/powerpc/kernel/head_40x.S                   |   12
 arch/powerpc/kernel/head_44x.S                   |    6
 arch/powerpc/kernel/head_8xx.S                   |    9
 arch/powerpc/kernel/head_fsl_booke.S             |    6
 arch/powerpc/kernel/process.c                    |   15
 arch/powerpc/kernel/ptrace.c                     |    6
 arch/powerpc/kernel/vmlinux.lds.S                |    2
 arch/powerpc/platforms/83xx/mpc8313_rdb.c        |    2
 arch/powerpc/platforms/83xx/mpc832x_mds.c        |    1
 arch/powerpc/platforms/83xx/mpc832x_rdb.c        |   48
 arch/powerpc/platforms/83xx/mpc834x_itx.c        |    2
 arch/powerpc/platforms/83xx/mpc834x_mds.c        |    2
 arch/powerpc/platforms/83xx/mpc836x_mds.c        |    1
 arch/powerpc/platforms/83xx/mpc83xx.h            |    2
 arch/powerpc/platforms/83xx/pci.c                |    7
 arch/powerpc/platforms/85xx/Kconfig              |    8
 arch/powerpc/platforms/85xx/Makefile             |    2
 arch/powerpc/platforms/85xx/mpc8544_ds.c         |  188 --
 arch/powerpc/platforms/85xx/mpc85xx_ads.c        |   13
 arch/powerpc/platforms/85xx/mpc85xx_cds.c        |   13
 arch/powerpc/platforms/85xx/mpc85xx_ds.c         |  227 +++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c        |   11
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c       |   14
 arch/powerpc/platforms/embedded6xx/linkstation.c |    1
 arch/powerpc/platforms/embedded6xx/ls_uart.c     |   14
 arch/powerpc/sysdev/fsl_pci.c                    |    2
 arch/powerpc/sysdev/fsl_soc.c                    |  114 +
 arch/powerpc/sysdev/fsl_soc.h                    |    7
 drivers/net/ucc_geth_mii.c                       |    1
 drivers/serial/mpc52xx_uart.c                    |    2
 include/asm-powerpc/cputable.h                   |   26
 include/asm-powerpc/immap_86xx.h                 |  151 --
 include/asm-powerpc/io.h                         |   23
 include/asm-powerpc/ppc_asm.h                    |    4
 include/asm-powerpc/qe.h                         |    3
 include/asm-ppc/io.h                             |    3
 include/linux/pci_ids.h                          |    2
 69 files changed, 4049 insertions(+), 1831 deletions(-)

Anton Vorontsov (3):
      [POWERPC] QE: extern par_io_config_pin and par_io_data_set funcs
      [POWERPC] fsl_soc: add support for fsl_spi
      [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register mmc_spi stub

Guennadi Liakhovetski (1):
      [POWERPC] linkstation updates

John Rigby (1):
      [POWERPC] 52xx: Fix mpc52xx_uart_of_assign to use correct index

Jon Loeliger (2):
      [POWERPC] 86xx: Remove unnecessary loops_per_jiffy initialization code.
      [POWERPC] 85xx: Remove unnecessary loops_per_jiffy initialization code.

Kumar Gala (10):
      ucc_geth: kill unused include
      [POWERPC] 85xx: Renamed mpc8544_ds.c to mpc85xx_ds.c
      [POWERPC] 85xx: Clean up from 85xx_ds rename
      [POWERPC] Handle alignment faults on SPE load/store instructions
      [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
      [POWERPC] DTS cleanup
      [POWERPC] Move PCI nodes to be sibilings with SOC nodes
      [POWERPC] 83xx: Removed PCI exclude of PHB
      [POWERPC] Add cpu feature for SPE handling
      [POWERPC] Fix modpost warnings from head*.S on ppc32

Roy Zang (1):
      [POWERPC] Update mpc7448hpc2 device tree to be compatible for tsi109 chip

Scott Wood (2):
      [POWERPC] fsl_soc.c cleanup
      [PPC] Add clrbits8 and setbits8.

Timur Tabi (2):
      [POWERPC] add clrsetbits macros
      [POWERPC] 86xx: Fix definition of global-utilites structure
