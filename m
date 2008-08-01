Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D28CDDF75
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Aug 2008 06:34:12 +1000 (EST)
Date: Fri, 1 Aug 2008 15:32:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] fsl_soc: Remove some obsolete prototypes and headers.
Message-ID: <20080801203211.GA16047@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 214388e..20180bf 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -27,8 +27,6 @@
 #include <linux/phy_fixed.h>
 #include <linux/spi/spi.h>
 #include <linux/fsl_devices.h>
-#include <linux/fs_enet_pd.h>
-#include <linux/fs_uart_pd.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -40,9 +38,6 @@
 #include <mm/mmu_decl.h>
 #include <asm/cpm2.h>
 
-extern void init_fcc_ioports(struct fs_platform_info*);
-extern void init_fec_ioports(struct fs_platform_info*);
-extern void init_smc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
-- 
1.5.6.rc1.6.gc53ad.dirty
