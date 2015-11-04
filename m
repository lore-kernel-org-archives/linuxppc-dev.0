Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AFEDF1A0BAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:23 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:21 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3690AE0063
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:35 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DD51e327970
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:06 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DCwZT012561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:04 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 04/50] powerpc/powernv: Cleanup on
 pnv_pci_ioda_controller_ops
Date: Thu,  5 Nov 2015 00:12:04 +1100
Message-Id: <1446642770-4681-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This cleans up on pnv_pci_ioda_controller_ops struct to use tab
instead of space indent of statement to avoid complains from
scripts/checkpatch.pl. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2e2bedb..aa3645c 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3064,17 +3064,17 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 }
 
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
-       .dma_dev_setup = pnv_pci_dma_dev_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
-       .setup_msi_irqs = pnv_setup_msi_irqs,
-       .teardown_msi_irqs = pnv_teardown_msi_irqs,
+	.setup_msi_irqs		= pnv_setup_msi_irqs,
+	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
-       .enable_device_hook = pnv_pci_enable_device_hook,
-       .window_alignment = pnv_pci_window_alignment,
-       .reset_secondary_bus = pnv_pci_reset_secondary_bus,
-       .dma_set_mask = pnv_pci_ioda_dma_set_mask,
-       .dma_get_required_mask = pnv_pci_ioda_dma_get_required_mask,
-       .shutdown = pnv_pci_ioda_shutdown,
+	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.window_alignment	= pnv_pci_window_alignment,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
+	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
+	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
-- 
2.1.0
