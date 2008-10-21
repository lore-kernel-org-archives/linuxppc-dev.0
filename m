Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7ED66DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 05:58:46 +1100 (EST)
Date: Tue, 21 Oct 2008 22:58:44 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts files
Message-ID: <20081021185844.GA31070@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Cc: Scott Wood <scottwood@freescale.com>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We don't want to encourage the device_type usage. It isn't used in the
code, so we can simply remove it from the dts files.

Suggested-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/kuroboxHD.dts      |    1 -
 arch/powerpc/boot/dts/kuroboxHG.dts      |    1 -
 arch/powerpc/boot/dts/lite5200.dts       |    1 -
 arch/powerpc/boot/dts/lite5200b.dts      |    1 -
 arch/powerpc/boot/dts/motionpro.dts      |    1 -
 arch/powerpc/boot/dts/mpc8315erdb.dts    |    1 -
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    1 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    1 -
 arch/powerpc/boot/dts/mpc8377_rdb.dts    |    1 -
 arch/powerpc/boot/dts/mpc8378_rdb.dts    |    1 -
 arch/powerpc/boot/dts/mpc8379_rdb.dts    |    1 -
 arch/powerpc/boot/dts/pcm030.dts         |    2 --
 arch/powerpc/boot/dts/tqm5200.dts        |    1 -
 13 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 2e5a1a1..8d725d1 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -76,7 +76,6 @@ XXXX add flash parts, rtc, ??
 			interrupt-parent = <&mpic>;
 
 			rtc@32 {
-				device_type = "rtc";
 				compatible = "ricoh,rs5c372a";
 				reg = <0x32>;
 			};
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index e4916e6..b13a11e 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -76,7 +76,6 @@ XXXX add flash parts, rtc, ??
 			interrupt-parent = <&mpic>;
 
 			rtc@32 {
-				device_type = "rtc";
 				compatible = "ricoh,rs5c372a";
 				reg = <0x32>;
 			};
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 2cf9a87..3f7a5dc 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -130,7 +130,6 @@
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200-rtc";
-			device_type = "rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 7bd5b9c..63e3bb4 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -130,7 +130,6 @@
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
-			device_type = "rtc";
 			reg = <0x800 0x100>;
 			interrupts = <1 5 0 1 6 0>;
 			interrupt-parent = <&mpc5200_pic>;
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index 9e3c921..52ba6f9 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -248,7 +248,6 @@
 			fsl5200-clocking;
 
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index 6b85067..d3d3097 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -117,7 +117,6 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 2c9d54a..d86c6a3 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -85,7 +85,6 @@
 			dfsrr;
 
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 				interrupts = <18 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index fa40647..fd4bbc4 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -83,7 +83,6 @@
 			dfsrr;
 
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 				interrupts = <18 0x8>;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 435ef3d..9fe8e4c 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -117,7 +117,6 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index b11e68f..3a6d528 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -117,7 +117,6 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 337af6e..ee64def 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -117,7 +117,6 @@
 			interrupt-parent = <&ipic>;
 			dfsrr;
 			rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1339";
 				reg = <0x68>;
 			};
diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index 7c1bb95..be2c11c 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -143,7 +143,6 @@
 
 		rtc@800 {	// Real time clock
 			compatible = "fsl,mpc5200b-rtc","fsl,mpc5200-rtc";
-			device_type = "rtc";
 			reg = <0x800 0x100>;
 			interrupts = <0x1 0x5 0x0 0x1 0x6 0x0>;
 			interrupt-parent = <&mpc5200_pic>;
@@ -301,7 +300,6 @@
 			interrupt-parent = <&mpc5200_pic>;
 			fsl5200-clocking;
 			rtc@51 {
-				device_type = "rtc";
 				compatible = "nxp,pcf8563";
 				reg = <0x51>;
 			};
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 3008bf8..906302e 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -181,7 +181,6 @@
 			fsl5200-clocking;
 
 			 rtc@68 {
-				device_type = "rtc";
 				compatible = "dallas,ds1307";
 				reg = <0x68>;
 			};
-- 
1.5.6.3
