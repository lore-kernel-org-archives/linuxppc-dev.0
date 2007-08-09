Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 96086DDFDF
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:07 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 04/11] maple pci_ops: use named structure member initializers
Date: Thu,  9 Aug 2007 14:18:39 -0500
Message-Id: <11866871411555-git-send-email-ntl@pobox.com>
In-Reply-To: <11866871262306-git-send-email-ntl@pobox.com>
References: <11866871262306-git-send-email-ntl@pobox.com>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---
 arch/powerpc/platforms/maple/pci.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/maple/pci.c b/arch/powerpc/platforms/maple/pci.c
index 2542403..6247f94 100644
--- a/arch/powerpc/platforms/maple/pci.c
+++ b/arch/powerpc/platforms/maple/pci.c
@@ -185,8 +185,8 @@ static int u3_agp_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops u3_agp_pci_ops =
 {
-	u3_agp_read_config,
-	u3_agp_write_config
+	.read = u3_agp_read_config,
+	.write = u3_agp_write_config,
 };
 
 static unsigned long u3_ht_cfa0(u8 devfn, u8 off)
@@ -284,8 +284,8 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops u3_ht_pci_ops =
 {
-	u3_ht_read_config,
-	u3_ht_write_config
+	.read = u3_ht_read_config,
+	.write = u3_ht_write_config,
 };
 
 static unsigned int u4_pcie_cfa0(unsigned int devfn, unsigned int off)
@@ -392,8 +392,8 @@ static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops u4_pcie_pci_ops =
 {
-        u4_pcie_read_config,
-        u4_pcie_write_config
+	.read = u4_pcie_read_config,
+	.write = u4_pcie_write_config,
 };
 
 static void __init setup_u3_agp(struct pci_controller* hose)
-- 
1.5.2.4
