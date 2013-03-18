Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A6BA72C0201
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Mar 2013 06:11:18 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/fsl-booke: Update DCSR EPU device tree entries
Date: Mon, 18 Mar 2013 14:11:10 -0500
Message-Id: <1363633870-3894-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1363633870-3894-1-git-send-email-galak@kernel.crashing.org>
References: <1363633870-3894-1-git-send-email-galak@kernel.crashing.org>
Cc: Stephen George <Stephen.George@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Stephen George <Stephen.George@freescale.com>

Identifies the epu as compatible with Chassis v1 Debug IP.

Signed-off-by: Stephen George <Stephen.George@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi |    2 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi |    2 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    2 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi |    2 +-
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 69ac1ac..dc6cc5a 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -155,7 +155,7 @@
 	compatible = "fsl,dcsr", "simple-bus";
 
 	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
+		compatible = "fsl,p2041-dcsr-epu", "fsl,dcsr-epu";
 		interrupts = <52 2 0 0
 			      84 2 0 0
 			      85 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 9b5a81a..3fa1e22 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -182,7 +182,7 @@
 	compatible = "fsl,dcsr", "simple-bus";
 
 	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
+		compatible = "fsl,p3041-dcsr-epu", "fsl,dcsr-epu";
 		interrupts = <52 2 0 0
 			      84 2 0 0
 			      85 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 19859ad..34769a7 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -156,7 +156,7 @@
 	compatible = "fsl,dcsr", "simple-bus";
 
 	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
+		compatible = "fsl,p4080-dcsr-epu", "fsl,dcsr-epu";
 		interrupts = <52 2 0 0
 			      84 2 0 0
 			      85 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 9ea77c3..bc3ae5a 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -184,7 +184,7 @@
 	compatible = "fsl,dcsr", "simple-bus";
 
 	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
+		compatible = "fsl,p5020-dcsr-epu", "fsl,dcsr-epu";
 		interrupts = <52 2 0 0
 			      84 2 0 0
 			      85 2 0 0>;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 97f8c26..a91897f 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -129,7 +129,7 @@
 	compatible = "fsl,dcsr", "simple-bus";
 
 	dcsr-epu@0 {
-		compatible = "fsl,dcsr-epu";
+		compatible = "fsl,p5040-dcsr-epu", "fsl,dcsr-epu";
 		interrupts = <52 2 0 0
 			      84 2 0 0
 			      85 2 0 0>;
-- 
1.7.9.7
