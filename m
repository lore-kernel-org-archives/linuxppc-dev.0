Return-Path: <Shengzhou.Liu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bbn0104.outbound.protection.outlook.com [157.56.111.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A9E21A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 19:30:28 +1000 (AEST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: Jaiprakash Singh <b44839@freescale.com>, Shengzhou Liu
 <Shengzhou.Liu@freescale.com>
Subject: [PATCH] powerpc/t1023rdb/dts: set ifc nand chip select from 2 to 1
Date: Fri, 10 Jul 2015 17:11:01 +0800
Message-ID: <1436519461-36076-1-git-send-email-Shengzhou.Liu@freescale.com>
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

From: Jaiprakash Singh <b44839@freescale.com>

IFC NAND chip select is wrongly mapped to 2 in reg property of
NAND node. Due to this kernel is not able probe NAND flash. Set
chip select to 1 in reg property.

Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/t1023rdb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/t1023rdb.dts b/arch/powerpc/boot/dts/t1023rdb.dts
index 7db5093..4aa16c3 100644
--- a/arch/powerpc/boot/dts/t1023rdb.dts
+++ b/arch/powerpc/boot/dts/t1023rdb.dts
@@ -60,7 +60,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			compatible = "fsl,ifc-nand";
-			reg = <0x2 0x0 0x10000>;
+			reg = <0x1 0x0 0x10000>;
 		};
 	};
 
-- 
2.1.0.27.g96db324
