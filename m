Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 36ECEDE6C6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 04:04:57 +1000 (EST)
Date: Wed, 9 Jul 2008 22:02:34 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] PowerPC 44x: Adjust warp-nand resource end address
Message-ID: <20080709180234.GA17862@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sr@denx.de, smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adjust the NDFC resource end value (resource size = end - start + 1).

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 arch/powerpc/platforms/44x/warp-nand.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/44x/warp-nand.c	2008-07-01 20:39:07.000000000 +0400
+++ b/arch/powerpc/platforms/44x/warp-nand.c	2008-07-09 20:22:31.000000000 +0400
@@ -24,7 +24,7 @@
 
 static struct resource warp_ndfc = {
 	.start = WARP_NAND_FLASH_REG_ADDR,
-	.end   = WARP_NAND_FLASH_REG_ADDR + WARP_NAND_FLASH_REG_SIZE,
+	.end   = WARP_NAND_FLASH_REG_ADDR + WARP_NAND_FLASH_REG_SIZE - 1,
 	.flags = IORESOURCE_MEM,
 };
 
