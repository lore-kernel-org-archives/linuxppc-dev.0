Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0135.outbound.protection.outlook.com [65.55.169.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5FA031A001B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 18:24:14 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc/dts: add eSDHC compatible list
Date: Wed, 13 May 2015 16:20:22 +0800
Message-ID: <1431505222-38521-1-git-send-email-yangbo.lu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Yangbo Lu <yangbo.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index efd74db..67ea0e9 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -363,6 +363,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p2041-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index d7425ef..b6d92c5 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -390,6 +390,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p3041-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 7005a4a..bf3dad3 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -462,6 +462,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p4080-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		voltage-ranges = <3300 3300>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 5583421..dbc2c8b 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -377,6 +377,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5020-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 6e4cd6c..207d02f 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -355,6 +355,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5040-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu2>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
-- 
2.1.0.27.g96db324
