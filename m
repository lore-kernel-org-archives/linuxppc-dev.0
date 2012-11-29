Return-Path: <B16394@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56BD72C0087
 for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2012 15:25:22 +1100 (EST)
From: Vakul Garg <vakul@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] dts/t4240: Corrected PAMU device address range to encompass 6
 PAMU partitions.
Date: Thu, 29 Nov 2012 09:53:28 +0530
Message-ID: <1354163008-19707-1-git-send-email-vakul@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Vakul Garg <vakul@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Vakul Garg <vakul@freescale.com>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index ea6e2f4..e8809cd 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -231,7 +231,7 @@
 
 	iommu@20000 {
 		compatible = "fsl,pamu-v1.0", "fsl,pamu";
-		reg = <0x20000 0x4000>;
+		reg = <0x20000 0x6000>;
 		interrupts = <
 			24 2 0 0
 			16 2 1 30>;
-- 
1.7.7
