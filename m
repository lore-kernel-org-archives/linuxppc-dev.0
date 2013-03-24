Return-Path: <baatz@schnuecks.de>
Received: from mo6-p00-ob.rzone.de (mo6-p00-ob.rzone.de
 [IPv6:2a01:238:20a:202:5300::1])
 by ozlabs.org (Postfix) with ESMTP id 9CC0F2C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2013 07:41:05 +1100 (EST)
From: Simon Baatz <gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, florian@openwrt.org,
 thomas.petazzoni@free-electrons.com
Subject: [PATCH 1/2] net: mvmdio: define module alias for platform device
Date: Sun, 24 Mar 2013 21:33:59 +0100
Message-Id: <1364157240-28883-2-git-send-email-gmbnomis@gmail.com>
In-Reply-To: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
References: <1364157240-28883-1-git-send-email-gmbnomis@gmail.com>
Cc: Simon Baatz <gmbnomis@gmail.com>, andrew@lunn.ch, jason@lakedaemon.net,
 davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The mvmdio driver can be instantiated using device tree or as a classic
platform device.  In order to load the driver automatically by udev in
the latter case, the driver needs to define a module alias for the
platform device.

Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/net/ethernet/marvell/mvmdio.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 3472574..7b5158f 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -295,3 +295,4 @@ module_platform_driver(orion_mdio_driver);
 MODULE_DESCRIPTION("Marvell MDIO interface driver");
 MODULE_AUTHOR("Thomas Petazzoni <thomas.petazzoni@free-electrons.com>");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:orion-mdio");
-- 
1.7.9.5
