Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Dec 2006 21:39:30 +1100
Subject: [PATCH 1/9] Add #defines for Hypertransport MSI fields
In-Reply-To: <1166006370.90082.476088563252.qpush@cradle>
Message-Id: <20061213103936.40A6767CFD@ozlabs.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a few #defines for grabbing and working with the address fields
in a HT_CAPTYPE_MSI_MAPPING capability. All from the HT spec v3.00.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/linux/pci_regs.h |    7 +++++++
 1 file changed, 7 insertions(+)

Index: msi/include/linux/pci_regs.h
===================================================================
--- msi.orig/include/linux/pci_regs.h
+++ msi/include/linux/pci_regs.h
@@ -487,6 +487,13 @@
 #define HT_CAPTYPE_UNITID_CLUMP	0x90	/* Unit ID clumping */
 #define HT_CAPTYPE_EXTCONF	0x98	/* Extended Configuration Space Access */
 #define HT_CAPTYPE_MSI_MAPPING	0xA8	/* MSI Mapping Capability */
+#define  HT_MSI_FLAGS		0x02		/* Offset to flags */
+#define  HT_MSI_FLAGS_ENABLE	0x1		/* Mapping enable */
+#define  HT_MSI_FLAGS_FIXED	0x2		/* Fixed mapping only */
+#define  HT_MSI_FIXED_ADDR	0x00000000FEE00000ULL	/* Fixed addr */
+#define  HT_MSI_ADDR_LO		0x04		/* Offset to low addr bits */
+#define  HT_MSI_ADDR_LO_MASK	0xFFF00000	/* Low address bit mask */
+#define  HT_MSI_ADDR_HI		0x08		/* Offset to high addr bits */
 #define HT_CAPTYPE_DIRECT_ROUTE	0xB0	/* Direct routing configuration */
 #define HT_CAPTYPE_VCSET	0xB8	/* Virtual Channel configuration */
 #define HT_CAPTYPE_ERROR_RETRY	0xC0	/* Retry on error configuration */
