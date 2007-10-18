Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6DE02DDE1C
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 06:15:03 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	l9IJLEeJ002807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 14:21:14 -0500
Date: Thu, 18 Oct 2007 12:20:21 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH] phy/bitbang: missing MODULE_LICENSE
Message-Id: <20071018122021.2acd128d.randy.dunlap@oracle.com>
In-Reply-To: <20070920220123.GG28784@loki.buserror.net>
References: <20070920220043.GA28769@loki.buserror.net>
	<20070920220123.GG28784@loki.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Randy Dunlap <randy.dunlap@oracle.com>

Missing MODULE_LICENSE(), loading this module taints the kernel.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/net/phy/mdio-bitbang.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.23-git7.orig/drivers/net/phy/mdio-bitbang.c
+++ linux-2.6.23-git7/drivers/net/phy/mdio-bitbang.c
@@ -185,3 +185,5 @@ void free_mdio_bitbang(struct mii_bus *b
 	module_put(ctrl->ops->owner);
 	kfree(bus);
 }
+
+MODULE_LICENSE("GPL");
