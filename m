Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 5A91B67A41
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 04:01:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5MI1KIf026580
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:01:20 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5MI1JK0009347
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:01:19 -0500 (CDT)
Subject: [PATCH] Move I8259 selection under MPC8641HPCN board
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1150999245.9022.70.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 22 Jun 2006 13:00:46 -0500
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
 arch/powerpc/Kconfig                |    1 -
 arch/powerpc/platforms/86xx/Kconfig |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cdaa4b1..45043f0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -786,7 +786,6 @@ config GENERIC_ISA_DMA
 
 config PPC_I8259
 	bool
-	default y if MPC8641_HPCN
 	default n
 
 config PPC_INDIRECT_PCI
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 3a87863..3d2b21a 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -7,6 +7,7 @@ choice
 
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
+	select PPC_I8259
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
-- 
2006_06_07.01.gittree_pull-dirty
