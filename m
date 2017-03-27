Return-Path: <tklauser@distanz.ch>
Received: from mail.zhinst.com (mail.zhinst.com [212.126.164.98])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vs4h15j10zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 18:01:37 +1100 (AEDT)
From: Tobias Klauser <tklauser@distanz.ch>
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next] net: ibmveth: Remove unused stats member from struct
 ibmveth_adapter
Date: Mon, 27 Mar 2017 08:56:15 +0200
Message-Id: <20170327065615.27215-1-tklauser@distanz.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ibmveth driver keeps its statistics in net_device->stats, so the
stats member in struct ibmveth_adapter is unused. Remove it.

Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 drivers/net/ethernet/ibm/ibmveth.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 7acda04d034e..ed8780cca982 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -146,7 +146,6 @@ struct ibmveth_adapter {
     struct vio_dev *vdev;
     struct net_device *netdev;
     struct napi_struct napi;
-    struct net_device_stats stats;
     unsigned int mcastFilterSize;
     void * buffer_list_addr;
     void * filter_list_addr;
-- 
2.11.0
