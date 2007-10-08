Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id DDCC3DDEE1
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 17:24:40 +1000 (EST)
Received: from pd2mr3so.prod.shaw.ca
	(pd2mr3so-qfe3.prod.shaw.ca [10.0.141.108]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JPL00I1B0KO41F0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 01:24:24 -0600 (MDT)
Received: from pn2ml8so.prod.shaw.ca ([10.0.121.152])
	by pd2mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JPL004B40KM7U60@pd2mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 08 Oct 2007 01:24:25 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JPL008VU0KMHUA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 08 Oct 2007 01:24:22 -0600 (MDT)
Date: Mon, 08 Oct 2007 01:24:22 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Lite5200: Use comma delimiter format for lists in device tree
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Message-id: <20071008072422.9599.64294.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

DTC now supports "foo","bar" format for lists of strings; use the new
format on the lite5200 device trees.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/boot/dts/lite5200.dts  |   10 +++---
 arch/powerpc/boot/dts/lite5200b.dts |   62 ++++++++++++++++++-----------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 324e1bd..bc45f5f 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -19,7 +19,7 @@
 / {
 	model = "fsl,lite5200";
 	// revision = "1.0";
-	compatible = "fsl,lite5200\0generic-mpc5200";
+	compatible = "fsl,lite5200","generic-mpc5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -192,7 +192,7 @@
 
 		usb@1000 {
 			device_type = "usb-ohci-be";
-			compatible = "mpc5200-ohci\0ohci-be";
+			compatible = "mpc5200-ohci","ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -293,7 +293,7 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c\0fsl-i2c";
+			compatible = "mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
@@ -303,7 +303,7 @@
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200-i2c\0fsl-i2c";
+			compatible = "mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
@@ -312,7 +312,7 @@
 		};
 		sram@8000 {
 			device_type = "sram";
-			compatible = "mpc5200-sram\0sram";
+			compatible = "mpc5200-sram","sram";
 			reg = <8000 4000>;
 		};
 	};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 3f74f73..a6bb1d0 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -19,7 +19,7 @@
 / {
 	model = "fsl,lite5200b";
 	// revision = "1.0";
-	compatible = "fsl,lite5200b\0generic-mpc5200";
+	compatible = "fsl,lite5200b","generic-mpc5200";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
@@ -56,7 +56,7 @@
 		system-frequency = <0>;		// from bootloader
 
 		cdm@200 {
-			compatible = "mpc5200b-cdm\0mpc5200-cdm";
+			compatible = "mpc5200b-cdm","mpc5200-cdm";
 			reg = <200 38>;
 		};
 
@@ -65,12 +65,12 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200b-pic\0mpc5200-pic";
+			compatible = "mpc5200b-pic","mpc5200-pic";
 			reg = <500 80>;
 		};
 
 		gpt@600 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <0>;
 			reg = <600 10>;
@@ -80,7 +80,7 @@
 		};
 
 		gpt@610 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <1>;
 			reg = <610 10>;
@@ -89,7 +89,7 @@
 		};
 
 		gpt@620 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <2>;
 			reg = <620 10>;
@@ -98,7 +98,7 @@
 		};
 
 		gpt@630 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <3>;
 			reg = <630 10>;
@@ -107,7 +107,7 @@
 		};
 
 		gpt@640 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <4>;
 			reg = <640 10>;
@@ -116,7 +116,7 @@
 		};
 
 		gpt@650 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <5>;
 			reg = <650 10>;
@@ -125,7 +125,7 @@
 		};
 
 		gpt@660 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <6>;
 			reg = <660 10>;
