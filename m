Return-Path: <Zhiqiang.Hou@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0139.outbound.protection.outlook.com [65.55.169.139])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7175E1A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 19:37:15 +1100 (AEDT)
From: Zhiqiang Hou <Zhiqiang.Hou@freescale.com>
To: <devicetree@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <robh+dt@kernel.org>, <ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>
CC: <benh@kernel.crashing.org>, <scottwood@freescale.com>,
 <Mingkai.Hu@freescale.com>, Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
Subject: [PATCH] dts/spi: Change compatible to use right device name
Date: Wed, 13 Jan 2016 15:54:46 +0800
Message-ID: <1452671686-2693-1-git-send-email-Zhiqiang.Hou@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

On the t208xrdb and t1040rdb, the SPI devices is n25q512ax3
instead of n25q512a.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t104xrdb.dtsi | 2 +-
 arch/powerpc/boot/dts/fsl/t208xrdb.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
index 830ea48..27758ff 100644
--- a/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t104xrdb.dtsi
@@ -103,7 +103,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512a";
+				compatible = "micron,n25q512ax3";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clock */
 			};
diff --git a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
index 693d2a8..4a17150 100644
--- a/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t208xrdb.dtsi
@@ -113,7 +113,7 @@
 			flash@0 {
 				#address-cells = <1>;
 				#size-cells = <1>;
-				compatible = "micron,n25q512a";
+				compatible = "micron,n25q512ax3";
 				reg = <0>;
 				spi-max-frequency = <10000000>; /* input clock */
 			};
-- 
2.1.0.27.g96db324
