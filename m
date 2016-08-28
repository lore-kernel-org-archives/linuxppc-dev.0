Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMX402NQnzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 21:04:48 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Li Yang <leoli@freescale.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] net: ucc_geth: fix spelling mistake "propperty" -> "property"
Date: Sun, 28 Aug 2016 12:03:27 +0100
Message-Id: <20160828110327.10205-1-colin.king@canonical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn message.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 5bf1ade..186ef8f 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -3756,7 +3756,7 @@ static int ucc_geth_probe(struct platform_device* ofdev)
 			return -EINVAL;
 		}
 		if ((*prop < QE_CLK_NONE) || (*prop > QE_CLK24)) {
-			pr_err("invalid rx-clock propperty\n");
+			pr_err("invalid rx-clock property\n");
 			return -EINVAL;
 		}
 		ug_info->uf_info.rx_clock = *prop;
-- 
2.9.3
