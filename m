Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B6351A05FD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:11 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:10 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id CA4A8357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2SueS11141238
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:04 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2SZeM008497
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 17/31] powerpc/booke: Move booke headers (part 5)
Date: Wed, 30 Sep 2015 07:57:10 +0530
Message-Id: <1443580044-30659-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1443580044-30659-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/nohash/32/pte-40x.h       | 6 +++---
 arch/powerpc/include/asm/nohash/32/pte-44x.h       | 6 +++---
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       | 6 +++---
 arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h | 6 +++---
 arch/powerpc/include/asm/nohash/64/pgtable-4k.h    | 6 +++---
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h   | 6 +++---
 arch/powerpc/include/asm/nohash/pte-book3e.h       | 6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pte-40x.h b/arch/powerpc/include/asm/nohash/32/pte-40x.h
index 486b1ef81338..9624ebdacc47 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-40x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-40x.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_40x_H
-#define _ASM_POWERPC_PTE_40x_H
+#ifndef _ASM_POWERPC_NOHASH_32_PTE_40x_H
+#define _ASM_POWERPC_NOHASH_32_PTE_40x_H
 #ifdef __KERNEL__
 
 /*
@@ -61,4 +61,4 @@
 #define PTE_ATOMIC_UPDATES	1
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_40x_H */
+#endif /*  _ASM_POWERPC_NOHASH_32_PTE_40x_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-44x.h b/arch/powerpc/include/asm/nohash/32/pte-44x.h
index 36f75fab23f5..fdab41c654ef 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-44x.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-44x.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_44x_H
-#define _ASM_POWERPC_PTE_44x_H
+#ifndef _ASM_POWERPC_NOHASH_32_PTE_44x_H
+#define _ASM_POWERPC_NOHASH_32_PTE_44x_H
 #ifdef __KERNEL__
 
 /*
@@ -94,4 +94,4 @@
 
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_44x_H */
+#endif /*  _ASM_POWERPC_NOHASH_32_PTE_44x_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-8xx.h b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
index a0e2ba960976..3742b1919661 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-8xx.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_8xx_H
-#define _ASM_POWERPC_PTE_8xx_H
+#ifndef _ASM_POWERPC_NOHASH_32_PTE_8xx_H
+#define _ASM_POWERPC_NOHASH_32_PTE_8xx_H
 #ifdef __KERNEL__
 
 /*
@@ -62,4 +62,4 @@
 				 _PAGE_HWWRITE | _PAGE_EXEC)
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_8xx_H */
+#endif /*  _ASM_POWERPC_NOHASH_32_PTE_8xx_H */
diff --git a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
index 9f5c3d04a1a3..5422d00c6145 100644
--- a/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
+++ b/arch/powerpc/include/asm/nohash/32/pte-fsl-booke.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_FSL_BOOKE_H
-#define _ASM_POWERPC_PTE_FSL_BOOKE_H
+#ifndef _ASM_POWERPC_NOHASH_32_PTE_FSL_BOOKE_H
+#define _ASM_POWERPC_NOHASH_32_PTE_FSL_BOOKE_H
 #ifdef __KERNEL__
 
 /* PTE bit definitions for Freescale BookE SW loaded TLB MMU based
@@ -37,4 +37,4 @@
 #define PTE_WIMGE_SHIFT (6)
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_FSL_BOOKE_H */
+#endif /*  _ASM_POWERPC_NOHASH_32_PTE_FSL_BOOKE_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
index 7bace25d6b62..fc7d51753f81 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-4k.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_4K_H
-#define _ASM_POWERPC_PGTABLE_PPC64_4K_H
+#ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
+#define _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H
 /*
  * Entries per page directory level.  The PTE level must use a 64b record
  * for each page table entry.  The PMD and PGD level use a 32b record for
@@ -89,4 +89,4 @@ extern struct page *pgd_page(pgd_t pgd);
 #define remap_4k_pfn(vma, addr, pfn, prot)	\
 	remap_pfn_range((vma), (addr), (pfn), PAGE_SIZE, (prot))
 
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_4K_H */
+#endif /* _ _ASM_POWERPC_NOHASH_64_PGTABLE_4K_H */
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index 1de35bbd02a6..a44660d76096 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_64K_H
-#define _ASM_POWERPC_PGTABLE_PPC64_64K_H
+#ifndef _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H
+#define _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H
 
 #include <asm-generic/pgtable-nopud.h>
 
@@ -41,4 +41,4 @@
 #define pgd_pte(pgd)	(pud_pte(((pud_t){ pgd })))
 #define pte_pgd(pte)	((pgd_t)pte_pud(pte))
 
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_64K_H */
+#endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_64K_H */
diff --git a/arch/powerpc/include/asm/nohash/pte-book3e.h b/arch/powerpc/include/asm/nohash/pte-book3e.h
index 8d8473278d91..e16807b78edf 100644
--- a/arch/powerpc/include/asm/nohash/pte-book3e.h
+++ b/arch/powerpc/include/asm/nohash/pte-book3e.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PTE_BOOK3E_H
-#define _ASM_POWERPC_PTE_BOOK3E_H
+#ifndef _ASM_POWERPC_NOHASH_PTE_BOOK3E_H
+#define _ASM_POWERPC_NOHASH_PTE_BOOK3E_H
 #ifdef __KERNEL__
 
 /* PTE bit definitions for processors compliant to the Book3E
@@ -84,4 +84,4 @@
 #endif
 
 #endif /* __KERNEL__ */
-#endif /*  _ASM_POWERPC_PTE_FSL_BOOKE_H */
+#endif /*  _ASM_POWERPC_NOHASH_PTE_BOOK3E_H */
-- 
2.5.0
