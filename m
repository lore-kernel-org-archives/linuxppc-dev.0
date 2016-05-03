Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzW7m4hwxzDvMs
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 16:13:24 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:42:48 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 6C77E357805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:42:45 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435gbLJ6619498
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:45 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gC89018716
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:13 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 02/26] powerpc/powernv: Cleanup on pci_controller_ops
 instances
Date: Tue,  3 May 2016 15:41:21 +1000
Message-Id: <1462254105-24128-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This cleans up on below data struct instances to use tab instead of
space indent of statement to avoid complains from scripts/checkpatch.pl.
No logical changes introduced.

  @pnv_pci_ioda_controller_ops
  @pnv_npu_ioda_controller_ops

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 36 +++++++++++++++----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index c5baaf3..524c9c7 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3210,31 +3210,31 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 }
 
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
-       .dma_dev_setup = pnv_pci_dma_dev_setup,
-       .dma_bus_setup = pnv_pci_dma_bus_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
+	.dma_bus_setup		= pnv_pci_dma_bus_setup,
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
 
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
-	.dma_dev_setup = pnv_pci_dma_dev_setup,
+	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 #ifdef CONFIG_PCI_MSI
-	.setup_msi_irqs = pnv_setup_msi_irqs,
-	.teardown_msi_irqs = pnv_teardown_msi_irqs,
+	.setup_msi_irqs		= pnv_setup_msi_irqs,
+	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 #endif
-	.enable_device_hook = pnv_pci_enable_device_hook,
-	.window_alignment = pnv_pci_window_alignment,
-	.reset_secondary_bus = pnv_pci_reset_secondary_bus,
-	.dma_set_mask = pnv_npu_dma_set_mask,
-	.shutdown = pnv_pci_ioda_shutdown,
+	.enable_device_hook	= pnv_pci_enable_device_hook,
+	.window_alignment	= pnv_pci_window_alignment,
+	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
+	.dma_set_mask		= pnv_npu_dma_set_mask,
+	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
 static void __init pnv_pci_init_ioda_phb(struct device_node *np,
-- 
2.1.0
