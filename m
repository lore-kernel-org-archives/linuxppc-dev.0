Return-Path: <tklauser@distanz.ch>
Received: from mail.zhinst.com (mail.zhinst.com [212.126.164.98])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vs4hY5GVJzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 18:02:05 +1100 (AEDT)
From: Tobias Klauser <tklauser@distanz.ch>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next] net: ibmvnic: Remove unused net_stats member from
 struct ibmvnic_adapter
Date: Mon, 27 Mar 2017 08:56:59 +0200
Message-Id: <20170327065659.27307-1-tklauser@distanz.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibmvnic driver keeps its statistics in net_device->stats, so the
net_stats member in struct ibmvnic_adapter is unused. Remove it.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/ethernet/ibm/ibmvnic.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 10ad259208cb..42ad648c174d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -953,7 +953,6 @@ struct ibmvnic_adapter {
 	dma_addr_t bounce_buffer_dma;
 
 	/* Statistics */
-	struct net_device_stats net_stats;
 	struct ibmvnic_statistics stats;
 	dma_addr_t stats_token;
 	struct completion stats_done;
-- 
2.11.0
