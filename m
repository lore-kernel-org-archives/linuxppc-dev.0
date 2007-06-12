Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 3BD7FDDEE1
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 02:44:32 +1000 (EST)
Message-Id: <20070612163751.702376215@arndb.de>
References: <20070612163016.253915076@arndb.de>
Date: Tue, 12 Jun 2007 18:30:26 +0200
From: arnd@arndb.de
To: paulus@samba.org
Subject: [patch 10/13] powerpc: mpc82xx_ads build fix
Cc: linuxppc-dev@ozlabs.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

needed for 6xx allyesconfig

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
--- linux-2.6.orig/arch/powerpc/platforms/82xx/mpc82xx_ads.c
+++ linux-2.6/arch/powerpc/platforms/82xx/mpc82xx_ads.c
@@ -49,7 +49,7 @@
 #include <linux/fs_enet_pd.h>
 
 #include <sysdev/fsl_soc.h>
-#include <../sysdev/cpm2_pic.h>
+#include <../../sysdev/cpm2_pic.h>
 
 #include "pq2ads.h"
 

--
