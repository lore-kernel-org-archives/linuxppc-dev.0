Return-Path: <acrux@inwind.it>
Received: from cp-out12.libero.it (cp-out12.libero.it [212.52.84.112])
	by ozlabs.org (Postfix) with ESMTP id 8D871DDD1C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 22:22:31 +1100 (EST)
Received: from pegasos2 (62.98.45.80) by cp-out12.libero.it (8.5.016.1)
	id 49C8ED4E00E83107 for linuxppc-dev@ozlabs.org;
	Fri, 3 Apr 2009 13:16:58 +0200
Date: Fri, 3 Apr 2009 13:16:54 +0200
From: Nico Macrionitis <acrux@inwind.it>
To: linuxppc-dev@ozlabs.org
Subject: net/mv643xx fix: now rely on 6xx (for Pegasos2 Chrp)
Message-Id: <20090403131654.f7225ca4.acrux@inwind.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Testing 2.6.29-git9 on Pegasos2 Chrp machine equipped with Marvell Discovery II i was unable to see MV643xx gigabit nic option.

32-bit platforms that relied on PPC32 && PPC_MULTIPLATFORM now rely
on 6xx then this one must be updated too.

-N

---
 drivers/net/{Kconfig.orig => Kconfig} |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/Kconfig.orig b/drivers/net/Kconfig
index f062b42..6f40f55 100644
--- a/drivers/net/Kconfig.orig
+++ b/drivers/net/Kconfig
@@ -2328,7 +2328,7 @@ config UGETH_TX_ON_DEMAND

 config MV643XX_ETH
        tristate "Marvell Discovery (643XX) and Orion ethernet support"
-       depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) || PLAT_ORION
+       depends on MV64360 || MV64X60 || 6xx || PLAT_ORION
        select INET_LRO
        select PHYLIB
        help


-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.crux.it/
