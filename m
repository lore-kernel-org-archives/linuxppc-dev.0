Return-Path: <B42677@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BF3D92C0084
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 20:39:54 +1000 (EST)
Received: from mail81-va3 (localhost [127.0.0.1])	by mail81-va3-R.bigfish.com
 (Postfix) with ESMTP id 997CB8018A	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Sep 2013 10:39:49 +0000 (UTC)
Received: from VA3EHSMHS015.bigfish.com (unknown [10.7.14.228])	by
 mail81-va3.bigfish.com (Postfix) with ESMTP id D032260041	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2013 10:39:47 +0000 (UTC)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] Powerpc/dts: Correct sdhci quirk for bsc9131
Date: Mon, 2 Sep 2013 18:37:02 +0800
Message-ID: <1378118222-17338-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>,
 X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We use property "sdhci,auto-cmd12" instead of "fsl,sdhci-auto-cmd12"
to distinguish if the sdhc host has quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
---
 arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
index 5180d9d..0c0efa9 100644
--- a/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/bsc9131si-post.dtsi
@@ -130,7 +130,7 @@ usb@22000 {
 
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
-		fsl,sdhci-auto-cmd12;
+		sdhci,auto-cmd12;
 		interrupts = <41 0x2 0 0>;
 	};
 
-- 
1.8.0
