Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0E5912C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Aug 2013 13:33:51 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] Powerpc/eSDCH: Specify voltage for T4240QDS
Date: Thu, 29 Aug 2013 11:31:28 +0800
Message-ID: <1377747088-394-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Haijun Zhang <haijun.zhang@freescale.com>,
 X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale T4240QDS reference board has extra voltage shifters added
to allow 3.3V operation, so add 3.3v voltage support for T4240QDS.
1.8v and 3.3v is recommand for eMMC and SDHC card.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
 arch/powerpc/boot/dts/t4240qds.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 0555976..eb3c3de 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -148,6 +148,10 @@
 				interrupts = <0x1 0x1 0 0>;
 			};
 		};
+
+		sdhc@114000 {
+			voltage-ranges = <1800 1800 3300 3300>;
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.8.0
