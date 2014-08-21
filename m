Return-Path: <nikhil.badola@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0188.outbound.protection.outlook.com [207.46.163.188])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A6B71A011C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Aug 2014 20:31:12 +1000 (EST)
From: Nikhil Badola <nikhil.badola@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: dts: t208x: Change T208x USB controller version
Date: Thu, 21 Aug 2014 16:01:30 +0530
Message-ID: <1408617090-29692-1-git-send-email-nikhil.badola@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Nikhil Badola <nikhil.badola@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change USB controller version to 2.5 in compatible string for T2080/T2081

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
	Checkpatch warnings handled by commit 61a8c2c6fe71082de3ea8629589dcdd0cc5c3f02
	Documentation: dts: fsl-usb: Document USB node compatible string for IP version	

 arch/powerpc/boot/dts/fsl/t2081si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
index 97479f0..aecee96 100644
--- a/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t2081si-post.dtsi
@@ -410,7 +410,7 @@
 /include/ "qoriq-gpio-3.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
 	usb0: usb@210000 {
-		compatible = "fsl-usb2-mph-v2.4", "fsl-usb2-mph";
+		compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x520>; /* USB1LIODNR */
 		phy_type = "utmi";
@@ -418,7 +418,7 @@
 	};
 /include/ "qoriq-usb2-dr-0.dtsi"
 	usb1: usb@211000 {
-		compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+		compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x524>; /* USB1LIODNR */
 		dr_mode = "host";
-- 
1.7.11.7
