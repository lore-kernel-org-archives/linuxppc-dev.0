Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 172D967A64
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 04:02:22 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5MI2MO2026858
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:02:22 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5MI2LaM009678
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:02:21 -0500 (CDT)
Subject: [PATCH] Remove redundant STD_MMU selection.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1150999307.9022.73.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 22 Jun 2006 13:01:48 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/platforms/86xx/Kconfig |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 3d2b21a..d1ecc0f 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -29,9 +29,4 @@ config PPC_INDIRECT_PCI_BE
 	depends on PPC_86xx
 	default y
 
-config PPC_STD_MMU
-	bool
-	depends on PPC_86xx
-	default y
-
 endmenu
-- 
2006_06_07.01.gittree_pull-dirty
