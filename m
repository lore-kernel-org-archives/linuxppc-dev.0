Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 9DCC5B6F14
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 10:03:21 +1000 (EST)
Received: by ewy2 with SMTP id 2so5928330ewy.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 17:03:19 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] MPC85xx: add definitions for PCI error detection soc part
Date: Thu, 22 Jul 2010 04:03:11 +0400
Message-Id: <1279756992-29543-1-git-send-email-dbaryshkov@gmail.com>
Cc: Doug Thompson <dougthompson@xmission.com>, Dave Jiang <djiang@mvista.com>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add definitions for PCI error detection device to be handled by (already
existing) mpc85xx_edac.c driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dts        |    7 +++++++
 arch/powerpc/boot/dts/mpc8536ds_36b.dts    |    7 +++++++
 arch/powerpc/boot/dts/mpc8540ads.dts       |    8 ++++++++
 arch/powerpc/boot/dts/mpc8541cds.dts       |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8544ds.dts        |    7 +++++++
 arch/powerpc/boot/dts/mpc8548cds.dts       |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts       |   14 ++++++++++++++
 arch/powerpc/boot/dts/mpc8560ads.dts       |    7 +++++++
 arch/powerpc/boot/dts/mpc8568mds.dts       |    7 +++++++
 arch/powerpc/boot/dts/sbc8548.dts          |    7 +++++++
 arch/powerpc/boot/dts/sbc8560.dts          |    7 +++++++
 arch/powerpc/boot/dts/socrates.dts         |    7 +++++++
 arch/powerpc/boot/dts/stx_gp3_8560.dts     |    7 +++++++
 arch/powerpc/boot/dts/tqm8540.dts          |   10 ++++++++++
 arch/powerpc/boot/dts/tqm8541.dts          |    7 +++++++
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    7 +++++++
 arch/powerpc/boot/dts/tqm8548.dts          |    7 +++++++
 arch/powerpc/boot/dts/tqm8555.dts          |    7 +++++++
 arch/powerpc/boot/dts/tqm8560.dts          |    7 +++++++
 arch/powerpc/boot/dts/xpedite5200.dts      |    7 +++++++
 arch/powerpc/boot/dts/xpedite5200_xmon.dts |    7 +++++++
 21 files changed, 172 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 815cebb..6c02e5a 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -278,6 +278,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8536-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
 				     "fsl,sec2.1", "fsl,sec2.0";
diff --git a/arch/powerpc/boot/dts/mpc8536ds_36b.dts b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
index d95b260..89ef5c1 100644
--- a/arch/powerpc/boot/dts/mpc8536ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds_36b.dts
@@ -278,6 +278,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8536-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec3.0", "fsl,sec2.4", "fsl,sec2.2",
 				     "fsl,sec2.1", "fsl,sec2.0";
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 9dc2929..d89f470 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -259,6 +259,14 @@
 			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
 		};
+
+		pci-error@8e00 {
+			compatible = "fsl,mpc8540-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		mpic: pic@40000 {
 			interrupt-controller;
 			#address-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 9a3ad31..c2c5732 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -226,6 +226,20 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8541-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
+		pci-error@9e00 {
+			compatible = "fsl,mpc8541-pci-error";
+			reg = <0x9e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <25 2>;
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 98e94b4..387da1f 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -242,6 +242,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8544-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {	//global utilities block
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 0f52624..973966e 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -328,6 +328,20 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
+		pci-error@9e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x9e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <25 2>;
+		};
+
 		global-utilities@e0000 {	//global utilities reg
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 065b2f0..bcdc344 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -226,6 +226,20 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8555-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
+		pci-error@9e00 {
+			compatible = "fsl,mpc8555-pci-error";
+			reg = <0x9e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <25 2>;
+		};
+
 		crypto@30000 {
 			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index a5bb1ec..04bc095 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -216,6 +216,13 @@
 			device_type = "open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8560-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 92fb178..66af3ab 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -329,6 +329,13 @@
 			};
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8568-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 94a3322..002428c 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -333,6 +333,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {	//global utilities reg
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 9e13ed8..1dc389a 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -239,6 +239,13 @@
 			device_type = "open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8560-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index feb4ef6..06b08f5 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -216,6 +216,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8544-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {	//global utilities block
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index b670d03..78e9e22 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -213,6 +213,13 @@
 			device_type = "open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8560-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index b5c0940..3e73e35 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -160,6 +160,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <29 2 30 2 34 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi0>;
 			phy-handle = <&phy2>;
 
 			mdio@520 {
@@ -205,6 +206,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <35 2 36 2 40 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi1>;
 			phy-handle = <&phy1>;
 
 			mdio@520 {
@@ -232,6 +234,7 @@
 			local-mac-address = [ 00 00 00 00 00 00 ];
 			interrupts = <41 2>;
 			interrupt-parent = <&mpic>;
+			tbi-handle = <&tbi2>;
 			phy-handle = <&phy3>;
 
 			mdio@520 {
@@ -276,6 +279,13 @@
 			device_type = "open-pic";
 			compatible = "chrp,open-pic";
 		};
+
+		pci-error@8e00 {
+			compatible = "fsl,mpc8540-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
 	};
 
 	pci0: pci@e0008000 {
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index f49d091..92106fc 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -261,6 +261,13 @@
 			compatible = "chrp,open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8541-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 5dbb36e..b1944a1 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -338,6 +338,13 @@
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
+
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
 	};
 
 	localbus@a0005000 {
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index a050ae4..be2b1de 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -338,6 +338,13 @@
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
 		};
+
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
 	};
 
 	localbus@e0005000 {
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 81bad8c..7b64c71 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -261,6 +261,13 @@
 			compatible = "chrp,open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8555-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 22ec39b..82408d5 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -232,6 +232,13 @@
 			compatible = "chrp,open-pic";
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8560-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		cpm@919c0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
diff --git a/arch/powerpc/boot/dts/xpedite5200.dts b/arch/powerpc/boot/dts/xpedite5200.dts
index a0cf53f..211dbbf 100644
--- a/arch/powerpc/boot/dts/xpedite5200.dts
+++ b/arch/powerpc/boot/dts/xpedite5200.dts
@@ -352,6 +352,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {	// global utilities reg
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
diff --git a/arch/powerpc/boot/dts/xpedite5200_xmon.dts b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
index c5b2975..ebe9365 100644
--- a/arch/powerpc/boot/dts/xpedite5200_xmon.dts
+++ b/arch/powerpc/boot/dts/xpedite5200_xmon.dts
@@ -356,6 +356,13 @@
 			interrupt-parent = <&mpic>;
 		};
 
+		pci-error@8e00 {
+			compatible = "fsl,mpc8548-pci-error";
+			reg = <0x8e00 0x100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <24 2>;
+		};
+
 		global-utilities@e0000 {	// global utilities reg
 			compatible = "fsl,mpc8548-guts";
 			reg = <0xe0000 0x1000>;
-- 
1.7.1
