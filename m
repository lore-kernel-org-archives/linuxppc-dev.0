Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 5CC51DDF0B
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Mar 2008 21:32:01 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2 v2] [POWERPC] Add L2 cache node to AMCC Taishan dts file
Date: Sat, 22 Mar 2008 11:29:14 +0100
Message-Id: <1206181754-21830-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the L2 cache node to the Taishan 440GX dts file.

Signed-off-by: Stefan Roese <sr@denx.de>
---
Unit address removed.

 arch/powerpc/boot/dts/taishan.dts     |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 8278068..d0bff33 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -104,6 +104,16 @@
 		// FIXME: anything else?
 	};
 
+	L2C0: l2c {
+		compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
+		dcr-reg = <20 8			/* Internal SRAM DCR's */
+			   30 8>;		/* L2 cache DCR's */
+		cache-line-size = <20>;		/* 32 bytes */
+		cache-size = <40000>;		/* L2, 256K */
+		interrupt-parent = <&UIC2>;
+		interrupts = <17 1>;
+	};
+
 	plb {
 		compatible = "ibm,plb-440gx", "ibm,plb4";
 		#address-cells = <2>;
-- 
1.5.4.4
