Return-Path: <B36685@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0ECFFB6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 16:44:35 +1100 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <stable@kernel.org>
Subject: [PATCH v2] powerpc/dts: fix the compatible string of sec 4.0
Date: Wed, 7 Mar 2012 13:20:06 +0800
Message-ID: <1331097606-22407-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Liu Shuo <shuo.liu@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Liu Shuo <shuo.liu@freescale.com>

Fix the compatible string of sec 4.0 to match with CAMM driver according
to Documentation/devicetree/bindings/crypto/fsl-sec4.txt

Signed-off-by: Liu Shuo <shuo.liu@freescale.com>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
v2: refine description.

 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
index bf957a7..d4c9d5d 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
@@ -33,32 +33,32 @@
  */
 
 crypto@30000 {
-	compatible = "fsl,sec4.4", "fsl,sec4.0";
+	compatible = "fsl,sec-v4.4", "fsl,sec-v4.0";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	reg		 = <0x30000 0x10000>;
 	interrupts	 = <58 2 0 0>;
 
 	sec_jr0: jr@1000 {
-		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		compatible = "fsl,sec-v4.4-job-ring", "fsl,sec-v4.0-job-ring";
 		reg	   = <0x1000 0x1000>;
 		interrupts	 = <45 2 0 0>;
 	};
 
 	sec_jr1: jr@2000 {
-		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		compatible = "fsl,sec-v4.4-job-ring", "fsl,sec-v4.0-job-ring";
 		reg	   = <0x2000 0x1000>;
 		interrupts	 = <45 2 0 0>;
 	};
 
 	sec_jr2: jr@3000 {
-		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		compatible = "fsl,sec-v4.4-job-ring", "fsl,sec-v4.0-job-ring";
 		reg	   = <0x3000 0x1000>;
 		interrupts	 = <45 2 0 0>;
 	};
 
 	sec_jr3: jr@4000 {
-		compatible = "fsl,sec4.4-job-ring", "fsl,sec4.0-job-ring";
+		compatible = "fsl,sec-v4.4-job-ring", "fsl,sec-v4.0-job-ring";
 		reg	   = <0x4000 0x1000>;
 		interrupts	 = <45 2 0 0>;
 	};
-- 
1.7.0.4
