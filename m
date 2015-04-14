Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0133.outbound.protection.outlook.com [65.55.169.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C45E1A0176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 00:34:31 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [v2] powerpc/dts: Add some SoC specific "fsl,
 *-device-config" compatibles
Date: Tue, 14 Apr 2015 13:25:23 +0300
Message-ID: <1429007123-24649-1-git-send-email-igal.liberman@freescale.com>
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

This patch adds "fsl,<chip>-device-config" compatibles to guts node.
The added compatibles used in Freescale FMan clock initialization.
 
This patches is described by the following binding document update:
	https://patchwork.ozlabs.org/patch/461153/

v2: Updated commit message

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
