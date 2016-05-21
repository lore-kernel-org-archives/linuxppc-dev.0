Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk6J2cKqzDqV3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:00 +1000 (AEST)
Received: by mail-lf0-x241.google.com with SMTP id 65so29017lfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:00 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0225/1529] Fix typo
Date: Sat, 21 May 2016 14:05:50 +0200
Message-Id: <20160521120550.11691-1-andrea.gelmini@gelma.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/powerpc/kernel/pci_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 3759df5..f71b79a 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -82,7 +82,7 @@ int pcibios_unmap_io_space(struct pci_bus *bus)
 
 	/* If this is not a PHB, we only flush the hash table over
 	 * the area mapped by this bridge. We don't play with the PTE
-	 * mappings since we might have to deal with sub-page alignemnts
+	 * mappings since we might have to deal with sub-page alignments
 	 * so flushing the hash table is the only sane way to make sure
 	 * that no hash entries are covering that removed bridge area
 	 * while still allowing other busses overlapping those pages
-- 
2.8.2.534.g1f66975
