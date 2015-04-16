Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0101.outbound.protection.outlook.com [207.46.100.101])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CECC01A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 02:17:22 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Move pll0/1-div4 index
Date: Thu, 16 Apr 2015 15:08:25 +0300
Message-ID: <1429186105-6991-1-git-send-email-igal.liberman@freescale.com>
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

This patch updates pll0/1-div4 index to '3'.
Originally it was '2'.

The following patch adds pll0/1-div3 option:
	https://patchwork.ozlabs.org/patch/461151/
After this patch, index '2' becomes pll0/1-div3.

This patch based on top of the following:
	https://patchwork.ozlabs.org/patch/461811/

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    |    4 ++--
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi |    8 ++++----
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 8d061a4..d6c410d 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -446,8 +446,8 @@
 			#clock-cells = <0>;
 			reg = <0x0 0x4>;
 			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 3>,
+				<&pll1 0>, <&pll1 1>, <&pll1 3>;
 			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4";
 			clock-output-names = "cmux0";
diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 1462431..e347f2d 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -587,8 +587,8 @@
 			#clock-cells = <0>;
 			reg = <0x0 4>;
 			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 3>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 3>;
 			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4";
 			clock-output-names = "cmux0";
@@ -598,8 +598,8 @@
 			#clock-cells = <0>;
 			reg = <0x20 4>;
 			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 3>,
+				 <&pll1 0>, <&pll1 1>, <&pll1 3>;
 			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4";
 			clock-output-names = "cmux1";
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 1c91d00..1fdce44 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -1099,8 +1099,8 @@
 			#clock-cells = <0>;
 			reg = <0x0 0x4>;
 			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>,
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 3>,
+				<&pll1 0>, <&pll1 1>, <&pll1 3>,
 				<&pll2 0>, <&pll2 1>, <&pll2 2>;
 			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4",
@@ -1112,8 +1112,8 @@
 			#clock-cells = <0>;
 			reg = <0x20 0x4>;
 			compatible = "fsl,qoriq-core-mux-2.0";
-			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
-				<&pll1 0>, <&pll1 1>, <&pll1 2>,
+			clocks = <&pll0 0>, <&pll0 1>, <&pll0 3>,
+				<&pll1 0>, <&pll1 1>, <&pll1 3>,
 				<&pll2 0>, <&pll2 1>, <&pll2 2>;
 			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4",
-- 
1.7.9.5
