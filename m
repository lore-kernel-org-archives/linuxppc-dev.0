Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 846701007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Jul 2011 22:49:59 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: grant.likely@secretlab.ca,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/5200: dts: digsy_mtc.dts: enable both MSCAN nodes
Date: Thu,  7 Jul 2011 14:49:50 +0200
Message-Id: <1310042990-21666-1-git-send-email-agust@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use both MSCAN controllers on this board, so do not disable
them in the device tree.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/digsy_mtc.dts |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 2aad7ae..a7511f2 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -37,14 +37,6 @@
 			status = "disabled";
 		};
 
-		can@900 {
-			status = "disabled";
-		};
-
-		can@980 {
-			status = "disabled";
-		};
-
 		spi@f00 {
 			msp430@0 {
 				compatible = "spidev";
-- 
1.7.1
