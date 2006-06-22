Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 39B3967A6F
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jun 2006 04:03:33 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k5MI3WYI027147
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 11:03:32 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5MI3Vd3009960
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jun 2006 13:03:31 -0500 (CDT)
Subject: [PATCH] Remove obsolete #include <linux/config.h>.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1150999377.9022.76.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 22 Jun 2006 13:02:58 -0500
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
 arch/powerpc/platforms/86xx/mpc8641_hpcn.h |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    1 -
 arch/powerpc/platforms/86xx/pci.c          |    1 -
 include/asm-powerpc/mpc86xx.h              |    1 -
 5 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
index 747e549..d862a9c 100644
--- a/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
+++ b/arch/powerpc/platforms/86xx/mpc8641_hpcn.h
@@ -14,7 +14,6 @@
 #ifndef __MPC8641_HPCN_H__
 #define __MPC8641_HPCN_H__
 
-#include <linux/config.h>
 #include <linux/init.h>
 
 /* PCI-Express memory map */
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 092bca3..cf4fd04 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -12,7 +12,6 @@
  * option) any later version.
  */
 
-#include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
index 944ec4b..167f040 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
@@ -10,7 +10,6 @@
  * option) any later version.
  */
 
-#include <linux/config.h>
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
diff --git a/arch/powerpc/platforms/86xx/pci.c b/arch/powerpc/platforms/86xx/pci.c
index a03b36f..dd7e3bf 100644
--- a/arch/powerpc/platforms/86xx/pci.c
+++ b/arch/powerpc/platforms/86xx/pci.c
@@ -12,7 +12,6 @@
  * option) any later version.
  */
 
-#include <linux/config.h>
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/include/asm-powerpc/mpc86xx.h b/include/asm-powerpc/mpc86xx.h
index d0a6718..1ed72f6 100644
--- a/include/asm-powerpc/mpc86xx.h
+++ b/include/asm-powerpc/mpc86xx.h
@@ -15,7 +15,6 @@ #ifdef __KERNEL__
 #ifndef __ASM_POWERPC_MPC86xx_H__
 #define __ASM_POWERPC_MPC86xx_H__
 
-#include <linux/config.h>
 #include <asm/mmu.h>
 
 #ifdef CONFIG_PPC_86xx
-- 
2006_06_07.01.gittree_pull-dirty
