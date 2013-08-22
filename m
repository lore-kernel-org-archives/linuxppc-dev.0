Return-Path: <B36685@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8469E2C00BB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 15:08:31 +1000 (EST)
Received: from mail97-va3 (localhost [127.0.0.1])	by mail97-va3-R.bigfish.com
 (Postfix) with ESMTP id ECAFF20114	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 22 Aug 2013 05:08:25 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.239])	by
 mail97-va3.bigfish.com (Postfix) with ESMTP id 473F63A0153	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Aug 2013 05:07:23 +0000 (UTC)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/p1010rdb: update phy node in dts
Date: Thu, 22 Aug 2013 12:06:12 +0800
Message-ID: <1377144372-9003-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
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
---
 arch/powerpc/boot/dts/p1010rdb.dtsi |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb.dtsi b/arch/powerpc/boot/dts/p1010rdb.dtsi
index ec7c27a..da24b2d 100644
--- a/arch/powerpc/boot/dts/p1010rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb.dtsi
@@ -193,17 +193,17 @@
 
 	mdio@24000 {
 		phy0: ethernet-phy@0 {
-			interrupts = <3 1 0 0>;
+			interrupts = <0 1>;
 			reg = <0x1>;
 		};
 
 		phy1: ethernet-phy@1 {
-			interrupts = <2 1 0 0>;
+			interrupts = <2 1>;
 			reg = <0x0>;
 		};
 
 		phy2: ethernet-phy@2 {
-			interrupts = <2 1 0 0>;
+			interrupts = <1 1>;
 			reg = <0x2>;
 		};
 
-- 
1.7.0.4
