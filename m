Return-Path: <Emilian.Medve@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0145.outbound.protection.outlook.com [65.55.169.145])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3631A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Nov 2014 02:57:33 +1100 (AEDT)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: <scottwood@Freescale.com>, <yuantian.tang@Freescale.com>,
 <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] powerpc/dts: Add node(s) for the platform PLL
Date: Thu, 6 Nov 2014 09:48:13 -0600
Message-ID: <1415288893-4457-3-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1415288893-4457-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1415288893-4457-1-git-send-email-Emilian.Medve@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
Change-Id: If76cd705a01813abe53396c1486bc13c4289ee92
---
 arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi | 7 +++++++
 arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
index 4871048..4ece1ed 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen1.dtsi
@@ -75,4 +75,11 @@ global-utilities@e1000 {
 		clock-names = "pll0", "pll0-div2", "pll1", "pll1-div2";
 		clock-output-names = "cmux1";
 	};
+	platform_pll: platform-pll@c00 {
+		#clock-cells = <1>;
+		reg = <0xc00 0x4>;
+		compatible = "fsl,qoriq-platform-pll-1.0";
+		clocks = <&sysclk>;
+		clock-output-names = "platform-pll", "platform-pll-div2";
+	};
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
index 5d18d2a..48e0b6e 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-clockgen2.dtsi
@@ -58,4 +58,11 @@ global-utilities@e1000 {
 		clocks = <&sysclk>;
 		clock-output-names = "pll1", "pll1-div2", "pll1-div4";
 	};
+	platform_pll: platform-pll@c00 {
+		#clock-cells = <1>;
+		reg = <0xc00 0x4>;
+		compatible = "fsl,qoriq-platform-pll-2.0";
+		clocks = <&sysclk>;
+		clock-output-names = "platform-pll", "platform-pll-div2";
+	};
 };
-- 
2.1.3
