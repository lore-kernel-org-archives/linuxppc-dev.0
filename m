Return-Path: <hrosenstock@xsigo.com>
Received: from mx01.xsigo.com (mx01.xsigo.com [216.184.49.20])
	by ozlabs.org (Postfix) with ESMTP id 0ADB3DDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 07:07:33 +1100 (EST)
Subject: [PATCH][TRIVIAL] ibm_emac/ibm_emac_mal.c:mal_poll: Fix MAL_DBG2
	invocation
From: Hal Rosenstock <hrosenstock@xsigo.com>
To: ebs@ebshome.net
Content-Type: text/plain
Date: Thu, 17 Jan 2008 10:47:15 -0800
Message-Id: <1200595635.25836.53.camel@hrosenstock-ws.xsigo.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ibm_emac/ibm_emac_mal.c:mal_poll: Fix MAL_DBG2 invocation

Signed-off-by: Hal Rosenstock <hal@xsigo.com>

diff --git a/drivers/net/ibm_emac/ibm_emac_mal.c b/drivers/net/ibm_emac/ibm_emac_mal.c
index dcd8826..1977791 100644
--- a/drivers/net/ibm_emac/ibm_emac_mal.c
+++ b/drivers/net/ibm_emac/ibm_emac_mal.c
@@ -279,7 +279,7 @@ static int mal_poll(struct napi_struct *napi, int budget)
 	struct list_head *l;
 	int received = 0;
 
-	MAL_DBG2("%d: poll(%d) %d ->" NL, mal->def->index, *budget,
+	MAL_DBG2("%d: poll(%d) %d ->" NL, mal->def->index, budget,
 		 rx_work_limit);
       again:
 	/* Process TX skbs */
