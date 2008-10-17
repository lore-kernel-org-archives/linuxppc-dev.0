Return-Path: <swarthou@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B28E1DDE06
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Oct 2008 16:42:03 +1100 (EST)
From: Ed Swarthout <Ed.Swarthout@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix mpc8536ds dma interrupt numbers
Date: Fri, 17 Oct 2008 00:41:32 -0500
Message-Id: <1224222092-9301-1-git-send-email-Ed.Swarthout@freescale.com>
Cc: Ed Swarthout <Ed.Swarthout@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Swap pci1 and pci2 labels -
Per user manual, pcie1 is at a000 and pcie2 is at 9000.

Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dts |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 93fdd99..ac4233a 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -109,7 +109,7 @@
 				reg = <0x0 0x80>;
 				cell-index = <0>;
 				interrupt-parent = <&mpic>;
-				interrupts = <14 0x2>;
+				interrupts = <20 2>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8536-dma-channel",
@@ -117,7 +117,7 @@
 				reg = <0x80 0x80>;
 				cell-index = <1>;
 				interrupt-parent = <&mpic>;
-				interrupts = <15 0x2>;
+				interrupts = <21 2>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8536-dma-channel",
@@ -125,7 +125,7 @@
 				reg = <0x100 0x80>;
 				cell-index = <2>;
 				interrupt-parent = <&mpic>;
-				interrupts = <16 0x2>;
+				interrupts = <22 2>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8536-dma-channel",
@@ -133,7 +133,7 @@
 				reg = <0x180 0x80>;
 				cell-index = <3>;
 				interrupt-parent = <&mpic>;
-				interrupts = <17 0x2>;
+				interrupts = <23 2>;
 			};
 		};
 
@@ -321,7 +321,7 @@
 		reg = <0xffe08000 0x1000>;
 	};
 
-	pci1: pcie@ffe09000 {
+	pci2: pcie@ffe09000 {
 		cell-index = <1>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
@@ -358,7 +358,7 @@
 		};
 	};
 
-	pci2: pcie@ffe0a000 {
+	pci1: pcie@ffe0a000 {
 		cell-index = <2>;
 		compatible = "fsl,mpc8548-pcie";
 		device_type = "pci";
-- 
1.5.6.5
