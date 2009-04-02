Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C9D8DDDB2
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 00:45:30 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Subject: [PATCH] fsl_pq_mdio: Fix compile failure
Date: Thu,  2 Apr 2009 08:45:23 -0500
Message-Id: <1238679923-4370-1-git-send-email-galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Segher Boessenkool <segher@kernel.crashing.org>

Add EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name) for module builds

Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Dave, 

I think this got lost in a thread on the ppc list.

- k

 drivers/net/fsl_pq_mdio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index d9e1ecf..aa1eb88 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -204,6 +204,7 @@ void fsl_pq_mdio_bus_name(char *name, struct device_node *np)
 	snprintf(name, MII_BUS_ID_SIZE, "%s@%llx", np->name,
 		(unsigned long long)taddr);
 }
+EXPORT_SYMBOL_GPL(fsl_pq_mdio_bus_name);
 
 /* Scan the bus in reverse, looking for an empty spot */
 static int fsl_pq_mdio_find_free(struct mii_bus *new_bus)
-- 
1.5.6.6
