Return-Path: <Wenbin.Song@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 866741A058C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2015 19:45:24 +1000 (AEST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C067D14012C
 for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2015 19:45:23 +1000 (AEST)
From: songwenbin <Wenbin.Song@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v2 1/2] powerpc/mpc8xxx: Change EDAC for FSL SoC
Date: Thu, 7 May 2015 17:41:37 +0800
Message-ID: <1430991698-29832-1-git-send-email-Wenbin.Song@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai.hu@freescale.com, York Sun <yorksun@freescale.com>,
 songwenbin <wenbin.song@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: York Sun <yorksun@freescale.com>

Remove mpc83xx and mpc85xx as dependency.

Signed-off-by: York Sun <yorksun@freescale.com>
Signed-off-by: songwenbin <wenbin.song@freescale.com>
---
 drivers/edac/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index cb59619..ad07d4f 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -262,10 +262,10 @@ config EDAC_SBRIDGE
 
 config EDAC_MPC85XX
 	tristate "Freescale MPC83xx / MPC85xx"
-	depends on EDAC_MM_EDAC && FSL_SOC && (PPC_83xx || PPC_85xx)
+	depends on EDAC_MM_EDAC && FSL_SOC
 	help
 	  Support for error detection and correction on the Freescale
-	  MPC8349, MPC8560, MPC8540, MPC8548
+	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
 
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
-- 
2.1.0.27.g96db324
