Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6E08DDF51
	for <linuxppc-dev@ozlabs.org>; Wed, 14 May 2008 00:01:34 +1000 (EST)
Date: Tue, 13 May 2008 08:56:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'powerpc-next' branch (for 2.6.26)
Message-ID: <Pine.LNX.4.64.0805130854430.25874@blarg.am.freescale.net>
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

All of these changes are pretty much isolated to the board they touch so
the possibility of breaking things is minor.  Also, the driver removal is
because we have superceded fec_8xx with fs_enet.

- k

to receive the following updates:

 arch/powerpc/boot/dts/mpc8377_mds.dts       |   27
 arch/powerpc/boot/dts/mpc8610_hpcd.dts      |   60 +
 arch/powerpc/boot/dts/sbc8548.dts           |   94 ++
 arch/powerpc/configs/mpc8610_hpcd_defconfig |   95 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c   |  121 ++
 arch/powerpc/platforms/85xx/sbc8548.c       |   30
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c  |   15
 drivers/net/Kconfig                         |    1
 drivers/net/Makefile                        |    1
 drivers/net/fec_8xx/Kconfig                 |   20
 drivers/net/fec_8xx/Makefile                |   12
 drivers/net/fec_8xx/fec_8xx-netta.c         |  151 ---
 drivers/net/fec_8xx/fec_8xx.h               |  220 ----
 drivers/net/fec_8xx/fec_main.c              | 1264 ----------------------------
 drivers/net/fec_8xx/fec_mii.c               |  418 ---------
 15 files changed, 429 insertions(+), 2100 deletions(-)

Andy Fleming (2):
      [POWERPC] 85xx: Add 8568 PHY workarounds to board code
      [POWERPC] 85xx: Fix some sparse warnings for 85xx MDS

Anton Vorontsov (3):
      [POWERPC] 86xx: mpc8610_hpcd: use ULI526X driver for on-board ethernet
      [POWERPC] 86xx: mpc8610_hpcd: add support for NOR and NAND flashes
      [POWERPC] 86xx: mpc8610_hpcd: fix second serial port

Becky Bruce (1):
      [POWERPC] Delete unused fec_8xx net driver

Jeremy McNicoll (1):
      [POWERPC] 85xx: SBC8548 - Add flash support and HW Rev reporting

Zhang Wei (1):
      [POWERPC] 83xx: Enable DMA engine on the MPC8377 MDS board.
