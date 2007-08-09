Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 00C5EDDFCA
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2007 05:19:15 +1000 (EST)
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/11] powermac pci_ops: use named structure member
	initializers
Date: Thu,  9 Aug 2007 14:18:41 -0500
Message-Id: <11866871493676-git-send-email-ntl@pobox.com>
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
 arch/powerpc/platforms/powermac/pci.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
index 92586db..69d67ff 100644
--- a/arch/powerpc/platforms/powermac/pci.c
+++ b/arch/powerpc/platforms/powermac/pci.c
@@ -225,8 +225,8 @@ static int macrisc_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops macrisc_pci_ops =
 {
-	macrisc_read_config,
-	macrisc_write_config
+	.read = macrisc_read_config,
+	.write = macrisc_write_config,
 };
 
 #ifdef CONFIG_PPC32
@@ -280,8 +280,8 @@ chaos_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
 
 static struct pci_ops chaos_pci_ops =
 {
-	chaos_read_config,
-	chaos_write_config
+	.read = chaos_read_config,
+	.write = chaos_write_config,
 };
 
 static void __init setup_chaos(struct pci_controller *hose,
@@ -456,8 +456,8 @@ static int u3_ht_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops u3_ht_pci_ops =
 {
-	u3_ht_read_config,
-	u3_ht_write_config
+	.read = u3_ht_read_config,
+	.write = u3_ht_write_config,
 };
 
 #define U4_PCIE_CFA0(devfn, off)	\
@@ -561,8 +561,8 @@ static int u4_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 
 static struct pci_ops u4_pcie_pci_ops =
 {
-	u4_pcie_read_config,
-	u4_pcie_write_config
+	.read = u4_pcie_read_config,
+	.write = u4_pcie_write_config,
 };
 
 #endif /* CONFIG_PPC64 */
-- 
1.5.2.4
