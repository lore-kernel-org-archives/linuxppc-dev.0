Return-Path: <Shruti@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D4321A0175
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 05:44:32 +1000 (EST)
From: Shruti Kanetkar <Shruti@Freescale.com>
To: <scottwood@Freescale.com>
Subject: [PATCH] net/fsl: fix misspelled word
Date: Tue, 29 Jul 2014 14:44:15 -0500
Message-ID: <1406663055-8700-1-git-send-email-Shruti@Freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shruti Kanetkar <Shruti@Freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Madalin Bucur <madalin.bucur@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madalin Bucur <madalin.bucur@freescale.com>

Fix one misspelled word reported by codespell.

Signed-off-by: Madalin Bucur <madalin.bucur@freescale.com>
Signed-off-by: Shruti Kanetkar <Shruti@freescale.com>
---
 drivers/net/ethernet/freescale/xgmac_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/xgmac_mdio.c b/drivers/net/ethernet/freescale/xgmac_mdio.c
index 0c9d55c..8173407 100644
--- a/drivers/net/ethernet/freescale/xgmac_mdio.c
+++ b/drivers/net/ethernet/freescale/xgmac_mdio.c
@@ -46,7 +46,7 @@ struct tgec_mdio_controller {
 #define MDIO_DATA_BSY		(1 << 31)
 
 /*
- * Wait untill the MDIO bus is free
+ * Wait until the MDIO bus is free
  */
 static int xgmac_wait_until_free(struct device *dev,
 				 struct tgec_mdio_controller __iomem *regs)
-- 
1.8.3.1
