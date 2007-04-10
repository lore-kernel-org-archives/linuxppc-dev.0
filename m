Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5B6C7DE086
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 07:57:12 +1000 (EST)
Date: Tue, 10 Apr 2007 16:57:06 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: netdev@vger.kernel.org
Subject: [PATCH 2/2] ucc_geth: implement and increment version number
Message-Id: <20070410165706.51dfe79c.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
please consider for 2.6.22

 drivers/net/ucc_geth.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 1b943e6..c9b1b28 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -46,8 +46,9 @@
 
 #undef DEBUG
 
-#define DRV_DESC "QE UCC Gigabit Ethernet Controller version:Sept 11, 2006"
+#define DRV_DESC "QE UCC Gigabit Ethernet Controller"
 #define DRV_NAME "ucc_geth"
+#define DRV_VERSION "1.1"
 
 #define ugeth_printk(level, format, arg...)  \
         printk(level format "\n", ## arg)
@@ -3975,4 +3976,5 @@ module_exit(ucc_geth_exit);
 
 MODULE_AUTHOR("Freescale Semiconductor, Inc");
 MODULE_DESCRIPTION(DRV_DESC);
+MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE("GPL");
-- 
1.5.0.1
