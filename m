Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2345CDE08A
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 16:43:15 +1000 (EST)
Date: Fri, 23 May 2008 16:28:54 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeff Garzik <jeff@garzik.org>
Subject: [PATCH 06/12] net: use linux/of_{device,platform}.h instead of asm
Message-Id: <20080523162854.2e6ea8f0.sfr@canb.auug.org.au>
In-Reply-To: <20080523161627.a75d5010.sfr@canb.auug.org.au>
References: <20080523161627.a75d5010.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/fs_enet/fs_enet-main.c |    2 +-
 drivers/net/fs_enet/mac-scc.c      |    2 +-
 drivers/net/fs_enet/mii-fec.c      |    2 +-
 drivers/net/ibm_newemac/core.h     |    2 +-
 drivers/net/ucc_geth.c             |    2 +-
 drivers/net/ucc_geth_mii.c         |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index 67b4b07..1231048 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -43,7 +43,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 #endif
 
 #include "fs_enet.h"
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index d7ca319..e3557ec 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -44,7 +44,7 @@
 #endif
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 #endif
 
 #include "fs_enet.h"
diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index f0014cf..8f6a43b 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -37,7 +37,7 @@
 #include <asm/uaccess.h>
 
 #ifdef CONFIG_PPC_CPM_NEW_BINDING
-#include <asm/of_platform.h>
+#include <linux/of_platform.h>
 #endif
 
 #include "fs_enet.h"
diff --git a/drivers/net/ibm_newemac/core.h b/drivers/net/ibm_newemac/core.h
index 1683db9..2230904 100644
--- a/drivers/net/ibm_newemac/core.h
+++ b/drivers/net/ibm_newemac/core.h
@@ -33,8 +33,8 @@
 #include <linux/netdevice.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/io.h>
 #include <asm/dcr.h>
 
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index ca0bdac..1fb504c 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -28,8 +28,8 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/workqueue.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/io.h>
diff --git a/drivers/net/ucc_geth_mii.c b/drivers/net/ucc_geth_mii.c
index 9404747..6d9e7ad 100644
--- a/drivers/net/ucc_geth_mii.c
+++ b/drivers/net/ucc_geth_mii.c
@@ -36,8 +36,8 @@
 #include <linux/mii.h>
 #include <linux/phy.h>
 #include <linux/fsl_devices.h>
+#include <linux/of_platform.h>
 
-#include <asm/of_platform.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/uaccess.h>
-- 
1.5.5.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
