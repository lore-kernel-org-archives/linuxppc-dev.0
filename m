Return-Path: <SRS0=i/5s=R3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 5CCD0DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 20:50:11 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: netdev@vger.kernel.org
Subject: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Date: Sat,  5 Jan 2008 10:50:09 +0100
Message-Id: <1199526609-12290-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Performance tests done by AMCC have shown that 256 buffer increase the
performance of the Linux EMAC driver. So let's update the default
values to match this setup.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ibm_newemac/Kconfig b/drivers/net/ibm_newemac/Kconfig
index 0d3e738..5a06727 100644
--- a/drivers/net/ibm_newemac/Kconfig
+++ b/drivers/net/ibm_newemac/Kconfig
@@ -9,12 +9,12 @@ config IBM_NEW_EMAC
 config IBM_NEW_EMAC_RXB
 	int "Number of receive buffers"
 	depends on IBM_NEW_EMAC
-	default "128"
+	default "256"
 
 config IBM_NEW_EMAC_TXB
 	int "Number of transmit buffers"
 	depends on IBM_NEW_EMAC
-	default "64"
+	default "256"
 
 config IBM_NEW_EMAC_POLL_WEIGHT
 	int "MAL NAPI polling weight"
-- 
1.5.4.rc2
