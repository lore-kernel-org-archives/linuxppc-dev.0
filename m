Return-Path: <dingtianhong@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2A3012C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Dec 2013 22:41:10 +1100 (EST)
Message-ID: <52BC15A2.1080000@huawei.com>
Date: Thu, 26 Dec 2013 19:40:18 +0800
From: Ding Tianhong <dingtianhong@huawei.com>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>, Netdev <netdev@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3.5 01/19] net: freescale: remove unused compare_addr()
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function did not be used any more, so remove it.

Cc: Li Yang <leoli@freescale.com>
Cc: netdev@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ding Tianhong <dingtianhong@huawei.com>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 5548b6d..72291a8 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -435,11 +435,6 @@ static void hw_add_addr_in_hash(struct ucc_geth_private *ugeth,
 		     QE_CR_PROTOCOL_ETHERNET, 0);
 }
 
-static inline int compare_addr(u8 **addr1, u8 **addr2)
-{
-	return memcmp(addr1, addr2, ETH_ALEN);
-}
-
 #ifdef DEBUG
 static void get_statistics(struct ucc_geth_private *ugeth,
 			   struct ucc_geth_tx_firmware_statistics *
-- 
1.8.0
