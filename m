Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40232DDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 00:24:47 +1000 (EST)
Date: Mon, 1 Oct 2007 18:23:16 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: PowerPC: new EMAC driver typo fix
Message-ID: <20071001142316.GA24156@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This looks like typo. Please, apply this patch to fix.

diff -ruNp linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
--- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2007-10-01 17:23:35.000000000 +0400
+++ linux-2.6/drivers/net/ibm_newemac/core.c	2007-10-01 17:44:57.000000000 +0400
@@ -1232,9 +1232,9 @@ static inline int emac_xmit_finish(struc
 	 * instead
 	 */
 	if (emac_has_feature(dev, EMAC_FTR_EMAC4))
-		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
-	else
 		out_be32(&p->tmr0, EMAC4_TMR0_XMIT);
+	else
+		out_be32(&p->tmr0, EMAC_TMR0_XMIT);
 
 	if (unlikely(++dev->tx_cnt == NUM_TX_BUFF)) {
 		netif_stop_queue(ndev);
