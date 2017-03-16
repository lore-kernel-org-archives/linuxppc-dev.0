Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkNDd6NLRzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 20:18:09 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] net: ethernet: fs_enet: Remove useless includes
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
 Vitaly Bordug <vbordug@ru.mvista.com>, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Message-Id: <20170316091804.DCA4168481@localhost.localdomain>
Date: Thu, 16 Mar 2017 10:18:04 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CONFIG_8xx is being deprecated. Since the includes dependent on
CONFIG_8xx are useless, just drop them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/net/ethernet/freescale/fs_enet/mac-fec.c | 6 ------
 drivers/net/ethernet/freescale/fs_enet/mac-scc.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
index db9c0bcf54cd..1fc27c97e3b2 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-fec.c
@@ -38,12 +38,6 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_8xx
-#include <asm/8xx_immap.h>
-#include <asm/pgtable.h>
-#include <asm/cpm1.h>
-#endif
-
 #include "fs_enet.h"
 #include "fec.h"
 
diff --git a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
index 96d44cf44fe0..64300ac13e02 100644
--- a/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
+++ b/drivers/net/ethernet/freescale/fs_enet/mac-scc.c
@@ -37,12 +37,6 @@
 #include <asm/irq.h>
 #include <linux/uaccess.h>
 
-#ifdef CONFIG_8xx
-#include <asm/8xx_immap.h>
-#include <asm/pgtable.h>
-#include <asm/cpm1.h>
-#endif
-
 #include "fs_enet.h"
 
 /*************************************************/
-- 
2.12.0
