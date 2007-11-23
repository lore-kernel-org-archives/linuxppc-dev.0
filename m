Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1DECDDE2B
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 06:18:35 +1100 (EST)
Date: Fri, 23 Nov 2007 22:11:52 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] PowerPC: ibm_newemac tah_ph typo fix
Message-ID: <20071123191152.GA25720@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071123190747.GA25654@ru.mvista.com>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch fixes a typo in ibm_newemac/core.c
(tah_port should be used instead of tah_ph)

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---
 drivers/net/ibm_newemac/core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -pruN linux-2.6.orig/drivers/net/ibm_newemac/core.c linux-2.6/drivers/net/ibm_newemac/core.c
--- linux-2.6.orig/drivers/net/ibm_newemac/core.c	2007-11-23 21:27:57.000000000 +0300
+++ linux-2.6/drivers/net/ibm_newemac/core.c	2007-11-23 21:36:00.000000000 +0300
@@ -2427,7 +2427,7 @@ static int __devinit emac_init_config(st
 	if (emac_read_uint_prop(np, "tah-device", &dev->tah_ph, 0))
 		dev->tah_ph = 0;
 	if (emac_read_uint_prop(np, "tah-channel", &dev->tah_port, 0))
-		dev->tah_ph = 0;
+		dev->tah_port = 0;
 	if (emac_read_uint_prop(np, "mdio-device", &dev->mdio_ph, 0))
 		dev->mdio_ph = 0;
 	if (emac_read_uint_prop(np, "zmii-device", &dev->zmii_ph, 0))
