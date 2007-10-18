Return-Path: <joe@perches.com>
Received: from perches.com (DSL022.labridge.com [206.117.136.22])
	by ozlabs.org (Postfix) with ESMTP id EB6A5DDEDE
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:25:13 +1000 (EST)
Subject: [PATCH] trivial - QUICC UCC driver - remove buggy and unused vdbg
	macro
From: Joe Perches <joe@perches.com>
To: Li Yang <leoli@freescale.com>
Content-Type: text/plain
Date: Thu, 18 Oct 2007 12:24:53 -0700
Message-Id: <1192735493.23980.42.camel@localhost>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

remove buggy and unused vdbg macro

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
index df884f0..a4b481c 100644
--- a/drivers/net/ucc_geth_mii.c
+++ b/drivers/net/ucc_geth_mii.c
@@ -46,13 +46,6 @@
 #include "ucc_geth_mii.h"
 #include "ucc_geth.h"
 
-#define DEBUG
-#ifdef DEBUG
-#define vdbg(format, arg...) printk(KERN_DEBUG , format "\n" , ## arg)
-#else
-#define vdbg(format, arg...) do {} while(0)
-#endif
-
 #define MII_DRV_DESC "QE UCC Ethernet Controller MII Bus"
 #define MII_DRV_NAME "fsl-uec_mdio"
 
