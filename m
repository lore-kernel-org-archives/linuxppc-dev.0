Return-Path: <sebastien.dugue@bull.net>
Received: from ecfrec.frec.bull.fr (ecfrec.frec.bull.fr [129.183.4.8])
	by ozlabs.org (Postfix) with ESMTP id 8EED4DDF3F
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 23:34:54 +1000 (EST)
From: Sebastien Dugue <sebastien.dugue@bull.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] ehea: fix phyp debugging typo
Date: Thu, 11 Sep 2008 15:34:39 +0200
Message-Id: <1221140080-9853-2-git-send-email-sebastien.dugue@bull.net>
In-Reply-To: <1221140080-9853-1-git-send-email-sebastien.dugue@bull.net>
References: <1221140080-9853-1-git-send-email-sebastien.dugue@bull.net>
Cc: tklein@de.ibm.com, tinytim@us.ibm.com, jeff@garzik.org, themann@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	jean-pierre.dion@bull.net, sebastien.dugue@bull.net,
	raisch@de.ibm.com, gilles.carry@ext.bull.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  Fix typo in ehea_h_query_ehea() which prevents building when DEBUG is on.

Signed-off-by: Sebastien Dugue <sebastien.dugue@bull.net>
---
 drivers/net/ehea/ehea_phyp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ehea/ehea_phyp.c b/drivers/net/ehea/ehea_phyp.c
index 156eb63..2a33a61 100644
--- a/drivers/net/ehea/ehea_phyp.c
+++ b/drivers/net/ehea/ehea_phyp.c
@@ -535,7 +535,7 @@ u64 ehea_h_query_ehea(const u64 adapter_handle, void *cb_addr)
 				       cb_logaddr,		/* R5 */
 				       0, 0, 0, 0, 0);		/* R6-R10 */
 #ifdef DEBUG
-	ehea_dmp(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
+	ehea_dump(cb_addr, sizeof(struct hcp_query_ehea), "hcp_query_ehea");
 #endif
 	return hret;
 }
-- 
1.6.0.1.308.gede4c
