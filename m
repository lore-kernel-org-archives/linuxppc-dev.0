Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0135.outbound.protection.outlook.com [157.56.111.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14C711A0176
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 00:04:08 +1000 (AEST)
From: Igal.Liberman <igal.liberman@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Update the core cluster PLL node(s)
Date: Tue, 14 Apr 2015 12:55:06 +0300
Message-ID: <1429005306-24544-1-git-send-email-igal.liberman@freescale.com>
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

This patch replaces the following:
	https://patchwork.ozlabs.org/patch/427664/

This patch is described by the following binding document update:
	https://patchwork.ozlabs.org/patch/461150/

Signed-off-by: Igal Liberman <Igal.Liberman@freescale.com>
---
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
index 48e0b6e..7e1f074 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
@@ -49,14 +49,16 @@ global-utilities@e1000 {
 		reg = <0x800 0x4>;
 		compatible = "fsl,qoriq-core-pll-2.0";
 		clocks = <&sysclk>;
-		clock-output-names = "pll0", "pll0-div2", "pll0-div4";
+		clock-output-names = "pll0", "pll0-div2", "pll0-div3",
+				      "pll0-div4";
 	};
 	pll1: pll1@820 {
 		#clock-cells = <1>;
 		reg = <0x820 0x4>;
 		compatible = "fsl,qoriq-core-pll-2.0";
 		clocks = <&sysclk>;
-		clock-output-names = "pll1", "pll1-div2", "pll1-div4";
+		clock-output-names = "pll1", "pll1-div2", "pll1-div3",
+				      "pll1-div4";
 	};
 	platform_pll: platform-pll@c00 {
 		#clock-cells = <1>;
-- 
1.7.9.5
