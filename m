Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B001B7BF2
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 04:27:31 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id nA5HRM8v014601
	for <linuxppc-dev@ozlabs.org>; Thu, 5 Nov 2009 11:27:23 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Add PCI device ids for new QoirQ chips
Date: Thu,  5 Nov 2009 11:27:22 -0600
Message-Id: <1257442042-3659-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   14 ++++++++++++++
 include/linux/pci_ids.h       |   14 ++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index cf57a42..4e3a3e3 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -392,8 +392,22 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8536, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1011E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1011, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080, quirk_fsl_pcie_header);
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b0f0f38..3b087cb 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2288,6 +2288,20 @@
 #define PCI_DEVICE_ID_MPC8536		0x0051
 #define PCI_DEVICE_ID_P2020E		0x0070
 #define PCI_DEVICE_ID_P2020		0x0071
+#define PCI_DEVICE_ID_P2010E		0x0078
+#define PCI_DEVICE_ID_P2010		0x0079
+#define PCI_DEVICE_ID_P1020E		0x0100
+#define PCI_DEVICE_ID_P1020		0x0101
+#define PCI_DEVICE_ID_P1011E		0x0108
+#define PCI_DEVICE_ID_P1011		0x0109
+#define PCI_DEVICE_ID_P1022E		0x0110
+#define PCI_DEVICE_ID_P1022		0x0111
+#define PCI_DEVICE_ID_P1013E		0x0118
+#define PCI_DEVICE_ID_P1013		0x0119
+#define PCI_DEVICE_ID_P4080E		0x0400
+#define PCI_DEVICE_ID_P4080		0x0401
+#define PCI_DEVICE_ID_P4040E		0x0408
+#define PCI_DEVICE_ID_P4040		0x0409
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 #define PCI_DEVICE_ID_MPC8610		0x7018
-- 
1.6.0.6
