Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 0A0B8B7D56
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 18:48:07 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/3] powerpc: mpc5121: PSC UART support
Date: Tue,  2 Feb 2010 08:47:41 +0100
Message-Id: <1265096864-3506-1-git-send-email-agust@denx.de>
Cc: wd@denx.de, dzu@denx.de
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
---
 .../powerpc/dts-bindings/fsl/mpc5121-psc.txt       |   70 ++++++
 arch/powerpc/include/asm/mpc52xx_psc.h             |    4 +
 drivers/serial/mpc52xx_uart.c                      |  250 +++++++++++++++++++-
 3 files changed, 313 insertions(+), 11 deletions(-)
