Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2B810DDFE3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:07 +1000 (EST)
Date: Fri, 23 May 2008 16:16:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 01/12] pata_mpc52xx: use linux/of_platform.h instead of asm
Message-Id: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Tejun Heo <htejun@gmail.com>,
	Sylvain Munaut <tnt@246tNt.com>, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/ata/pata_mpc52xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

I am not sure who wants to take this.

diff --git a/drivers/ata/pata_mpc52xx.c b/drivers/ata/pata_mpc52xx.c
index bc79df6..a9e8273 100644
--- a/drivers/ata/pata_mpc52xx.c
+++ b/drivers/ata/pata_mpc52xx.c
@@ -16,10 +16,10 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/libata.h>
+#include <linux/of_platform.h>
 
 #include <asm/types.h>
 #include <asm/prom.h>
-#include <asm/of_platform.h>
 #include <asm/mpc52xx.h>
 
 
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
