Return-Path: <Diana.Craciun@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CC1E614135A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 00:56:35 +1000 (EST)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: Updated corenet-cf compatible string for
 corenet1-cf chips
Date: Tue, 6 May 2014 17:56:16 +0300
Message-ID: <1399388176-25257-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, devicetree@vger.kernel.org,
 Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

Updated the device trees according to the corenet-cf
binding definition.

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index e2987a3..b5daa4c 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -246,7 +246,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet1-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index 7af6d45..5abd1fc 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -273,7 +273,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet1-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 2415e1f..bf0e7c9 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -281,7 +281,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet1-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 2985de4..f7ca9f4 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -278,7 +278,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet1-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
-- 
1.7.11.7
