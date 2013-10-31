Return-Path: <B42378@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D4F822C044D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 00:44:51 +1100 (EST)
From: Nicolin Chen <b42378@freescale.com>
To: <timur@tabi.org>, <shawn.guo@linaro.org>, <broonie@kernel.org>,
 <s.hauer@pengutronix.de>
Subject: [PATCH v4 4/4] ARM: dts: imx: use dual-fifo sdma script for ssi
Date: Thu, 31 Oct 2013 21:44:16 +0800
Message-ID: <6a0d22c80eadc0ec9008264bb71d00d67932f5cc.1383226444.git.b42378@freescale.com>
In-Reply-To: <cover.1383226444.git.b42378@freescale.com>
References: <cover.1383226444.git.b42378@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org,
 swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rob.herring@calxeda.com,
 dmaengine@vger.kernel.org, ijc+devicetree@hellion.org.uk,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use dual-fifo sdma scripts instead of shared scripts for ssi on i.MX series.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 arch/arm/boot/dts/imx51.dtsi   |  4 ++--
 arch/arm/boot/dts/imx53.dtsi   |  4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++++------
 arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++++------
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 54cee65..1a71eac 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -154,8 +154,8 @@
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..7208fde 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -153,8 +153,8 @@
 					reg = <0x50014000 0x4000>;
 					interrupts = <30>;
 					clocks = <&clks 49>;
-					dmas = <&sdma 24 1 0>,
-					       <&sdma 25 1 0>;
+					dmas = <&sdma 24 22 0>,
+					       <&sdma 25 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <25 24 23 22>; /* TX0 RX0 TX1 RX1 */
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 57e9c38..6e096ca 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -223,8 +223,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks 178>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <38 37>;
@@ -236,8 +236,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks 179>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <42 41>;
@@ -249,8 +249,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks 180>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					fsl,ssi-dma-events = <46 45>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c46651e..b32ba99 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -195,8 +195,8 @@
 					reg = <0x02028000 0x4000>;
 					interrupts = <0 46 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI1>;
-					dmas = <&sdma 37 1 0>,
-					       <&sdma 38 1 0>;
+					dmas = <&sdma 37 22 0>,
+					       <&sdma 38 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -207,8 +207,8 @@
 					reg = <0x0202c000 0x4000>;
 					interrupts = <0 47 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI2>;
-					dmas = <&sdma 41 1 0>,
-					       <&sdma 42 1 0>;
+					dmas = <&sdma 41 22 0>,
+					       <&sdma 42 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
@@ -219,8 +219,8 @@
 					reg = <0x02030000 0x4000>;
 					interrupts = <0 48 0x04>;
 					clocks = <&clks IMX6SL_CLK_SSI3>;
-					dmas = <&sdma 45 1 0>,
-					       <&sdma 46 1 0>;
+					dmas = <&sdma 45 22 0>,
+					       <&sdma 46 22 0>;
 					dma-names = "rx", "tx";
 					fsl,fifo-depth = <15>;
 					status = "disabled";
-- 
1.8.4
