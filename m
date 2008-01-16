Return-Path: <SRS0=9ZSp=SG=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id CE15FDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 20:37:56 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org,
	netdev@vger.kernel.org
Subject: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii matching
	table
Date: Wed, 16 Jan 2008 10:37:10 +0100
Message-Id: <1200476230-14026-1-git-send-email-sr@denx.de>
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
