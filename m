Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 13B79B6FD7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 03:56:53 +1100 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: davem@davemloft.net, eric.dumazet@gmail.com, therbert@google.com
Subject: [PATCH net-next 3/3] gianfar: delete orphaned version strings and
 dead macros
Date: Sun, 18 Mar 2012 12:56:27 -0400
Message-Id: <1332089787-24086-4-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
References: <1332089787-24086-1-git-send-email-paul.gortmaker@windriver.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There were two version strings, and neither one was being used.
Also in the same proximity were some unused #define that were
left over from the past.  Delete them all.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/net/ethernet/freescale/gianfar.c |    3 ---
 drivers/net/ethernet/freescale/gianfar.h |    3 ---
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index a4c934b..6e66cc3 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -104,10 +104,7 @@
 #include "fsl_pq_mdio.h"
 
 #define TX_TIMEOUT      (1*HZ)
-#undef BRIEF_GFAR_ERRORS
-#undef VERBOSE_GFAR_ERRORS
 
-const char gfar_driver_name[] = "Gianfar Ethernet";
 const char gfar_driver_version[] = "1.3";
 
 static int gfar_enet_open(struct net_device *dev);
diff --git a/drivers/net/ethernet/freescale/gianfar.h b/drivers/net/ethernet/freescale/gianfar.h
index 4fe0f34..fc2488a 100644
--- a/drivers/net/ethernet/freescale/gianfar.h
+++ b/drivers/net/ethernet/freescale/gianfar.h
@@ -78,11 +78,8 @@ struct ethtool_rx_list {
 #define INCREMENTAL_BUFFER_SIZE 512
 
 #define PHY_INIT_TIMEOUT 100000
-#define GFAR_PHY_CHANGE_TIME 2
 
-#define DEVICE_NAME "%s: Gianfar Ethernet Controller Version 1.2, "
 #define DRV_NAME "gfar-enet"
-extern const char gfar_driver_name[];
 extern const char gfar_driver_version[];
 
 /* MAXIMUM NUMBER OF QUEUES SUPPORTED */
-- 
1.7.9.1
