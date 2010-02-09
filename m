Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id A114DB7D5E
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Feb 2010 08:16:05 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 0/3] powerpc: mpc5121: PSC UART support
Date: Tue,  9 Feb 2010 22:13:49 +0100
Message-Id: <1265750032-2803-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de, gregkh@suse.de, linux-kernel@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The support for mpc5121 PSC UART currently only works with
serial console. This patch series re-enable PSC UART support for
all 12 PSCs and document added DTS bingings.

Anatolij Gustschin (3):
  serial: mpc52xx_uart: re-enable mpc5121 PSC UART support
  powerpc: doc/dts-bindings: document mpc5121 psc uart  dts-bindings
  powerpc: mpc5121: enable support for more PSC UARTs

 .../powerpc/dts-bindings/fsl/mpc5121-psc.txt       |   70 ++++++
 arch/powerpc/include/asm/mpc52xx_psc.h             |    4 +
 drivers/serial/mpc52xx_uart.c                      |  251 ++++++++++++++++++--
 3 files changed, 310 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/mpc5121-psc.txt
