Return-Path: <nikhil.badola@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0244.outbound.protection.outlook.com [207.46.163.244])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0882B1A0019
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Aug 2014 13:52:01 +1000 (EST)
From: Nikhil Badola <nikhil.badola@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc: dts: t4240: Change T4240 USB controller version
Date: Thu, 28 Aug 2014 09:21:46 +0530
Message-ID: <1409197906-19734-1-git-send-email-nikhil.badola@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, Nikhil Badola <nikhil.badola@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change USB controller version to 2.5 in compatible string for T4240

Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index a3d582e..7e2fc7c 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -498,13 +498,13 @@
 /include/ "qoriq-gpio-3.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
 		usb0: usb@210000 {
-			compatible = "fsl-usb2-mph-v2.4", "fsl-usb2-mph";
+			compatible = "fsl-usb2-mph-v2.5", "fsl-usb2-mph";
 			phy_type = "utmi";
 			port0;
 		};
 /include/ "qoriq-usb2-dr-0.dtsi"
 		usb1: usb@211000 {
-			compatible = "fsl-usb2-dr-v2.4", "fsl-usb2-dr";
+			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			dr_mode = "host";
 			phy_type = "utmi";
 		};
-- 
1.7.11.7
