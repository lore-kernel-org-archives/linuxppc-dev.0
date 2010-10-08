Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8693B71C7
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:02 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J6wCF005798
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:06:58 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/11] powerpc/fsl-booke: Add PCI device ids for
	P2040/P3041/P5010/P5020 QoirQ chips
Date: Fri,  8 Oct 2010 14:06:45 -0500
Message-Id: <1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/sysdev/fsl_pci.c |    8 ++++++++
 include/linux/pci_ids.h       |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 32012a2..4d0b249 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -417,10 +417,18 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020, quirk_fsl_pcie_header);
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
 #if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 10d3330..cded8ed 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2312,6 +2312,14 @@
 #define PCI_DEVICE_ID_P4080		0x0401
 #define PCI_DEVICE_ID_P4040E		0x0408
 #define PCI_DEVICE_ID_P4040		0x0409
+#define PCI_DEVICE_ID_P2040E		0x0410
+#define PCI_DEVICE_ID_P2040		0x0411
+#define PCI_DEVICE_ID_P3041E		0x041E
+#define PCI_DEVICE_ID_P3041		0x041F
+#define PCI_DEVICE_ID_P5020E		0x0420
+#define PCI_DEVICE_ID_P5020		0x0421
+#define PCI_DEVICE_ID_P5010E		0x0428
+#define PCI_DEVICE_ID_P5010		0x0429
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
 #define PCI_DEVICE_ID_MPC8610		0x7018
-- 
1.7.2.3
