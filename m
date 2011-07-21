Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6C5AB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 21 Jul 2011 21:22:10 +1000 (EST)
Received: from mail184-va3 (localhost.localdomain [127.0.0.1])	by
	mail184-va3-R.bigfish.com (Postfix) with ESMTP id C9436990324	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 11:22:04 +0000 (UTC)
Received: from VA3EHSMHS030.bigfish.com (unknown [10.7.14.251])	by
	mail184-va3.bigfish.com (Postfix) with ESMTP id A3989124804B	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jul 2011 11:22:04 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] powerpc/85xx: fix interrupt number of memory-controller
	for P4080
Date: Thu, 21 Jul 2011 18:24:49 +0800
Message-ID: <1311243889-4316-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: kumar.gala@freescale.com, Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 927f94d..9c37a85 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -131,14 +131,14 @@
 			compatible = "fsl,p4080-memory-controller";
 			reg = <0x8000 0x1000>;
 			interrupt-parent = <&mpic>;
-			interrupts = <0x12 2>;
+			interrupts = <16 2>;
 		};
 
 		memory-controller@9000 {
 			compatible = "fsl,p4080-memory-controller";
 			reg = <0x9000 0x1000>;
 			interrupt-parent = <&mpic>;
-			interrupts = <0x12 2>;
+			interrupts = <16 2>;
 		};
 
 		corenet-cf@18000 {
-- 
1.6.4
