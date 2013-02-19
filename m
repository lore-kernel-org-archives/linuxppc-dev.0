Return-Path: <B43644@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DFC5C2C0092
 for <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 12:32:55 +1100 (EST)
Received: from mail36-co1 (localhost [127.0.0.1])	by mail36-co1-R.bigfish.com
 (Postfix) with ESMTP id B030B2400FD	for <linuxppc-dev@ozlabs.org>;
 Tue, 19 Feb 2013 01:32:51 +0000 (UTC)
Received: from CO1EHSMHS005.bigfish.com (unknown [10.243.78.205])	by
 mail36-co1.bigfish.com (Postfix) with ESMTP id BA50140004A	for
 <linuxppc-dev@ozlabs.org>; Tue, 19 Feb 2013 01:32:49 +0000 (UTC)
From: Po Liu <po.liu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, Kumar Gala <kumar.gala@freescale.com>
Subject: [PATCH] powerpc/85xx: dts - add ranges property for SEC
Date: Tue, 19 Feb 2013 08:29:06 +0800
Message-ID: <1361233746-19106-1-git-send-email-po.liu@freescale.com>
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
index d4c9d5d..ffadcb5 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-sec4.4-0.dtsi
@@ -36,6 +36,7 @@ crypto@30000 {
 	compatible = "fsl,sec-v4.4", "fsl,sec-v4.0";
 	#address-cells = <1>;
 	#size-cells = <1>;
+	ranges		 = <0x0 0x30000 0x10000>;
 	reg		 = <0x30000 0x10000>;
 	interrupts	 = <58 2 0 0>;
 
-- 
1.6.4
