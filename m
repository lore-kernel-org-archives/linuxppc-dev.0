Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0116.outbound.protection.outlook.com [157.56.110.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FEDE1A0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jul 2015 21:30:59 +1000 (AEST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Subject: [PATCH 2/2] powerpc/t1023rdb: add ina220 current sense node
Date: Fri, 3 Jul 2015 17:50:49 +0800
Message-ID: <1435917049-24227-2-git-send-email-Shengzhou.Liu@freescale.com>
In-Reply-To: <1435917049-24227-1-git-send-email-Shengzhou.Liu@freescale.com>
References: <1435917049-24227-1-git-send-email-Shengzhou.Liu@freescale.com>
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
 arch/powerpc/boot/dts/t1023rdb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
index 06b090a..a1c647b 100644
--- a/arch/powerpc/boot/dts/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/t1023rdb.dts
@@ -99,6 +99,17 @@
 		};
 
 		i2c@118100 {
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+
+			ina220@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
 		};
 	};
 
-- 
2.1.0.27.g96db324
