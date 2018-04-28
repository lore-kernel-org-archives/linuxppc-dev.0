Return-Path: <colin.king@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by lists.ozlabs.org (Postfix) with ESMTP id 40Y5nP5lhzzF25L
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2018 19:57:13 +1000 (AEST)
From: Colin King <colin.king@canonical.com>
To: Li Yang <leoyang.li@nxp.com>, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: ucc: fix spelling mistake: "tx-late-collsion"
 -> "tx-late-collision"
Date: Sat, 28 Apr 2018 10:57:07 +0100
Message-Id: <20180428095707.7424-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in tx_fw_stat_gstrings text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/freescale/ucc_geth_ethtool.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
index 4df282ed22c7..0beee2cc2ddd 100644
--- a/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
+++ b/drivers/net/ethernet/freescale/ucc_geth_ethtool.c
@@ -61,7 +61,7 @@ static const char hw_stat_gstrings[][ETH_GSTRING_LEN] = {
 static const char tx_fw_stat_gstrings[][ETH_GSTRING_LEN] = {
 	"tx-single-collision",
 	"tx-multiple-collision",
-	"tx-late-collsion",
+	"tx-late-collision",
 	"tx-aborted-frames",
 	"tx-lost-frames",
 	"tx-carrier-sense-errors",
-- 
2.17.0
