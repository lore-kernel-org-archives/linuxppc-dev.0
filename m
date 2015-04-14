Return-Path: <dja@axtens.net>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C92D1A1147
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Apr 2015 15:29:19 +1000 (AEST)
Received: by paboj16 with SMTP id oj16so126414939pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Apr 2015 22:29:17 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] toshiba: Remove celleb from Kconfig options
Date: Tue, 14 Apr 2015 15:28:44 +1000
Message-Id: <1428989326-7637-1-git-send-email-dja@axtens.net>
Cc: netdev@vger.kernel.org, Valentin Rothberg <valentinrothberg@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The toshiba drivers had celleb as an optional dependency.
celleb has been dropped [1], so clean that out of Kconfig.

[1] http://patchwork.ozlabs.org/patch/451730/

CC: netdev@vger.kernel.org
CC: Valentin Rothberg <valentinrothberg@gmail.com>
CC: mpe@ellerman.id.au
CC: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Daniel Axtens <dja@axtens.net>

---
v2: get name of ozlab*s*.org right. Sorry all.
---
 drivers/net/ethernet/toshiba/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/toshiba/Kconfig b/drivers/net/ethernet/toshiba/Kconfig
index 74acb5c..5d244b6 100644
--- a/drivers/net/ethernet/toshiba/Kconfig
+++ b/drivers/net/ethernet/toshiba/Kconfig
@@ -5,7 +5,7 @@
 config NET_VENDOR_TOSHIBA
 	bool "Toshiba devices"
 	default y
-	depends on PCI && (PPC_IBM_CELL_BLADE || PPC_CELLEB || MIPS) || PPC_PS3
+	depends on PCI && (PPC_IBM_CELL_BLADE || MIPS) || PPC_PS3
 	---help---
 	  If you have a network (Ethernet) card belonging to this class, say Y
 	  and read the Ethernet-HOWTO, available from
@@ -42,7 +42,7 @@ config GELIC_WIRELESS
 
 config SPIDER_NET
 	tristate "Spider Gigabit Ethernet driver"
-	depends on PCI && (PPC_IBM_CELL_BLADE || PPC_CELLEB)
+	depends on PCI && PPC_IBM_CELL_BLADE
 	select FW_LOADER
 	select SUNGEM_PHY
 	---help---
-- 
2.1.4
