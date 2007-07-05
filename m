Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 41918DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:49 +1000 (EST)
Message-Id: <20070705170237.252306000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:02:47 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 14/35] Add 88E1112 PHY ID to the marvell driver.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add 88E1112 PHY ID to the marvell driver.

Signed-off-by: Olof Johansson <olof@lixom.net>


Index: mainline/drivers/net/phy/marvell.c
===================================================================
--- mainline.orig/drivers/net/phy/marvell.c
+++ mainline/drivers/net/phy/marvell.c
@@ -252,6 +252,19 @@ static struct phy_driver marvell_drivers
 		.driver = {.owner = THIS_MODULE,},
 	},
 	{
+		.phy_id = 0x01410c90,
+		.phy_id_mask = 0xfffffff0,
+		.name = "Marvell 88E1112",
+		.features = PHY_GBIT_FEATURES,
+		.flags = PHY_HAS_INTERRUPT,
+		.config_init = &m88e1111_config_init,
+		.config_aneg = &marvell_config_aneg,
+		.read_status = &genphy_read_status,
+		.ack_interrupt = &marvell_ack_interrupt,
+		.config_intr = &marvell_config_intr,
+		.driver = {.owner = THIS_MODULE,},
+	},
+	{
 		.phy_id = 0x01410cc0,
 		.phy_id_mask = 0xfffffff0,
 		.name = "Marvell 88E1111",

--
