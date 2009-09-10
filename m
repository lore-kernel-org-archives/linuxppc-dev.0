Return-Path: <w.sang@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 39329B6F31
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 00:55:47 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 7DF58DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 00:55:46 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/boot/dts: drop obsolete 'fsl5200-clocking'
Date: Thu, 10 Sep 2009 16:55:39 +0200
Message-Id: <1252594539-25202-1-git-send-email-w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The 'fsl5200-clocking'-property was dropped since
0d1cde235874b00905bce23f659690d060ebf475. Remove all occurences in dts-files.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/cm5200.dts     |    1 -
 arch/powerpc/boot/dts/digsy_mtc.dts  |    1 -
 arch/powerpc/boot/dts/lite5200.dts   |    2 --
 arch/powerpc/boot/dts/lite5200b.dts  |    2 --
 arch/powerpc/boot/dts/media5200.dts  |    2 --
 arch/powerpc/boot/dts/motionpro.dts  |    1 -
 arch/powerpc/boot/dts/mpc5121ads.dts |    3 ---
 arch/powerpc/boot/dts/pcm030.dts     |    2 --
 arch/powerpc/boot/dts/pcm032.dts     |    2 --
 arch/powerpc/boot/dts/tqm5200.dts    |    1 -
 10 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index cee8080..dd38608 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -210,7 +210,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 		};
 
 		sram@8000 {
diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 4c36186..8e9be6b 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -199,7 +199,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 
 			rtc@50 {
 				compatible = "at,24c08";
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index de30b3f..82ff2b1 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -247,7 +247,6 @@
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -256,7 +255,6 @@
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 		};
 		sram@8000 {
 			compatible = "fsl,mpc5200-sram";
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index d13cb11..e45a63b 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -251,7 +251,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -260,7 +259,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 		};
 
 		sram@8000 {
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index e297d8b..0c3902b 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -223,7 +223,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -232,7 +231,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 		};
 
 		sram@8000 {
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 7be8ca0..6ca4fc1 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -222,7 +222,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 
 			rtc@68 {
 				compatible = "dallas,ds1339";
diff --git a/arch/powerpc/boot/dts/mpc5121ads.dts b/arch/powerpc/boot/dts/mpc5121ads.dts
index c2b8dbf..c353dac 100644
--- a/arch/powerpc/boot/dts/mpc5121ads.dts
+++ b/arch/powerpc/boot/dts/mpc5121ads.dts
@@ -209,7 +209,6 @@
 			reg = <0x1700 0x20>;
 			interrupts = <9 0x8>;
 			interrupt-parent = < &ipic >;
-			fsl5200-clocking;
 		};
 
 		i2c@1720 {
@@ -220,7 +219,6 @@
 			reg = <0x1720 0x20>;
 			interrupts = <10 0x8>;
 			interrupt-parent = < &ipic >;
-			fsl5200-clocking;
 		};
 
 		i2c@1740 {
@@ -231,7 +229,6 @@
 			reg = <0x1740 0x20>;
 			interrupts = <11 0x8>;
 			interrupt-parent = < &ipic >;
-			fsl5200-clocking;
 		};
 
 		i2ccontrol@1760 {
diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 30bfdc0..8a4ec30 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -244,7 +244,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -253,7 +252,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 			rtc@51 {
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index 0300426..85d857a 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -244,7 +244,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d00 0x40>;
 			interrupts = <2 15 0>;
-			fsl5200-clocking;
 		};
 
 		i2c@3d40 {
@@ -253,7 +252,6 @@
 			compatible = "fsl,mpc5200b-i2c","fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 			rtc@51 {
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index c9590b5..1db07f6 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -160,7 +160,6 @@
 			compatible = "fsl,mpc5200-i2c","fsl-i2c";
 			reg = <0x3d40 0x40>;
 			interrupts = <2 16 0>;
-			fsl5200-clocking;
 
 			 rtc@68 {
 				compatible = "dallas,ds1307";
-- 
1.6.3.3
