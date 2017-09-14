Return-Path: <valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtHS93DM1zDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 22:11:05 +1000 (AEST)
From: Valentin Longchamp <valentin.longchamp@keymile.com>
To: leoli@freescale.com, netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
 Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: [PATCH] net/ethernet/freescale: fix warning for ucc_geth
Date: Thu, 14 Sep 2017 14:05:14 +0200
Message-Id: <20170914120514.31845-1-valentin.longchamp@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Simple printk format warning for the the ucc registers address.

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index f77ba9fa257b..56b8fdb35c3b 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3857,7 +3857,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 	}
 
 	if (netif_msg_probe(&debug))
-		pr_info("UCC%1d at 0x%8x (irq = %d)\n",
+		pr_info("UCC%1d at 0x%8llx (irq = %d)\n",
 			ug_info->uf_info.ucc_num + 1, ug_info->uf_info.regs,
 			ug_info->uf_info.irq);
 
-- 
2.13.5
