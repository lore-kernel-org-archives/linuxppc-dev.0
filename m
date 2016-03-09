Return-Path: <Zhiqiang.Hou@nxp.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0089.outbound.protection.outlook.com [65.55.169.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CF6B1A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 22:32:28 +1100 (AEDT)
From: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>,
 <galak@codeaurora.org>, <benh@kernel.crashing.org>, <scottwood@freescale.com>
CC: <Mingkai.Hu@freescale.com>, Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
Subject: [PATCH v2] dts/fsl/powerpc: add "jedec,
 spi-nor" flash compatible binding
Date: Wed, 9 Mar 2016 17:50:55 +0800
Message-ID: <1457517055-6629-1-git-send-email-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Starting with commit <8947e396a829> ("Documentation: dt: mtd:
replace "nor-jedec" binding with "jedec, spi-nor"") we have
"jedec,spi-nor" binding indicating support for JEDEC identification.

Use it for all flashes that are supposed to support READ ID op
according to the datasheets.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
---
v2:
 - Correct the copy-paste error of node flash@2 in t208xqds.dtsi.

 arch/powerpc/boot/dts/fsl/b4qds.dtsi       | 2 +-
 arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi  | 2 +-
 arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi  | 2 +-
 arch/powerpc/boot/dts/fsl/c293pcie.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/kmcoge4.dts      | 4 ++--
 arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi   | 8 ++++----
 arch/powerpc/boot/dts/fsl/mvme2500.dts     | 4 ++--
 arch/powerpc/boot/dts/fsl/p1010rdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts  | 2 +-
 arch/powerpc/boot/dts/fsl/p1020rdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/p1021mds.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p1022ds.dtsi     | 2 +-
 arch/powerpc/boot/dts/fsl/p1022rdk.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/p1024rdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/p1025rdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p2020rdb.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/p2041rdb.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/p3041ds.dts      | 2 +-
 arch/powerpc/boot/dts/fsl/p4080ds.dts      | 2 +-
 arch/powerpc/boot/dts/fsl/p5020ds.dts      | 2 +-
 arch/powerpc/boot/dts/fsl/p5040ds.dts      | 2 +-
 arch/powerpc/boot/dts/fsl/t1023rdb.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/t1024qds.dts     | 6 +++---
 arch/powerpc/boot/dts/fsl/t1024rdb.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi  | 2 +-
 arch/powerpc/boot/dts/fsl/t104xqds.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/t208xqds.dtsi    | 6 +++---
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/t4240qds.dts     | 2 +-
 arch/powerpc/boot/dts/fsl/t4240rdb.dts     | 2 +-
 34 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4qds.dtsi b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
index 6455774..823824c 100644
--- a/arch/powerpc/boot/dts/fsl/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4qds.dtsi
@@ -135,7 +135,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "sst,sst25wf040";
+				compatible = "sst,sst25wf040", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi
index f4d96d2..53f8b95 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9131rdb.dtsi
@@ -53,7 +53,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <50000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi b/arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi
index 7a13bf2..fead484 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9132qds.dtsi
@@ -55,7 +55,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <30000000>;
 		};
diff --git a/arch/powerpc/boot/dts/fsl/c293pcie.dts b/arch/powerpc/boot/dts/fsl/c293pcie.dts
index 53ab4db..6670978 100644
--- a/arch/powerpc/boot/dts/fsl/c293pcie.dts
+++ b/arch/powerpc/boot/dts/fsl/c293pcie.dts
@@ -167,7 +167,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <50000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/kmcoge4.dts b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
index 6858ec9..2d4b64f 100644
--- a/arch/powerpc/boot/dts/fsl/kmcoge4.dts
+++ b/arch/powerpc/boot/dts/fsl/kmcoge4.dts
@@ -63,7 +63,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25fl256s1";
+				compatible = "spansion,s25fl256s1", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <20000000>; /* input clock */
 			};
@@ -77,7 +77,7 @@
 			flash@2 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,m25p32";
+				compatible = "micron,m25p32", "jedec,spi-nor";
 				reg = <2>;
 				spi-max-frequency = <15000000>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi
index 937ad7e..a925fe4 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536ds.dtsi
@@ -142,7 +142,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
 			partition@u-boot {
@@ -166,17 +166,17 @@
 			};
 		};
 		flash@1 {
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <1>;
 			spi-max-frequency = <40000000>;
 		};
 		flash@2 {
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <2>;
 			spi-max-frequency = <40000000>;
 		};
 		flash@3 {
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <3>;
 			spi-max-frequency = <40000000>;
 		};
