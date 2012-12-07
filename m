Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 2862A2C0134
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 02:20:36 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/5] powerpc/82xx: fix checkpatch warnings for km82xx.c
Date: Fri,  7 Dec 2012 16:09:12 +0100
Message-Id: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
Cc: Holger Brunck <holger.brunck@keymile.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Holger Brunck <holger.brunck@keymile.com>
cc: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/platforms/82xx/km82xx.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index cf964e1..058cc18 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -18,11 +18,11 @@
 #include <linux/fsl_devices.h>
 #include <linux/of_platform.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/cpm2.h>
 #include <asm/udbg.h>
 #include <asm/machdep.h>
-#include <asm/time.h>
+#include <linux/time.h>
 #include <asm/mpc8260.h>
 #include <asm/prom.h>
 
@@ -36,7 +36,7 @@ static void __init km82xx_pic_init(void)
 	struct device_node *np = of_find_compatible_node(NULL, NULL,
 							"fsl,pq2-pic");
 	if (!np) {
-		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+		pr_err("PIC init: can not find cpm-pic node\n");
 		return;
 	}
 
-- 
1.7.1
