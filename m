Return-Path: <B43644@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8462C2C007A
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 21:14:04 +1100 (EST)
Received: from mail49-ch1 (localhost [127.0.0.1])	by mail49-ch1-R.bigfish.com
 (Postfix) with ESMTP id 2649F100154	for <linuxppc-dev@ozlabs.org>;
 Fri, 18 Jan 2013 10:13:58 +0000 (UTC)
Received: from CH1EHSMHS029.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.236])	by mail49-ch1.bigfish.com (Postfix) with ESMTP id
 51A62120052
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 10:13:55 +0000 (UTC)
From: Po Liu <po.liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Date: Fri, 18 Jan 2013 17:16:13 +0800
Message-ID: <1358500573-19477-1-git-send-email-po.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Po Liu <po.liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This facilitates getting the physical address of the SEC node.

Signed-off-by: Liu po <po.liu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
index d4c9d5d..ef98fbf 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
@@ -36,6 +36,7 @@ crypto@30000 {
 	compatible = "fsl,sec-v4.4", "fsl,sec-v4.0";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	ranges		 = <0x0 0x30000 0x10000>
 	reg		 = <0x30000 0x10000>;
 	interrupts	 = <58 2 0 0>;
 
-- 
1.6.4
