Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0103.outbound.protection.outlook.com [157.56.111.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF1241A0021
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2015 02:02:25 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Fix incorrect clock-names property
Date: Thu, 16 Apr 2015 14:53:36 +0300
Message-ID: <1429185216-6856-1-git-send-email-igal.liberman@freescale.com>
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

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 3dee307..1462431 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -589,7 +589,7 @@
 			compatible = "fsl,qoriq-core-mux-2.0";
 			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
 				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll1-div4",
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4";
 			clock-output-names = "cmux0";
 		};
@@ -600,7 +600,7 @@
 			compatible = "fsl,qoriq-core-mux-2.0";
 			clocks = <&pll0 0>, <&pll0 1>, <&pll0 2>,
 				 <&pll1 0>, <&pll1 1>, <&pll1 2>;
-			clock-names = "pll0", "pll0-div2", "pll1-div4",
+			clock-names = "pll0", "pll0-div2", "pll0-div4",
 				"pll1", "pll1-div2", "pll1-div4";
 			clock-output-names = "cmux1";
 		};
-- 
1.7.9.5
