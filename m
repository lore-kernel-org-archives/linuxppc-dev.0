Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 274E2679FD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 04:00:01 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5MI004u013054
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:00:00 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5MHxxuH008694
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 12:59:59 -0500 (CDT)
Subject: [PATCH] Remove redundant PPC_86XX check.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1150999165.9022.67.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 22 Jun 2006 12:59:25 -0500
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
 arch/powerpc/platforms/86xx/Makefile |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 7be796c..476a6ee 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -2,9 +2,6 @@ #
 # Makefile for the PowerPC 86xx linux kernel.
 #
 
-
-ifeq ($(CONFIG_PPC_86xx),y)
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
-endif
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
 obj-$(CONFIG_PCI)		+= pci.o mpc86xx_pcie.o
-- 
2006_06_07.01.gittree_pull-dirty
