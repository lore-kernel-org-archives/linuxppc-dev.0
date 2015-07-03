Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0130.outbound.protection.outlook.com [207.46.100.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82D471A0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 20:29:04 +1000 (AEST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH 1/2] powerpc/t1024rdb: add ina220 current sense node
Date: Fri, 3 Jul 2015 17:50:48 +0800
Message-ID: <1435917049-24227-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for INA220 current sense.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t1024rdb.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/boot/dts/t1024rdb.dts b/arch/powerpc/boot/dts/t1024rdb.dts
index 733e723..43474d9 100644
--- a/arch/powerpc/boot/dts/t1024rdb.dts
+++ b/arch/powerpc/boot/dts/t1024rdb.dts
@@ -114,6 +114,13 @@
 				reg = <0x4c>;
 			};
 
+			/* INA220 Current Sense */
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
 			eeprom@50 {
 				compatible = "atmel,24c256";
 				reg = <0x50>;
-- 
2.1.0.27.g96db324
