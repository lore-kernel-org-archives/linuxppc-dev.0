Return-Path: <dsd@ntlworld.com>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com
	[81.103.221.57]) by ozlabs.org (Postfix) with ESMTP id C030867A3A
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2006 08:20:18 +1000 (EST)
From: Daniel Drake <dsd@gentoo.org>
To: benh@kernel.crashing.org
Subject: [PATCH] PMAC_APM_EMU should depend on ADB_PMU
Message-Id: <20060711212528.2FEC88B2EBD@zog.reactivated.net>
Date: Tue, 11 Jul 2006 22:25:28 +0100 (BST)
Cc: linuxppc-dev@ozlabs.org, kugelfang@gentoo.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Danny van Dyk <kugelfang@gentoo.org>

This patch fixes undefined refereneces to pmu_ symbols on 2.6.17.

Signed-Off-By: Danny van Dyk <kugelfang@gentoo.org>
Signed-off-by: Daniel Drake <dsd@gentoo.org>

Index: linux/drivers/macintosh/Kconfig
===================================================================
--- linux.orig/drivers/macintosh/Kconfig
+++ linux/drivers/macintosh/Kconfig
@@ -100,7 +100,7 @@ config PMAC_SMU
 
 config PMAC_APM_EMU
 	tristate "APM emulation"
-	depends on PPC_PMAC && PPC32 && PM
+	depends on PPC_PMAC && PPC32 && PM && ADB_PMU
 
 config PMAC_MEDIABAY
 	bool "Support PowerBook hotswap media bay"
