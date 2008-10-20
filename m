Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 18D82DE5B1
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 05:04:46 +1100 (EST)
Date: Mon, 20 Oct 2008 13:04:36 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Please pull from 'for-2.6.28' branch
Message-ID: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
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

Please pull from 'for-2.6.28' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.28

to receive the following updates:

 Documentation/powerpc/booting-without-of.txt     |    2 ++
 Documentation/powerpc/dts-bindings/fsl/board.txt |    4 ++--
 arch/powerpc/Kconfig                             |    3 ---
 arch/powerpc/boot/dts/mpc832x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc836x_mds.dts            |    2 +-
 arch/powerpc/boot/dts/mpc8536ds.dts              |   12 ++++++------
 arch/powerpc/boot/dts/mpc8568mds.dts             |    2 +-
 arch/powerpc/include/asm/page.h                  |    5 ++++-
 arch/powerpc/kernel/prom_init_check.sh           |    2 +-
 drivers/i2c/busses/i2c-cpm.c                     |    1 -
 drivers/of/of_spi.c                              |    2 ++
 12 files changed, 21 insertions(+), 18 deletions(-)

Anton Vorontsov (1):
      powerpc: remove device_type = "board-control"

Ed Swarthout (1):
      powerpc/85xx: Fix mpc8536ds dma interrupt numbers

Jason Jin (1):
      powerpc/85xx: Enable enhanced functions for 8536 TSEC

Kumar Gala (2):
      powerpc: Fix build issue with CONFIG_RELOCATABLE=y
      powerpc: Remove Kconfig support for PPC_MERGE

Wolfgang Ocker (1):
      OF: SPI: specify chip select active high

Wolfram Sang (1):
      i2c-cpm: Suppress autoprobing for devices
