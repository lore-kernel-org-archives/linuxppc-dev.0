Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com
 [IPv6:2607:f8b0:4002:c07::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21B171A114B
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 00:48:56 +1100 (AEDT)
Received: by mail-yk0-f171.google.com with SMTP id 10so19100229ykt.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Jan 2015 05:48:53 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 12/15] mtd: kconfig: replace PPC_OF with PPC
Date: Sat, 31 Jan 2015 21:47:42 +0800
Message-Id: <1422712065-9403-13-git-send-email-haokexin@gmail.com>
In-Reply-To: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
Cc: Kevin Hao <haokexin@gmail.com>, Brian Norris <computersforpeace@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PPC_OF is a ppc specific option which is used to mean that the
firmware device tree access functions are available. Since all the
ppc platforms have a device tree, it is aways set to 'y' for ppc.
So it makes no sense to keep a such option in the current kernel.
Replace it with PPC.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 drivers/mtd/nand/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 7d0150d20432..ceade0448025 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -421,7 +421,7 @@ config MTD_NAND_ORION
 
 config MTD_NAND_FSL_ELBC
 	tristate "NAND support for Freescale eLBC controllers"
-	depends on PPC_OF
+	depends on PPC
 	select FSL_LBC
 	help
 	  Various Freescale chips, including the 8313, include a NAND Flash
-- 
1.9.3
