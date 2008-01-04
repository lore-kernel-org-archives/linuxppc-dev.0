Return-Path: <SRS0=ZQAH=R2=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 86D66DDE1B
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jan 2008 01:08:52 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Add EMAC support to Kilauea defconfig
Date: Fri,  4 Jan 2008 15:00:43 +0100
Message-Id: <1199455243-19490-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Somehow the EMAC support was dropped (or never really added) to the
Kilauea defconfig file. This patch finally adds EMAC support.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/configs/kilauea_defconfig |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/configs/kilauea_defconfig b/arch/powerpc/configs/kilauea_defconfig
index c86e756..8dca3d4 100644
--- a/arch/powerpc/configs/kilauea_defconfig
+++ b/arch/powerpc/configs/kilauea_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.24-rc6
-# Mon Dec 24 11:18:12 2007
+# Thu Jan  3 14:21:31 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -453,9 +453,28 @@ CONFIG_NETDEVICES=y
 # CONFIG_VETH is not set
 # CONFIG_IP1000 is not set
 # CONFIG_ARCNET is not set
-# CONFIG_NET_ETHERNET is not set
+# CONFIG_PHYLIB is not set
+CONFIG_NET_ETHERNET=y
+# CONFIG_MII is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_IBM_NEW_EMAC=y
+CONFIG_IBM_NEW_EMAC_RXB=256
+CONFIG_IBM_NEW_EMAC_TXB=256
+CONFIG_IBM_NEW_EMAC_POLL_WEIGHT=32
+CONFIG_IBM_NEW_EMAC_RX_COPY_THRESHOLD=256
+CONFIG_IBM_NEW_EMAC_RX_SKB_HEADROOM=0
+# CONFIG_IBM_NEW_EMAC_DEBUG is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
 CONFIG_IBM_NEW_EMAC_RGMII=y
+# CONFIG_IBM_NEW_EMAC_TAH is not set
 CONFIG_IBM_NEW_EMAC_EMAC4=y
+# CONFIG_NET_PCI is not set
+# CONFIG_B44 is not set
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_TR is not set
-- 
1.5.4.rc2
