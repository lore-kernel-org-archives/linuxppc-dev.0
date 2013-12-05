Return-Path: <qiang.zhao@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10F3C2C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2013 17:49:30 +1100 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <bcousson@baylibre.com>, <tony@atomide.com>, <devicetree@vger.kernel.org>
Subject: [PATCH] powerpc/p1010rdb-pa: modify phy interrupt.
Date: Thu, 5 Dec 2013 14:00:03 +0800
Message-ID: <1386223203-22353-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is not correct according to p1010rdb-pa user guide.
So modify it.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/boot/dts/p1010rdb-pa.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1010rdb-pa.dtsi b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
index 3d275e0..0cf6c34 100644
--- a/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
+++ b/arch/powerpc/boot/dts/p1010rdb-pa.dtsi
@@ -39,7 +39,7 @@
 };
 
 &phy0 {
-	interrupts = <3 1 0 0>;
+	interrupts = <1 1 0 0>;
 };
 
 &phy1 {
@@ -47,5 +47,5 @@
 };
 
 &phy2 {
-	interrupts = <2 1 0 0>;
+	interrupts = <4 1 0 0>;
 };
-- 
1.8.4
