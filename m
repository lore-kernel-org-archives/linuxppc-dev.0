Return-Path: <jacmet@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id 6CC86DE126
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 01:52:46 +1100 (EST)
Received: by ewy13 with SMTP id 13so793635ewy.9
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Jan 2009 06:52:43 -0800 (PST)
Sender: Peter Korsgaard <jacmet@gmail.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
To: galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH] dts-bindings/fsl/dma.txt: convert to dts-v1 syntax
Date: Wed, 14 Jan 2009 15:52:41 +0100
Message-Id: <1231944761-18500-1-git-send-email-jacmet@sunsite.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 Documentation/powerpc/dts-bindings/fsl/dma.txt |   34 ++++++++++++------------
 1 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/dma.txt b/Documentation/powerpc/dts-bindings/fsl/dma.txt
index cc45311..0732cdd 100644
--- a/Documentation/powerpc/dts-bindings/fsl/dma.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/dma.txt
@@ -35,30 +35,30 @@ Example:
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8349-dma", "fsl,elo-dma";
-		reg = <82a8 4>;
-		ranges = <0 8100 1a4>;
+		reg = <0x82a8 4>;
+		ranges = <0 0x8100 0x1a4>;
 		interrupt-parent = <&ipic>;
-		interrupts = <47 8>;
+		interrupts = <71 8>;
 		cell-index = <0>;
 		dma-channel@0 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <0>;
-			reg = <0 80>;
+			reg = <0 0x80>;
 		};
 		dma-channel@80 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <1>;
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 		};
 		dma-channel@100 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <2>;
-			reg = <100 80>;
+			reg = <0x100 0x80>;
 		};
 		dma-channel@180 {
 			compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 			cell-index = <3>;
-			reg = <180 80>;
+			reg = <0x180 0x80>;
 		};
 	};
 
@@ -93,36 +93,36 @@ Example:
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "fsl,mpc8540-dma", "fsl,eloplus-dma";
-		reg = <21300 4>;
-		ranges = <0 21100 200>;
+		reg = <0x21300 4>;
+		ranges = <0 0x21100 0x200>;
 		cell-index = <0>;
 		dma-channel@0 {
 			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <0 80>;
+			reg = <0 0x80>;
 			cell-index = <0>;
 			interrupt-parent = <&mpic>;
-			interrupts = <14 2>;
+			interrupts = <20 2>;
 		};
 		dma-channel@80 {
 			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <80 80>;
+			reg = <0x80 0x80>;
 			cell-index = <1>;
 			interrupt-parent = <&mpic>;
-			interrupts = <15 2>;
+			interrupts = <21 2>;
 		};
 		dma-channel@100 {
 			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <100 80>;
+			reg = <0x100 0x80>;
 			cell-index = <2>;
 			interrupt-parent = <&mpic>;
-			interrupts = <16 2>;
+			interrupts = <22 2>;
 		};
 		dma-channel@180 {
 			compatible = "fsl,mpc8540-dma-channel", "fsl,eloplus-dma-channel";
-			reg = <180 80>;
+			reg = <0x180 0x80>;
 			cell-index = <3>;
 			interrupt-parent = <&mpic>;
-			interrupts = <17 2>;
+			interrupts = <23 2>;
 		};
 	};
 
-- 
1.5.6.5
