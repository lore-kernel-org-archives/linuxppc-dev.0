Return-Path: <B32579@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0253.outbound.messaging.microsoft.com [213.199.154.253])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C6A62C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 20:50:46 +1000 (EST)
Received: from mail32-db9 (localhost [127.0.0.1])	by mail32-db9-R.bigfish.com
 (Postfix) with ESMTP id 6970A26011D	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 24 Sep 2013 10:50:41 +0000 (UTC)
Received: from DB9EHSMHS030.bigfish.com (unknown [10.174.16.233])	by
 mail32-db9.bigfish.com (Postfix) with ESMTP id C1739460041	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:50:39 +0000 (UTC)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] dts/c293pcie: Add range field for IFC NAND
Date: Tue, 24 Sep 2013 16:20:32 +0530
Message-ID: <1380019832-15535-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

C290PCIe has NAND flash present on IFC Chip Select(CS) 1.

So Add "ranges" field for NAND flash on CS1.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
 branch next

 arch/powerpc/boot/dts/c293pcie.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/dts/c293pcie.dts b/arch/powerpc/boot/dts/c293pcie.dts
index 1238bda..6681cc2 100644
--- a/arch/powerpc/boot/dts/c293pcie.dts
+++ b/arch/powerpc/boot/dts/c293pcie.dts
@@ -45,6 +45,7 @@
 	ifc: ifc@fffe1e000 {
 		reg = <0xf 0xffe1e000 0 0x2000>;
 		ranges = <0x0 0x0 0xf 0xec000000 0x04000000
+			  0x1 0x0 0xf 0xff800000 0x00010000
 			  0x2 0x0 0xf 0xffdf0000 0x00010000>;
 
 	};
-- 
1.7.9.5
