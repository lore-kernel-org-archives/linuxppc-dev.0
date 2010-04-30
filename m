Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 20FA2B7D16
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 23:21:30 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: spi-devel-general@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Add SPI driver for MPC5121 PSC SPI
Date: Fri, 30 Apr 2010 15:21:25 +0200
Message-Id: <1272633687-6935-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detelv Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin (2):
  powerpc/mpc5121: move PSC FIFO memory init to platform code
  spi: Add SPI master driver for MPC5121 PSC

 arch/powerpc/include/asm/mpc52xx_psc.h       |    1 +
 arch/powerpc/platforms/512x/mpc512x_shared.c |   78 ++++
 drivers/serial/mpc52xx_uart.c                |   69 ---
 drivers/spi/Kconfig                          |    7 +
 drivers/spi/Makefile                         |    1 +
 drivers/spi/mpc512x_psc_spi.c                |  576 ++++++++++++++++++++++++++
 6 files changed, 663 insertions(+), 69 deletions(-)
 create mode 100644 drivers/spi/mpc512x_psc_spi.c