@@ -134,7 +134,7 @@
 		};
 
 		gpt@670 {	// General Purpose Timer
-			compatible = "mpc5200b-gpt\0mpc5200-gpt";
+			compatible = "mpc5200b-gpt","mpc5200-gpt";
 			device_type = "gpt";
 			cell-index = <7>;
 			reg = <670 10>;
@@ -143,7 +143,7 @@
 		};
 
 		rtc@800 {	// Real time clock
-			compatible = "mpc5200b-rtc\0mpc5200-rtc";
+			compatible = "mpc5200b-rtc","mpc5200-rtc";
 			device_type = "rtc";
 			reg = <800 100>;
 			interrupts = <1 5 0 1 6 0>;
@@ -152,7 +152,7 @@
 
 		mscan@900 {
 			device_type = "mscan";
-			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			compatible = "mpc5200b-mscan","mpc5200-mscan";
 			cell-index = <0>;
 			interrupts = <2 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -161,7 +161,7 @@
 
 		mscan@980 {
 			device_type = "mscan";
-			compatible = "mpc5200b-mscan\0mpc5200-mscan";
+			compatible = "mpc5200b-mscan","mpc5200-mscan";
 			cell-index = <1>;
 			interrupts = <2 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -169,14 +169,14 @@
 		};
 
 		gpio@b00 {
-			compatible = "mpc5200b-gpio\0mpc5200-gpio";
+			compatible = "mpc5200b-gpio","mpc5200-gpio";
 			reg = <b00 40>;
 			interrupts = <1 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
 		gpio-wkup@c00 {
-			compatible = "mpc5200b-gpio-wkup\0mpc5200-gpio-wkup";
+			compatible = "mpc5200b-gpio-wkup","mpc5200-gpio-wkup";
 			reg = <c00 40>;
 			interrupts = <1 8 0 0 3 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -184,7 +184,7 @@
 
 		spi@f00 {
 			device_type = "spi";
-			compatible = "mpc5200b-spi\0mpc5200-spi";
+			compatible = "mpc5200b-spi","mpc5200-spi";
 			reg = <f00 20>;
 			interrupts = <2 d 0 2 e 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -192,7 +192,7 @@
 
 		usb@1000 {
 			device_type = "usb-ohci-be";
-			compatible = "mpc5200b-ohci\0mpc5200-ohci\0ohci-be";
+			compatible = "mpc5200b-ohci","mpc5200-ohci","ohci-be";
 			reg = <1000 ff>;
 			interrupts = <2 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -200,7 +200,7 @@
 
 		bestcomm@1200 {
 			device_type = "dma-controller";
-			compatible = "mpc5200b-bestcomm\0mpc5200-bestcomm";
+			compatible = "mpc5200b-bestcomm","mpc5200-bestcomm";
 			reg = <1200 80>;
 			interrupts = <3 0 0  3 1 0  3 2 0  3 3 0
 			              3 4 0  3 5 0  3 6 0  3 7 0
@@ -210,13 +210,13 @@
 		};
 
 		xlb@1f00 {
-			compatible = "mpc5200b-xlb\0mpc5200-xlb";
+			compatible = "mpc5200b-xlb","mpc5200-xlb";
 			reg = <1f00 100>;
 		};
 
 		serial@2000 {		// PSC1
 			device_type = "serial";
-			compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
+			compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
 			port-number = <0>;  // Logical port assignment
 			cell-index = <0>;
 			reg = <2000 100>;
@@ -227,7 +227,7 @@
 		// PSC2 in ac97 mode example
 		//ac97@2200 {		// PSC2
 		//	device_type = "sound";
-		//	compatible = "mpc5200b-psc-ac97\0mpc5200-psc-ac97";
+		//	compatible = "mpc5200b-psc-ac97","mpc5200-psc-ac97";
 		//	cell-index = <1>;
 		//	reg = <2200 100>;
 		//	interrupts = <2 2 0>;
@@ -247,7 +247,7 @@
 		// PSC4 in uart mode example
 		//serial@2600 {		// PSC4
 		//	device_type = "serial";
-		//	compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
+		//	compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
 		//	cell-index = <3>;
 		//	reg = <2600 100>;
 		//	interrupts = <2 b 0>;
@@ -257,7 +257,7 @@
 		// PSC5 in uart mode example
 		//serial@2800 {		// PSC5
 		//	device_type = "serial";
-		//	compatible = "mpc5200b-psc-uart\0mpc5200-psc-uart";
+		//	compatible = "mpc5200b-psc-uart","mpc5200-psc-uart";
 		//	cell-index = <4>;
 		//	reg = <2800 100>;
 		//	interrupts = <2 c 0>;
@@ -267,7 +267,7 @@
 		// PSC6 in spi mode example
 		//spi@2c00 {		// PSC6
 		//	device_type = "spi";
-		//	compatible = "mpc5200b-psc-spi\0mpc5200-psc-spi";
+		//	compatible = "mpc5200b-psc-spi","mpc5200-psc-spi";
 		//	cell-index = <5>;
 		//	reg = <2c00 100>;
 		//	interrupts = <2 4 0>;
@@ -276,7 +276,7 @@
 
 		ethernet@3000 {
 			device_type = "network";
-			compatible = "mpc5200b-fec\0mpc5200-fec";
+			compatible = "mpc5200b-fec","mpc5200-fec";
 			reg = <3000 800>;
 			mac-address = [ 02 03 04 05 06 07 ]; // Bad!
 			interrupts = <2 5 0>;
@@ -285,7 +285,7 @@
 
 		ata@3a00 {
 			device_type = "ata";
-			compatible = "mpc5200b-ata\0mpc5200-ata";
+			compatible = "mpc5200b-ata","mpc5200-ata";
 			reg = <3a00 100>;
 			interrupts = <2 7 0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -293,7 +293,7 @@
 
 		i2c@3d00 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
+			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			cell-index = <0>;
 			reg = <3d00 40>;
 			interrupts = <2 f 0>;
@@ -303,7 +303,7 @@
 
 		i2c@3d40 {
 			device_type = "i2c";
-			compatible = "mpc5200b-i2c\0mpc5200-i2c\0fsl-i2c";
+			compatible = "mpc5200b-i2c","mpc5200-i2c","fsl-i2c";
 			cell-index = <1>;
 			reg = <3d40 40>;
 			interrupts = <2 10 0>;
@@ -312,7 +312,7 @@
 		};
 		sram@8000 {
 			device_type = "sram";
-			compatible = "mpc5200b-sram\0mpc5200-sram\0sram";
+			compatible = "mpc5200b-sram","mpc5200-sram","sram";
 			reg = <8000 4000>;
 		};
 	};
@@ -322,7 +322,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
-		compatible = "mpc5200b-pci\0mpc5200-pci";
+		compatible = "mpc5200b-pci","mpc5200-pci";
 		reg = <f0000d00 100>;
 		interrupt-map-mask = <f800 0 0 7>;
 		interrupt-map = <c000 0 0 1 &mpc5200_pic 0 0 3 // 1st slot
