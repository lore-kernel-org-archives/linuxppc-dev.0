Return-Path: <madalin.bucur@nxp.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0081.outbound.protection.outlook.com [104.47.37.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSJmj27WKzDqHq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 22:53:41 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
 <camelia.groza@nxp.com>, <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur
 <madalin.bucur@nxp.com>
Subject: [PATCH 5/9] dpaa_eth: remove redundant initialization
Date: Tue, 21 Feb 2017 13:52:50 +0200
Message-ID: <1487677974-13678-6-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
References: <1487677974-13678-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index e2ca107..e19181f 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -2093,7 +2093,7 @@ static enum qman_cb_dqrr_result rx_default_dqrr(struct qman_portal *portal,
 	dma_addr_t addr = qm_fd_addr(fd);
 	enum qm_fd_format fd_format;
 	struct net_device *net_dev;
-	u32 fd_status = fd->status;
+	u32 fd_status;
 	struct dpaa_bp *dpaa_bp;
 	struct dpaa_priv *priv;
 	unsigned int skb_len;
-- 
2.1.0
