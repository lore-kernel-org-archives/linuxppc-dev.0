Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0142.outbound.protection.outlook.com [157.56.110.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419441A0C47
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Apr 2015 20:30:58 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Add some SoC specific "fsl,
 *-device-config" compatibles
Date: Thu, 9 Apr 2015 09:21:22 +0300
Message-ID: <1428560482-30938-1-git-send-email-igal.liberman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Igal Liberman <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Igal Liberman <Igal.Liberman@freescale.com>

This patch is required for: https://patchwork.ozlabs.org/patch/459584/

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |    3 ++-
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |    3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 1ea8602..9b14f24 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -77,7 +77,8 @@
 	};
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
+		compatible = "fsl,b4420-device-config", "fsl,b4-device-config",
+			      "fsl,qoriq-device-config-2.0";
 	};
 
 	global-utilities@e1000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index 02ccde6..74a9f5f 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -248,7 +248,8 @@
 	};
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,b4860-device-config", "fsl,qoriq-device-config-2.0";
+		compatible = "fsl,b4860-device-config", "fsl,b4-device-config",
+			     "fsl,qoriq-device-config-2.0";
 	};
 
 	global-utilities@e1000 {
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index f8c325e..babb076 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -391,7 +391,8 @@
 /include/ "qoriq-mpic4.3.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,b4-device-config";
+		compatible = "fsl,b4-device-config",
+			      "fsl,qoriq-device-config-2.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		fsl,liodn-bits = <12>;
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 1f18b8b..a7ae5ae 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -311,7 +311,8 @@
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,qoriq-device-config-1.0";
+		compatible = "fsl,p2041-device-config",
+			      "fsl,qoriq-device-config-1.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index a555d24..89d08d6 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -338,7 +338,8 @@
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,qoriq-device-config-1.0";
+		compatible = "fsl,p3041-device-config",
+			      "fsl,qoriq-device-config-1.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 0fe7281..1863d6a 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -358,7 +358,8 @@
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,qoriq-device-config-1.0";
+		compatible = "fsl,p4080-device-config",
+			      "fsl,qoriq-device-config-1.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index a34ca20..d979d01 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -343,7 +343,8 @@
 /include/ "qoriq-mpic.dtsi"
 
 	guts: global-utilities@e0000 {
-		compatible = "fsl,qoriq-device-config-1.0";
+		compatible = "fsl,p5020-device-config",
+			      "fsl,qoriq-device-config-1.0";
 		reg = <0xe0000 0xe00>;
 		fsl,has-rstcr;
 		#sleep-cells = <1>;
-- 
1.7.9.5
