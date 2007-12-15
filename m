Return-Path: <SRS0=z9zg=RG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id C8358DDDD6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 18:55:19 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add aliases node to 4xx dts files
Date: Sat, 15 Dec 2007 08:55:16 +0100
Message-Id: <1197705316-17618-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/bamboo.dts  |    9 +++++++++
 arch/powerpc/boot/dts/ebony.dts   |    7 +++++++
 arch/powerpc/boot/dts/ep405.dts   |    6 ++++++
 arch/powerpc/boot/dts/katmai.dts  |    7 +++++++
 arch/powerpc/boot/dts/kilauea.dts |    7 +++++++
 arch/powerpc/boot/dts/rainier.dts |   11 ++++++++++-
 arch/powerpc/boot/dts/sequoia.dts |    9 +++++++++
 arch/powerpc/boot/dts/taishan.dts |    7 +++++++
 arch/powerpc/boot/dts/walnut.dts  |    6 ++++++
 9 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/bamboo.dts b/arch/powerpc/boot/dts/bamboo.dts
index 3652aec..2ebb437 100644
--- a/arch/powerpc/boot/dts/bamboo.dts
+++ b/arch/powerpc/boot/dts/bamboo.dts
@@ -18,6 +18,15 @@
 	compatible = "amcc,bamboo";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+		serial2 = &UART2;
+		serial3 = &UART3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/ebony.dts b/arch/powerpc/boot/dts/ebony.dts
index 3cb2849..f8790c4 100644
--- a/arch/powerpc/boot/dts/ebony.dts
+++ b/arch/powerpc/boot/dts/ebony.dts
@@ -18,6 +18,13 @@
 	compatible = "ibm,ebony";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/ep405.dts b/arch/powerpc/boot/dts/ep405.dts
index 16cfc0d..9293855 100644
--- a/arch/powerpc/boot/dts/ep405.dts
+++ b/arch/powerpc/boot/dts/ep405.dts
@@ -16,6 +16,12 @@
 	compatible = "ep405";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 824cf4e..350e70e 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -19,6 +19,13 @@
 	compatible = "amcc,katmai";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		serial0 = &UART0;
+		serial1 = &UART1;
+		serial2 = &UART2;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 0a3fbfa..3814199 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -15,6 +15,13 @@
 	compatible = "amcc,kilauea";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index 63d996e..b2e8231 100644
--- a/arch/powerpc/boot/dts/rainier.dts
+++ b/arch/powerpc/boot/dts/rainier.dts
@@ -19,6 +19,15 @@
 	compatible = "amcc,rainier";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+		serial2 = &UART2;
+		serial3 = &UART3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -93,7 +102,7 @@
 		#size-cells = <1>;
 		ranges;
 		clock-frequency = <0>; /* Filled in by zImage */
-		
+
 		SDRAM0: sdram {
 			compatible = "ibm,sdram-440grx", "ibm,sdram-44x-ddr2denali";
 			dcr-reg = <010 2>;
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index dbb1b3b..fb88028 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -19,6 +19,15 @@
 	compatible = "amcc,sequoia";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC0;
+		ethernet1 = &EMAC1;
+		serial0 = &UART0;
+		serial1 = &UART1;
+		serial2 = &UART2;
+		serial3 = &UART3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 0dec702..0706a4a 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -17,6 +17,13 @@
 	compatible = "amcc,taishan";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC2;
+		ethernet1 = &EMAC3;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/walnut.dts b/arch/powerpc/boot/dts/walnut.dts
index 8fcf6aa..0e3825e 100644
--- a/arch/powerpc/boot/dts/walnut.dts
+++ b/arch/powerpc/boot/dts/walnut.dts
@@ -16,6 +16,12 @@
 	compatible = "ibm,walnut";
 	dcr-parent = <&/cpus/cpu@0>;
 
+	aliases {
+		ethernet0 = &EMAC;
+		serial0 = &UART0;
+		serial1 = &UART1;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.5.3.7.949.g2221a6
