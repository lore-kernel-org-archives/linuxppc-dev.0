Return-Path: <anton@ozlabs.org>
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH 23/39] powerpc: Little endian sparse clean up for
 arch/powerpc/platforms/powernv/pci-ioda.c
Date: Mon, 23 Sep 2013 12:04:57 +1000
Message-Id: <1379901913-5945-24-git-send-email-anton@samba.org>
In-Reply-To: <1379901913-5945-1-git-send-email-anton@samba.org>
References: <1379901913-5945-1-git-send-email-anton@samba.org>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 74a5a57..9a903ed 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1106,7 +1106,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	struct pci_controller *hose;
 	struct pnv_phb *phb;
 	unsigned long size, m32map_off, iomap_off, pemap_off;
-	const u64 *prop64;
+	const __be64 *prop64;
 	const u32 *prop32;
 	int len;
 	u64 phb_id;
@@ -1285,7 +1285,7 @@ void __init pnv_pci_init_ioda2_phb(struct device_node *np)
 void __init pnv_pci_init_ioda_hub(struct device_node *np)
 {
 	struct device_node *phbn;
-	const u64 *prop64;
+	const __be64 *prop64;
 	u64 hub_id;
 
 	pr_info("Probing IODA IO-Hub %s\n", np->full_name);
-- 
1.8.1.2
