Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AD4392C016A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Jul 2013 18:05:57 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Powerpc/t4240: change the compatible flags for t4240qds board
Date: Mon, 8 Jul 2013 15:16:03 +0800
Message-ID: <1373267764-6364-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: r39252@freescale.com, AFLEMING@freescale.com, cbouatmailru@gmail.com,
 scottwood@freescale.com, cjb@laptop.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to make a difference between different T4240 board.
Specify T4240QDS board the unique compatible flags for t4240qds
eSDHC host.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index bd611a9..08b47d0 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -397,7 +397,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
-		compatible = "fsl,t4240-esdhc", "fsl,esdhc";
+		compatible = "fsl,t4240qds-esdhc", "fsl,esdhc";
 		sdhci,auto-cmd12;
 	};
 /include/ "qoriq-i2c-0.dtsi"
-- 
1.8.0
