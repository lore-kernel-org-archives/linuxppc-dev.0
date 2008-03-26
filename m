Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id B5A35DE247
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 22:43:34 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2 v3] [POWERPC] Add L2 cache node to AMCC Taishan dts file
Date: Wed, 26 Mar 2008 12:42:55 +0100
Message-Id: <1206531775-9959-1-git-send-email-sr@denx.de>
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
ver3:
Nothing changed

ver2:
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