diff --git a/arch/powerpc/boot/dts/fsl/mvme2500.dts b/arch/powerpc/boot/dts/fsl/mvme2500.dts
index c7bc1a0..69559e9 100644
--- a/arch/powerpc/boot/dts/fsl/mvme2500.dts
+++ b/arch/powerpc/boot/dts/fsl/mvme2500.dts
@@ -70,12 +70,12 @@
 			fsl,espi-num-chipselects = <2>;
 
 			flash@0 {
-				compatible = "atmel,at25df641";
+				compatible = "atmel,at25df641", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>;
 			};
 			flash@1 {
-				compatible = "atmel,at25df641";
+				compatible = "atmel,at25df641", "jedec,spi-nor";
 				reg = <1>;
 				spi-max-frequency = <10000000>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
index 14b6295..a8e4ba0 100644
--- a/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010rdb.dtsi
@@ -110,7 +110,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
index c952cd3..25f81ee 100644
--- a/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pc.dtsi
@@ -151,7 +151,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
index 740553c..f2dc6c0 100644
--- a/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb-pd.dts
@@ -155,7 +155,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				/* input clock */
 				spi-max-frequency = <40000000>;
diff --git a/arch/powerpc/boot/dts/fsl/p1020rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1020rdb.dtsi
index 1fb7e0e..703142e 100644
--- a/arch/powerpc/boot/dts/fsl/p1020rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020rdb.dtsi
@@ -148,7 +148,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p1021mds.dts b/arch/powerpc/boot/dts/fsl/p1021mds.dts
index 27fdfd7..291454c 100644
--- a/arch/powerpc/boot/dts/fsl/p1021mds.dts
+++ b/arch/powerpc/boot/dts/fsl/p1021mds.dts
@@ -123,7 +123,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
index e8a0f95..18f9b31 100644
--- a/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021rdb-pc.dtsi
@@ -150,7 +150,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p1022ds.dtsi b/arch/powerpc/boot/dts/fsl/p1022ds.dtsi
index 149da0f..ddefbf6 100644
--- a/arch/powerpc/boot/dts/fsl/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022ds.dtsi
@@ -160,7 +160,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p1022rdk.dts b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
index 04c1633..d505d7c 100644
--- a/arch/powerpc/boot/dts/fsl/p1022rdk.dts
+++ b/arch/powerpc/boot/dts/fsl/p1022rdk.dts
@@ -86,7 +86,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,m25p80";
+				compatible = "spansion,m25p80", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <1000000>;
 				partition@0 {
diff --git a/arch/powerpc/boot/dts/fsl/p1024rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1024rdb.dtsi
index b05dcb4..b4d0586 100644
--- a/arch/powerpc/boot/dts/fsl/p1024rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1024rdb.dtsi
@@ -129,7 +129,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,m25p80";
+			compatible = "spansion,m25p80", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi b/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
index f502564..d44bb12 100644
--- a/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1025rdb.dtsi
@@ -137,7 +137,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,s25sl12801";
+			compatible = "spansion,s25sl12801", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>; /* input clock */
 
diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi b/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
index ad2e242..03c9afc 100644
--- a/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb-pc.dtsi
@@ -151,7 +151,7 @@
 		flash@0 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "spansion,m25p80";
+			compatible = "spansion,m25p80", "jedec,spi-nor";
 			reg = <0>;
 			spi-max-frequency = <40000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/p2020rdb.dts b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
index 70cf090..435a319 100644
--- a/arch/powerpc/boot/dts/fsl/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2020rdb.dts
@@ -155,7 +155,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>;
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041rdb.dts b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
index e9bd894..10bdf5d 100644
--- a/arch/powerpc/boot/dts/fsl/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/p2041rdb.dts
@@ -83,7 +83,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
diff --git a/arch/powerpc/boot/dts/fsl/p3041ds.dts b/arch/powerpc/boot/dts/fsl/p3041ds.dts
index f2b1d40..09a8220 100644
--- a/arch/powerpc/boot/dts/fsl/p3041ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p3041ds.dts
@@ -83,7 +83,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <35000000>; /* input clock */
 				partition@u-boot {
diff --git a/arch/powerpc/boot/dts/fsl/p4080ds.dts b/arch/powerpc/boot/dts/fsl/p4080ds.dts
index 28a55c5..94bf5c5 100644
--- a/arch/powerpc/boot/dts/fsl/p4080ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p4080ds.dts
@@ -84,7 +84,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
diff --git a/arch/powerpc/boot/dts/fsl/p5020ds.dts b/arch/powerpc/boot/dts/fsl/p5020ds.dts
index 920dc77..23f1f71 100644
--- a/arch/powerpc/boot/dts/fsl/p5020ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5020ds.dts
@@ -83,7 +83,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
diff --git a/arch/powerpc/boot/dts/fsl/p5040ds.dts b/arch/powerpc/boot/dts/fsl/p5040ds.dts
index e169cc2..e50952a 100644
--- a/arch/powerpc/boot/dts/fsl/p5040ds.dts
+++ b/arch/powerpc/boot/dts/fsl/p5040ds.dts
@@ -83,7 +83,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
+				compatible = "spansion,s25sl12801", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 				partition@u-boot {
diff --git a/arch/powerpc/boot/dts/fsl/t1023rdb.dts b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
index 6bd842b..0fcce8b 100644
--- a/arch/powerpc/boot/dts/fsl/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1023rdb.dts
@@ -79,7 +79,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "spansion,s25fl512s";
+				compatible = "spansion,s25fl512s", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clk */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t1024qds.dts b/arch/powerpc/boot/dts/fsl/t1024qds.dts
index 6a3581b..772143d 100644
--- a/arch/powerpc/boot/dts/fsl/t1024qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024qds.dts
@@ -87,7 +87,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q128a11";  /* 16MB */
+				compatible = "micron,n25q128a11", "jedec,spi-nor";  /* 16MB */
 				reg = <0>;
 				spi-max-frequency = <10000000>;
 			};
@@ -95,7 +95,7 @@
 			flash@1 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "sst,sst25wf040";  /* 512KB */
+				compatible = "sst,sst25wf040", "jedec,spi-nor";  /* 512KB */
 				reg = <1>;
 				spi-max-frequency = <10000000>;
 			};
@@ -103,7 +103,7 @@
 			flash@2 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "eon,en25s64";   /* 8MB */
+				compatible = "eon,en25s64", "jedec,spi-nor";   /* 8MB */
 				reg = <2>;
 				spi-max-frequency = <10000000>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t1024rdb.dts b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
index 0ccc7d0..4bf80b3 100644
--- a/arch/powerpc/boot/dts/fsl/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t1024rdb.dts
@@ -89,7 +89,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512ax3";
+				compatible = "micron,n25q512ax3", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clk */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
index 3f6d7c6..8c7ea6c 100644
--- a/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xd4rdb.dtsi
@@ -104,7 +104,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512ax3";
+				compatible = "micron,n25q512ax3", "jedec,spi-nor";
 				reg = <0>;
 				/* input clock */
 				spi-max-frequency = <10000000>;
diff --git a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
index 1498d1e..636a73e 100644
--- a/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xqds.dtsi
@@ -112,7 +112,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q128a11";
+				compatible = "micron,n25q128a11", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 830ea48..5b5978f 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -103,7 +103,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512a";
+				compatible = "micron,n25q512a", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
index 869f915..ec080bd 100644
--- a/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xqds.dtsi
@@ -112,7 +112,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q128a11"; /* 16MB */
+				compatible = "micron,n25q128a11", "jedec,spi-nor"; /* 16MB */
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 			};
@@ -120,7 +120,7 @@
 			flash@1 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "sst,sst25wf040";
+				compatible = "sst,sst25wf040", "jedec,spi-nor";
 				reg = <1>;
 				spi-max-frequency = <35000000>;
 			};
@@ -128,7 +128,7 @@
 			flash@2 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "eon,en25s64";
+				compatible = "eon,en25s64", "jedec,spi-nor";
 				reg = <2>;
 				spi-max-frequency = <35000000>;
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
index 693d2a8..dc93268 100644
--- a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
@@ -113,7 +113,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512a";
+				compatible = "micron,n25q512a", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t4240qds.dts b/arch/powerpc/boot/dts/fsl/t4240qds.dts
index c067a65..80db7c7 100644
--- a/arch/powerpc/boot/dts/fsl/t4240qds.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240qds.dts
@@ -138,7 +138,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "sst,sst25wf040";
+				compatible = "sst,sst25wf040", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t4240rdb.dts b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
index 6e820a8..cd1307a 100644
--- a/arch/powerpc/boot/dts/fsl/t4240rdb.dts
+++ b/arch/powerpc/boot/dts/fsl/t4240rdb.dts
@@ -107,7 +107,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "sst,sst25wf040";
+				compatible = "sst,sst25wf040", "jedec,spi-nor";
 				reg = <0>;
 				spi-max-frequency = <40000000>; /* input clock */
 			};
-- 
2.1.0.27.g96db324
