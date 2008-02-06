Return-Path: <SRS0=+ox4=S3=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 75538DDE04
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 23:22:26 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: jeff@garzik.org
Subject: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii matching
	table
Date: Wed,  6 Feb 2008 13:21:59 +0100
Message-Id: <1202300519-7294-1-git-send-email-sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

With the removal the the "rgmii-interface" device_type property from the
dts files, the newemac driver needs an update to only rely on compatible
property.

Signed-off-by: Stefan Roese <sr@denx.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/net/ibm_newemac/rgmii.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
index 9bc1132..5757788 100644
--- a/drivers/net/ibm_newemac/rgmii.c
+++ b/drivers/net/ibm_newemac/rgmii.c
@@ -302,7 +302,6 @@ static int __devexit rgmii_remove(struct of_device *ofdev)
 static struct of_device_id rgmii_match[] =
 {
 	{
-		.type		= "rgmii-interface",
 		.compatible	= "ibm,rgmii",
 	},
 	{
-- 
1.5.4.rc3
