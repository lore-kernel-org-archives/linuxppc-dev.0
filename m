Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E0927DDEC5
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 06:09:55 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l93K9pEM007426
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 13:09:51 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l93K9osa017848
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 15:09:50 -0500 (CDT)
Subject: [PATCH 3/5] Treat 8610 host bridge as transparent
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1191442190.21463.82.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 03 Oct 2007 15:09:50 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jason Jin <Jason.jin@freescale.com>

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>
---
 arch/powerpc/sysdev/fsl_pci.c |    1 +
 include/linux/pci_ids.h       |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 34cad96..98290f4 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -259,3 +259,4 @@ DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_transpare
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_transparent);
 DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_transparent);
+DECLARE_PCI_FIXUP_EARLY(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_transparent);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 545f24c..bb244a4 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2104,6 +2104,7 @@
 #define PCI_DEVICE_ID_MPC8572		0x0041
 #define PCI_DEVICE_ID_MPC8641		0x7010
 #define PCI_DEVICE_ID_MPC8641D		0x7011
+#define PCI_DEVICE_ID_MPC8610		0x7018
 
 #define PCI_VENDOR_ID_PASEMI		0x1959
 
-- 
1.5.3
