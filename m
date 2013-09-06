Return-Path: <R58495@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DDC72C0121
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Sep 2013 01:43:51 +1000 (EST)
From: York Sun <yorksun@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/7] powerpc/mpc8xxx: Change EDAC for FSL SoC
Date: Fri, 6 Sep 2013 08:43:14 -0700
Message-ID: <1378482199-10581-2-git-send-email-yorksun@freescale.com>
In-Reply-To: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
References: <1378482199-10581-1-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Remove mpc83xx and mpc85xx as dependency.

Signed-off-by: York Sun <yorksun@freescale.com>
Reviewed-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
Tested-by: Fleming Andrew-AFLEMING <AFLEMING@freescale.com>
---
 drivers/edac/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 878f090..53bf163 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -254,10 +254,10 @@ config EDAC_SBRIDGE
 
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
1.7.9.5
