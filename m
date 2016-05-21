Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk832DHXzDqYc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:31 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id u2so698240lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:31 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0236/1529] Fix typo
Date: Sat, 21 May 2016 14:07:21 +0200
Message-Id: <20160521120721.12305-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/cell/iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 14a582b..9027d7c 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -178,7 +178,7 @@ static int tce_build_cell(struct iommu_table *tbl, long index, long npages,
 	 * default for now.*/
 #ifdef CELL_IOMMU_STRICT_PROTECTION
 	/* to avoid referencing a global, we use a trick here to setup the
-	 * protection bit. "prot" is setup to be 3 fields of 4 bits apprended
+	 * protection bit. "prot" is setup to be 3 fields of 4 bits appended
 	 * together for each of the 3 supported direction values. It is then
 	 * shifted left so that the fields matching the desired direction
 	 * lands on the appropriate bits, and other bits are masked out.
@@ -338,7 +338,7 @@ static unsigned long *cell_iommu_alloc_ptab(struct cbe_iommu *iommu,
 	start_seg = base >> IO_SEGMENT_SHIFT;
 	segments  = size >> IO_SEGMENT_SHIFT;
 	pages_per_segment = 1ull << IO_PAGENO_BITS(page_shift);
-	/* PTEs for each segment must start on a 4K bounday */
+	/* PTEs for each segment must start on a 4K boundary */
 	pages_per_segment = max(pages_per_segment,
 				(1 << 12) / sizeof(unsigned long));
 
-- 
2.8.2.534.g1f66975
