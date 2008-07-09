Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07F26DDFF5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 23:13:08 +1000 (EST)
Date: Wed, 9 Jul 2008 08:13:03 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'powerpc-next' branch
Message-ID: <Pine.LNX.4.64.0807090812110.6382@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'powerpc-next' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/dts.git powerpc-next

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt                  | 1176 -------
 Documentation/powerpc/dts-bindings/fsl/board.txt              |   29
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm.txt         |   67
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/brg.txt     |   21
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/i2c.txt     |   41
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/pic.txt     |   18
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/cpm/usb.txt     |   15
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/network.txt     |   45
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe.txt          |   58
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/firmware.txt |   24
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/par_io.txt   |   51
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/pincfg.txt   |   60
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/ucc.txt      |   70
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/qe/usb.txt      |   22
 Documentation/powerpc/dts-bindings/fsl/cpm_qe/serial.txt      |   21
 Documentation/powerpc/dts-bindings/fsl/diu.txt                |   18
 Documentation/powerpc/dts-bindings/fsl/dma.txt                |  127
 Documentation/powerpc/dts-bindings/fsl/gtm.txt                |   31
 Documentation/powerpc/dts-bindings/fsl/guts.txt               |   25
 Documentation/powerpc/dts-bindings/fsl/i2c.txt                |   32
 Documentation/powerpc/dts-bindings/fsl/lbc.txt                |   35
 Documentation/powerpc/dts-bindings/fsl/msi-pic.txt            |   36
 Documentation/powerpc/dts-bindings/fsl/sata.txt               |   29
 Documentation/powerpc/dts-bindings/fsl/sec.txt                |   68
 Documentation/powerpc/dts-bindings/fsl/spi.txt                |   24
 Documentation/powerpc/dts-bindings/fsl/ssi.txt                |   38
 Documentation/powerpc/dts-bindings/fsl/tsec.txt               |   69
 Documentation/powerpc/dts-bindings/fsl/usb.txt                |   59
 arch/powerpc/boot/dts/ksi8560.dts                             |   20
 arch/powerpc/boot/dts/mpc8272ads.dts                          |   32
 arch/powerpc/boot/dts/mpc8313erdb.dts                         |   15
 arch/powerpc/boot/dts/mpc8315erdb.dts                         |   15
 arch/powerpc/boot/dts/mpc832x_mds.dts                         |   15
 arch/powerpc/boot/dts/mpc832x_rdb.dts                         |   15
 arch/powerpc/boot/dts/mpc8349emitx.dts                        |   12
 arch/powerpc/boot/dts/mpc8349emitxgp.dts                      |   12
 arch/powerpc/boot/dts/mpc834x_mds.dts                         |   15
 arch/powerpc/boot/dts/mpc836x_mds.dts                         |   13
 arch/powerpc/boot/dts/mpc8377_mds.dts                         |   13
 arch/powerpc/boot/dts/mpc8377_rdb.dts                         |   14
 arch/powerpc/boot/dts/mpc8378_mds.dts                         |   13
 arch/powerpc/boot/dts/mpc8378_rdb.dts                         |   14
 arch/powerpc/boot/dts/mpc8379_mds.dts                         |   13
 arch/powerpc/boot/dts/mpc8379_rdb.dts                         |   14
 arch/powerpc/boot/dts/mpc8536ds.dts                           |  432 ++
 arch/powerpc/boot/dts/mpc8541cds.dts                          |   11
 arch/powerpc/boot/dts/mpc8544ds.dts                           |   11
 arch/powerpc/boot/dts/mpc8548cds.dts                          |   11
 arch/powerpc/boot/dts/mpc8555cds.dts                          |   11
 arch/powerpc/boot/dts/mpc8568mds.dts                          |   14
 arch/powerpc/boot/dts/mpc8572ds.dts                           |   12
 arch/powerpc/boot/dts/mpc8610_hpcd.dts                        |    2
 arch/powerpc/boot/dts/mpc866ads.dts                           |   11
 arch/powerpc/boot/dts/mpc885ads.dts                           |   11
 arch/powerpc/boot/dts/sbc8349.dts                             |   14
 arch/powerpc/boot/dts/sbc8548.dts                             |   11
 arch/powerpc/boot/dts/tqm8541.dts                             |   11
 arch/powerpc/boot/dts/tqm8548.dts                             |    5
 arch/powerpc/boot/dts/tqm8555.dts                             |   11
 arch/powerpc/configs/85xx/tqm8548_defconfig                   |  143
 arch/powerpc/configs/mpc8536_ds_defconfig                     | 1637 ++++++++++
 arch/powerpc/kernel/time.c                                    |    4
 arch/powerpc/platforms/82xx/Kconfig                           |   11
 arch/powerpc/platforms/82xx/mpc8272_ads.c                     |    4
 arch/powerpc/platforms/82xx/pq2ads-pci-pic.c                  |    2
 arch/powerpc/platforms/83xx/Kconfig                           |   10
 arch/powerpc/platforms/85xx/Kconfig                           |    6
 arch/powerpc/platforms/85xx/Makefile                          |    1
 arch/powerpc/platforms/85xx/mpc8536_ds.c                      |  125
 arch/powerpc/platforms/85xx/mpc85xx_cds.c                     |   14
 arch/powerpc/platforms/85xx/mpc85xx_ds.c                      |    8
 arch/powerpc/platforms/86xx/Kconfig                           |   16
 arch/powerpc/platforms/86xx/Makefile                          |    1
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c                    |   26
 arch/powerpc/platforms/86xx/mpc86xx.h                         |    3
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c                    |   64
 arch/powerpc/platforms/86xx/pic.c                             |   78
 arch/powerpc/platforms/86xx/sbc8641d.c                        |   25
 arch/powerpc/platforms/8xx/mpc86xads_setup.c                  |    4
 arch/powerpc/platforms/8xx/mpc885ads_setup.c                  |    3
 arch/powerpc/platforms/Kconfig                                |   33
 arch/powerpc/sysdev/cpm_common.c                              |    3
 arch/powerpc/sysdev/fsl_pci.c                                 |    2
 drivers/serial/cpm_uart/cpm_uart_core.c                       |   20
 include/linux/pci_ids.h                                       |    2
 85 files changed, 3887 insertions(+), 1490 deletions(-)

Anton Vorontsov (1):
      powerpc/86xx: mpc8610_hpcd: fix interrupt trigger type for ULi IDE

Dave Jiang (1):
      powerpc/85xx: publish of device for cds platforms

Jason Jin (1):
      powerpc/85xx: Minor fixes for 85xxds and 8536ds board.

Jochen Friedrich (1):
      powerpc/CPM: Add i2c pins to dts and board setup

Kim Phillips (1):
      powerpc/fsl: update crypto node definition and device tree instances

Kumar Gala (7):
      powerpc/85xx: Fix KSI8560 .dts
      powerpc/85xx: minor fixes for MPC85xx DS board port
      powerpc/85xx: Add support for MPC8536DS
      powerpc/86xx: Refactor pic init
      powerpc/booke: don't reinitialize time base
      powerpc: Add 82xx/83xx/86xx to 6xx Multiplatform
      powerpc/fsl: Refactor device bindings

Laurent Pinchart (1):
      cpm_uart: Support uart_wait_until_sent()

Nye Liu (1):
      powerpc/CPM: Minor cosmetic changes to udbg_putc

Rune Torgersen (2):
      cpm_uart: Fix cpm uart corruption with PREEMPT_RT
      powerpc: Fix pq2fads irq handling with PREEMPT_RT

Wolfgang Grandegger (1):
      powerpc/85xx: TQM8548: add missing support for RTC and LM75
