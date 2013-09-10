Return-Path: <B45475@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBB5C2C0129
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 15:54:32 +1000 (EST)
Received: from mail58-ch1 (localhost [127.0.0.1])	by mail58-ch1-R.bigfish.com
 (Postfix) with ESMTP id DB2CA4600FD	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,
 10 Sep 2013 05:54:26 +0000 (UTC)
Received: from CH1EHSMHS012.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.240])	by mail58-ch1.bigfish.com (Postfix) with ESMTP id
 29B863C0043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 05:54:25 +0000 (UTC)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1010rdb:update phy node in dts
Date: Tue, 10 Sep 2013 13:50:43 +0800
Message-ID: <1378792243-27962-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>,
 Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update phy node according to new P1010RDB-PB board.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index 7fc3402..8c675bf 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -199,7 +199,7 @@
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
+			interrupts = <0 1 0 0>;
 			reg = <0x1>;
 		};
 
@@ -209,7 +209,7 @@
 		};
 
 		phy2: ethernet-phy@2 {
-			interrupts = <2 1 0 0>;
+			interrupts = <1 1 0 0>;
 			reg = <0x2>;
 		};
 
-- 
1.8.0
