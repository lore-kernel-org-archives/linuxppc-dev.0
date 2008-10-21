Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6BC68DDDD8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 15:38:24 +1100 (EST)
Date: Mon, 20 Oct 2008 23:38:19 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [UPDATED] Please pull from 'for-2.6.28' branch
Message-ID: <Pine.LNX.4.64.0810202337580.18901@blarg.am.freescale.net>
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

Please pull from 'for-2.6.28' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.28

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt     |    2 +
 Documentation/powerpc/dts-bindings/fsl/board.txt |    4 +--
 arch/powerpc/boot/dts/mpc8315erdb.dts            |    8 ++++++
 arch/powerpc/boot/dts/mpc832x_mds.dts            |    2 -
 arch/powerpc/boot/dts/mpc8349emitx.dts           |   16 +++++++++++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts         |    8 ++++++
 arch/powerpc/boot/dts/mpc834x_mds.dts            |    2 -
 arch/powerpc/boot/dts/mpc836x_mds.dts            |    2 -
 arch/powerpc/boot/dts/mpc8377_rdb.dts            |    8 ++++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts            |    8 ++++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts            |    8 ++++++
 arch/powerpc/boot/dts/mpc8536ds.dts              |   12 +++++-----
 arch/powerpc/boot/dts/mpc8568mds.dts             |    2 -
 arch/powerpc/boot/dts/mpc8572ds.dts              |   27 +++++++++++------------
 drivers/i2c/busses/i2c-cpm.c                     |    1
 drivers/of/of_spi.c                              |    2 +
 16 files changed, 85 insertions(+), 27 deletions(-)

Anton Vorontsov (3):
      powerpc: Remove device_type = "board_control" properties in .dts files
      powerpc/83xx: Add support for MCU microcontroller in .dts files
      powerpc/83xx: Add DS1339 RTC support for MPC8349E-mITX boards .dts

Ed Swarthout (1):
      powerpc/85xx: Fix mpc8536ds dma interrupt numbers

Jason Jin (1):
      powerpc/85xx: Enable enhanced functions for 8536 TSEC

Kumar Gala (1):
      powerpc/85xx: Move mpc8572ds.dts to address-cells/size-cells = <2>

Wolfgang Ocker (1):
      of/spi: Support specifying chip select as active high via device tree

Wolfram Sang (1):
      i2c-cpm: Suppress autoprobing for devices
