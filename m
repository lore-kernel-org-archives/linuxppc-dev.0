Return-Path: <galak@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 5D80F67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 18:55:16 +1100 (EST)
Date: Fri, 4 Mar 2005 01:55:11 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: jgarzik@pobox.com
Message-ID: <Pine.LNX.4.61.0503040150480.16127@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@oss.sgi.com, linuxppc-embedded@ozlabs.org
Subject: [PATCH] gianfar: Update Marvell PHY name
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jeff,

This patch updates the name identifier to list both of the Marvell PHYs 
that are supported.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/drivers/net/gianfar_phy.c b/drivers/net/gianfar_phy.c
--- a/drivers/net/gianfar_phy.c	2005-03-02 14:20:27 -06:00
+++ b/drivers/net/gianfar_phy.c	2005-03-02 14:20:27 -06:00
@@ -572,7 +572,7 @@
 static struct phy_info phy_info_marvell = {
 	.phy_id		= 0x01410c00,
 	.phy_id_mask	= 0xffffff00,
-	.name		= "Marvell 88E1101",
+	.name		= "Marvell 88E1101/88E1111",
 	.features	= MII_GBIT_FEATURES,
 	.config_aneg	= &marvell_config_aneg,
 	.read_status	= &marvell_read_status,
