Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2801EB6EF1
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Aug 2010 00:03:36 +1000 (EST)
Date: Sun, 8 Aug 2010 18:03:33 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/85xx: Add P1021 PCI IDs and quirks
Message-ID: <20100808140333.GA4706@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is needed for proper PCI-E support on P1021 SoCs.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 include/linux/pci_ids.h       |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 209384b..4ae9332 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -399,6 +399,8 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1021E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1021, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010E, quirk_fsl_pcie_header);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index c81eec4..fc987b4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2300,6 +2300,8 @@
 #define PCI_DEVICE_ID_P2010		0x0079
 #define PCI_DEVICE_ID_P1020E		0x0100
 #define PCI_DEVICE_ID_P1020		0x0101
+#define PCI_DEVICE_ID_P1021E		0x0102
+#define PCI_DEVICE_ID_P1021		0x0103
 #define PCI_DEVICE_ID_P1011E		0x0108
 #define PCI_DEVICE_ID_P1011		0x0109
 #define PCI_DEVICE_ID_P1022E		0x0110
-- 
1.7.0.5
