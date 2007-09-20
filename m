Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id 096E5DDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 20:43:16 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so411520uge
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 03:43:14 -0700 (PDT)
Message-Id: <20070920104312.898504549@sunsite.dk>
References: <20070920104211.896143373@sunsite.dk>
Date: Thu, 20 Sep 2007 12:42:12 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@ozlabs.org,
 galak@kernel.crashing.org
Subject: [patch 1/3] fsl_soc: Fix trivial printk typo.
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: "G. Liakhovetski" <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix a trivial printk typo in fsl_soc.

Cc: G. Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/sysdev/fsl_soc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux.orig/arch/powerpc/sysdev/fsl_soc.c
+++ linux/arch/powerpc/sysdev/fsl_soc.c
@@ -346,7 +346,7 @@
 
 		addr = of_get_property(node, "reg", &len);
 		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
-			printk(KERN_WARNING "fsl_ioc.c: invalid i2c device entry\n");
+			printk(KERN_WARNING "fsl_soc.c: invalid i2c device entry\n");
 			continue;
 		}
 

-- 
Bye, Peter Korsgaard
