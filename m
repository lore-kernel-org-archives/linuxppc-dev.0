Return-Path: <fabf@skynet.be>
Received: from mailrelay008.isp.belgacom.be (mailrelay008.isp.belgacom.be
 [195.238.6.174])
 by lists.ozlabs.org (Postfix) with ESMTP id EBD2B1A004F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jul 2014 00:28:53 +1000 (EST)
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 26/30] ucc_geth: remove unnecessary break after return
Date: Sun, 20 Jul 2014 16:27:51 +0200
Message-Id: <1405866475-24754-7-git-send-email-fabf@skynet.be>
In-Reply-To: <1405866475-24754-1-git-send-email-fabf@skynet.be>
References: <1405866475-24754-1-git-send-email-fabf@skynet.be>
Cc: netdev@vger.kernel.org, Fabian Frederick <fabf@skynet.be>, joe@perches.com,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/net/ethernet/freescale/ucc_geth.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 36fc429..8ceaf7a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -2396,7 +2396,6 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		if (netif_msg_ifup(ugeth))
 			pr_err("Bad number of Rx threads value\n");
 		return -EINVAL;
-		break;
 	}
 
 	switch (ug_info->numThreadsTx) {
@@ -2419,7 +2418,6 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		if (netif_msg_ifup(ugeth))
 			pr_err("Bad number of Tx threads value\n");
 		return -EINVAL;
-		break;
 	}
 
 	/* Calculate rx_extended_features */
-- 
1.9.1
