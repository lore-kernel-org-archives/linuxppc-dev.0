Return-Path: <SRS0=9ZSp=SG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 80F0CDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 20:00:57 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Remove "i2c" and "xxmii-interface"
	device_types from dts
Date: Wed, 16 Jan 2008 10:00:00 +0100
Message-Id: <1200474000-5630-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove all "i2c" and "xxmii-interface" (rgmii etc) device_type entries
from the 4xx dts files.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/bamboo.dts  |    3 ---
 arch/powerpc/boot/dts/ebony.dts   |    2 --
 arch/powerpc/boot/dts/katmai.dts  |    2 --
 arch/powerpc/boot/dts/kilauea.dts |    3 ---
 arch/powerpc/boot/dts/makalu.dts  |    3 ---
 arch/powerpc/boot/dts/rainier.dts |    4 ----
 arch/powerpc/boot/dts/sequoia.dts |    4 ----
 arch/powerpc/boot/dts/taishan.dts |    4 ----
 8 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/boot/dts/bamboo.dts b/arch/powerpc/boot/dts/bamboo.dts
index 29f1a6f..7dc37c9 100644
--- a/arch/powerpc/boot/dts/bamboo.dts
+++ b/arch/powerpc/boot/dts/bamboo.dts
@@ -185,7 +185,6 @@
 	   		};
 
 			IIC0: i2c@ef600700 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
@@ -193,7 +192,6 @@
 			};
 
 			IIC1: i2c@ef600800 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440ep", "ibm,iic-440gp", "ibm,iic";
 				reg = <ef600800 14>;
 				interrupt-parent = <&UIC0>;
@@ -201,7 +199,6 @@
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
-				device_type = "zmii-interface";
 				compatible = "ibm,zmii-440ep", "ibm,zmii-440gp", "ibm,zmii";
 				reg = <ef600d00 c>;
 			};
diff --git a/arch/powerpc/boot/dts/ebony.dts b/arch/powerpc/boot/dts/ebony.dts
index f8790c4..106ef37 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -215,7 +215,6 @@
 
 			IIC0: i2c@40000400 {
 				/* FIXME */
-				device_type = "i2c";
 				compatible = "ibm,iic-440gp", "ibm,iic";
 				reg = <40000400 14>;
 				interrupt-parent = <&UIC0>;
@@ -223,7 +222,6 @@
 			};
 			IIC1: i2c@40000500 {
 				/* FIXME */
-				device_type = "i2c";
 				compatible = "ibm,iic-440gp", "ibm,iic";
 				reg = <40000500 14>;
 				interrupt-parent = <&UIC0>;
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 9bdfc0f..bc32ac7 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -187,7 +187,6 @@
 	   		};
 
 			IIC0: i2c@10000400 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
 				reg = <10000400 14>;
 				interrupt-parent = <&UIC0>;
@@ -195,7 +194,6 @@
 			};
 
 			IIC1: i2c@10000500 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440spe", "ibm,iic-440gp", "ibm,iic";
 				reg = <10000500 14>;
 				interrupt-parent = <&UIC0>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 67c7ea1..8baef61 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -182,7 +182,6 @@
 			};
 
 			IIC0: i2c@ef600400 {
-				device_type = "i2c";
 				compatible = "ibm,iic-405ex", "ibm,iic";
 				reg = <ef600400 14>;
 				interrupt-parent = <&UIC0>;
@@ -190,7 +189,6 @@
 			};
 
 			IIC1: i2c@ef600500 {
-				device_type = "i2c";
 				compatible = "ibm,iic-405ex", "ibm,iic";
 				reg = <ef600500 14>;
 				interrupt-parent = <&UIC0>;
@@ -199,7 +197,6 @@
 
 
 			RGMII0: emac-rgmii@ef600b00 {
-				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
 				reg = <ef600b00 104>;
 				has-mdio;
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index bdd70e4..710c011 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -182,7 +182,6 @@
 			};
 
 			IIC0: i2c@ef600400 {
-				device_type = "i2c";
 				compatible = "ibm,iic-405ex", "ibm,iic";
 				reg = <ef600400 14>;
 				interrupt-parent = <&UIC0>;
@@ -190,7 +189,6 @@
 			};
 
 			IIC1: i2c@ef600500 {
-				device_type = "i2c";
 				compatible = "ibm,iic-405ex", "ibm,iic";
 				reg = <ef600500 14>;
 				interrupt-parent = <&UIC0>;
@@ -199,7 +197,6 @@
 
 
 			RGMII0: emac-rgmii@ef600b00 {
-				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii-405ex", "ibm,rgmii";
 				reg = <ef600b00 104>;
 				has-mdio;
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index d3c2ac3..f947c75 100644
--- a/arch/powerpc/boot/dts/rainier.dts
+++ b/arch/powerpc/boot/dts/rainier.dts
@@ -229,7 +229,6 @@
 	   		};
 
 			IIC0: i2c@ef600700 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440grx", "ibm,iic";
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
@@ -237,7 +236,6 @@
 			};
 
 			IIC1: i2c@ef600800 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440grx", "ibm,iic";
 				reg = <ef600800 14>;
 				interrupt-parent = <&UIC0>;
@@ -245,13 +243,11 @@
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
-				device_type = "zmii-interface";
 				compatible = "ibm,zmii-440grx", "ibm,zmii";
 				reg = <ef600d00 c>;
 			};
 
 			RGMII0: emac-rgmii@ef601000 {
-				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii-440grx", "ibm,rgmii";
 				reg = <ef601000 8>;
 				has-mdio;
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index d9046c1..276f596 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -236,7 +236,6 @@
 	   		};
 
 			IIC0: i2c@ef600700 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440epx", "ibm,iic";
 				reg = <ef600700 14>;
 				interrupt-parent = <&UIC0>;
@@ -244,7 +243,6 @@
 			};
 
 			IIC1: i2c@ef600800 {
-				device_type = "i2c";
 				compatible = "ibm,iic-440epx", "ibm,iic";
 				reg = <ef600800 14>;
 				interrupt-parent = <&UIC0>;
@@ -252,13 +250,11 @@
 			};
 
 			ZMII0: emac-zmii@ef600d00 {
-				device_type = "zmii-interface";
 				compatible = "ibm,zmii-440epx", "ibm,zmii";
 				reg = <ef600d00 c>;
 			};
 
 			RGMII0: emac-rgmii@ef601000 {
-				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii-440epx", "ibm,rgmii";
 				reg = <ef601000 8>;
 				has-mdio;
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 0706a4a..8278068 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -203,7 +203,6 @@
 
 			IIC0: i2c@40000400 {
 				/* FIXME */
-				device_type = "i2c";
 				compatible = "ibm,iic-440gp", "ibm,iic";
 				reg = <40000400 14>;
 				interrupt-parent = <&UIC0>;
@@ -211,7 +210,6 @@
 			};
 			IIC1: i2c@40000500 {
 				/* FIXME */
-				device_type = "i2c";
 				compatible = "ibm,iic-440gp", "ibm,iic";
 				reg = <40000500 14>;
 				interrupt-parent = <&UIC0>;
@@ -225,13 +223,11 @@
 			};
 
 			ZMII0: emac-zmii@40000780 {
-				device_type = "zgmii-interface";
 				compatible = "ibm,zmii-440gx", "ibm,zmii";
 				reg = <40000780 c>;
 			};
 
 			RGMII0: emac-rgmii@40000790 {
-				device_type = "rgmii-interface";
 				compatible = "ibm,rgmii";
 				reg = <40000790 8>;
 			};
-- 
1.5.4.rc3
