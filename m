Return-Path: <SRS0=Oat7=T7=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 92930DE307
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 02:59:53 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: NEWEMAC: Add compatible "ibm,tah" to tah matching table
Date: Thu, 13 Mar 2008 16:59:43 +0100
Message-Id: <1205423983-21142-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add "ibm,tah" to the compatible matching table of the ibm_newemac
tah driver. The type "tah" is still preserved for compatibility reasons.
New dts files should use the compatible property though.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 drivers/net/ibm_newemac/tah.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ibm_newemac/tah.c b/drivers/net/ibm_newemac/tah.c
index 96417ad..b023d10 100644
--- a/drivers/net/ibm_newemac/tah.c
+++ b/drivers/net/ibm_newemac/tah.c
@@ -155,6 +155,10 @@ static int __devexit tah_remove(struct of_device *ofdev)
 static struct of_device_id tah_match[] =
 {
 	{
+		.compatible	= "ibm,tah",
+	},
+	/* For backward compat with old DT */
+	{
 		.type		= "tah",
 	},
 	{},
-- 
1.5.4.4
