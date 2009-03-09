Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 21662DE143
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 03:39:13 +1100 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc/kernel: typo: s/resouces/resources/
Date: Mon,  9 Mar 2009 17:39:01 +0100
Message-Id: <1236616741-6949-1-git-send-email-w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 arch/powerpc/kernel/pci-common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 0f41812..f57b7bf 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1453,7 +1453,7 @@ void __init pcibios_resource_survey(void)
 	 * we proceed to assigning things that were left unassigned
 	 */
 	if (!(ppc_pci_flags & PPC_PCI_PROBE_ONLY)) {
-		pr_debug("PCI: Assigning unassigned resouces...\n");
+		pr_debug("PCI: Assigning unassigned resources...\n");
 		pci_assign_unassigned_resources();
 	}
 
-- 
1.5.6.5
