Return-Path: <B48286@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0124.outbound.protection.outlook.com [65.55.169.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 425381A0ACF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 22:47:02 +1000 (AEST)
From: Zhiqiang Hou <B48286@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
CC: <b21284@freescale.com>, <b40534@freescale.com>, Hou Zhiqiang
 <B48286@freescale.com>
Subject: [PATCH] c293/pci: remove hook pcibios_fixup_phb
Date: Tue, 21 Jul 2015 18:10:00 +0800
Message-ID: <1437473400-11184-1-git-send-email-B48286@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hou Zhiqiang <B48286@freescale.com>

The c293pcie board is an endpoint device, and it does't need PM.

Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
 arch/powerpc/platforms/85xx/c293pcie.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/platforms/85xx/c293pcie.c b/arch/powerpc/platforms/85xx/c293pcie.c
index 84476b6..213d5b8 100644
--- a/arch/powerpc/platforms/85xx/c293pcie.c
+++ b/arch/powerpc/platforms/85xx/c293pcie.c
@@ -68,7 +68,6 @@ define_machine(c293_pcie) {
 	.init_IRQ		= c293_pcie_pic_init,
 #ifdef CONFIG_PCI
 	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
-	.pcibios_fixup_phb      = fsl_pcibios_fixup_phb,
 #endif
 	.get_irq		= mpic_get_irq,
 	.restart		= fsl_rstcr_restart,
-- 
2.1.0.27.g96db324
