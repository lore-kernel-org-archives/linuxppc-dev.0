Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5D65BDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 00:43:07 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
Subject: [PATCH 2/2] ucc_geth: Remove unused header
Date: Tue, 31 Mar 2009 08:42:59 -0500
Message-Id: <1238506979-8678-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1238506979-8678-1-git-send-email-galak@kernel.crashing.org>
References: <1238506979-8678-1-git-send-email-galak@kernel.crashing.org>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the driver is exclusively an of_platform driver we no longer
use the structs and #defines in fsl_devices.h

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/net/ucc_geth.c         |    1 -
 drivers/net/ucc_geth.h         |    1 -
 drivers/net/ucc_geth_ethtool.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index 933fcfb..a124615 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -24,7 +24,6 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-#include <linux/fsl_devices.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/workqueue.h>
diff --git a/drivers/net/ucc_geth.h b/drivers/net/ucc_geth.h
index e3a25e6..48fde5a 100644
--- a/drivers/net/ucc_geth.h
+++ b/drivers/net/ucc_geth.h
@@ -20,7 +20,6 @@
 
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/fsl_devices.h>
 
 #include <asm/immap_qe.h>
 #include <asm/qe.h>
diff --git a/drivers/net/ucc_geth_ethtool.c b/drivers/net/ucc_geth_ethtool.c
index a755bea..6fcb500 100644
--- a/drivers/net/ucc_geth_ethtool.c
+++ b/drivers/net/ucc_geth_ethtool.c
@@ -28,7 +28,6 @@
 #include <linux/mm.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
-#include <linux/fsl_devices.h>
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/phy.h>
-- 
1.5.6.6
