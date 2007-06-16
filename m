Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 45F29DDE21
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 19:33:48 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [updated PATCH] mpc82xx_ads build fix
Date: Sat, 16 Jun 2007 11:33:34 +0200
References: <20070616000511.712667424@arndb.de>
	<20070616000618.576806652@arndb.de>
	<20070616173738.d5a7f707.sfr@canb.auug.org.au>
In-Reply-To: <20070616173738.d5a7f707.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200706161133.34943.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This seems to be a small artifact of the conversion from arch/ppc.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
Index: linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -49,7 +49,7 @@
 #include <linux/fs_enet_pd.h>
 
 #include <sysdev/fsl_soc.h>
-#include <../sysdev/cpm2_pic.h>
+#include <sysdev/cpm2_pic.h>
 
 #include "pq2ads.h"
 
