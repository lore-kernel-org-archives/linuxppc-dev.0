Return-Path: <holger.brunck@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.1])
 by ozlabs.org (Postfix) with SMTP id 221862C0109
 for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2012 02:20:36 +1100 (EST)
From: Holger Brunck <holger.brunck@keymile.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc/83xx: fix checkpatch warnings for km83xx.c
Date: Fri,  7 Dec 2012 16:09:13 +0100
Message-Id: <1354892956-14623-2-git-send-email-holger.brunck@keymile.com>
In-Reply-To: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
References: <1354892956-14623-1-git-send-email-holger.brunck@keymile.com>
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
 arch/powerpc/platforms/83xx/km83xx.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index 89923d7..cb6460c 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -28,8 +28,8 @@
 #include <linux/of_device.h>
 
 #include <linux/atomic.h>
-#include <asm/time.h>
-#include <asm/io.h>
+#include <linux/time.h>
+#include <linux/io.h>
 #include <asm/machdep.h>
 #include <asm/ipic.h>
 #include <asm/irq.h>
@@ -88,15 +88,13 @@ static void __init mpc83xx_km_setup_arch(void)
 
 		np_par = of_find_node_by_name(NULL, "par_io");
 		if (np_par == NULL) {
-			printk(KERN_WARNING "%s couldn;t find par_io node\n",
-				__func__);
+			pr_warn("%s couldn;t find par_io node\n", __func__);
 			return;
 		}
 		/* Map Parallel I/O ports registers */
 		ret = of_address_to_resource(np_par, 0, &res);
 		if (ret) {
-			printk(KERN_WARNING "%s couldn;t map par_io registers\n",
-				__func__);
+			pr_warn("%s couldn;t map par_io registers\n", __func__);
 			return;
 		}
 
-- 
1.7.1
