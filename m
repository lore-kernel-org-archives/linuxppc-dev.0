Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 31DF3DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 12:38:06 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] 5200 dts: add default address and size cells to soc node.
Date: Fri, 25 Jan 2008 15:33:20 -0500
Message-Id: <1201293200-32031-1-git-send-email-paul.gortmaker@windriver.com>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The various 5200 dts files don't have values specified for the soc
node, which in turn results in a warning from the processing of
every child node (roughly 40 warnings per file).  This explicitly
sets the default values and gets rid of all the warnings.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/boot/dts/cm5200.dts    |    2 ++
 arch/powerpc/boot/dts/lite5200.dts  |    2 ++
 arch/powerpc/boot/dts/lite5200b.dts |    2 ++
 arch/powerpc/boot/dts/motionpro.dts |    2 ++
 arch/powerpc/boot/dts/tqm5200.dts   |    2 ++
 5 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/cm5200.dts b/arch/powerpc/boot/dts/cm5200.dts
index 9295083..2b88a58 100644
--- a/arch/powerpc/boot/dts/cm5200.dts
+++ b/arch/powerpc/boot/dts/cm5200.dts
@@ -45,6 +45,8 @@
 	};
 
 	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		model = "fsl,mpc5200b";
 		compatible = "fsl,mpc5200b";
 		revision = "";			// from bootloader
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index e1d6f44..7de3d21 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -46,6 +46,8 @@
 	};
 
 	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		model = "fsl,mpc5200";
 		compatible = "mpc5200";
 		revision = "";			// from bootloader
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 3e06f58..dd2c4fd 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -46,6 +46,8 @@
 	};
 
 	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		model = "fsl,mpc5200b";
 		compatible = "mpc5200";
 		revision = "";			// from bootloader
diff --git a/arch/powerpc/boot/dts/motionpro.dts b/arch/powerpc/boot/dts/motionpro.dts
index d8c316a..ee30805 100644
--- a/arch/powerpc/boot/dts/motionpro.dts
+++ b/arch/powerpc/boot/dts/motionpro.dts
@@ -45,6 +45,8 @@
 	};
 
 	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		model = "fsl,mpc5200b";
 		compatible = "fsl,mpc5200b";
 		revision = "";			// from bootloader
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 5017cec..58c9799 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -45,6 +45,8 @@
 	};
 
 	soc5200@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
 		model = "fsl,mpc5200";
 		compatible = "fsl,mpc5200";
 		revision = "";			// from bootloader
-- 
1.5.4.rc4.gcab31
