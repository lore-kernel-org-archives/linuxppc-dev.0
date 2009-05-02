Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 9E8AFDDEF0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 12:16:49 +1000 (EST)
Date: Sat, 2 May 2009 06:16:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/6] powerpc/85xx: Add PCI IDs for MPC8569 family processors
Message-ID: <20090502021647.GA18281@oksana.dev.rtsoft.ru>
References: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090502021611.GA17570@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds PCI IDs for MPC8569 and MPC8569E processors,
plus adds appropriate quirks for these IDs, and thus makes
PCI-E actually work on MPC8569E-MDS boards.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    2 ++
 include/linux/pci_ids.h       |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 376603d..94d8b3f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -285,6 +285,8 @@ DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8547E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8569E, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8569, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_header);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 06ba90c..7cc5b80 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2274,6 +2274,8 @@
 #define PCI_DEVICE_ID_MPC8547E		0x0018
 #define PCI_DEVICE_ID_MPC8545E		0x0019
 #define PCI_DEVICE_ID_MPC8545		0x001a
+#define PCI_DEVICE_ID_MPC8569E		0x0061
+#define PCI_DEVICE_ID_MPC8569		0x0060
 #define PCI_DEVICE_ID_MPC8568E		0x0020
 #define PCI_DEVICE_ID_MPC8568		0x0021
 #define PCI_DEVICE_ID_MPC8567E		0x0022
-- 
1.6.2.2
