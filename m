Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D1191A07F5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 05:40:34 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 00:10:32 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3C3E8E0064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CIeUQj6619556
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:30 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CIeTYr013574
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 00:10:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH v3 17/31] powerpc/booke: Move nohash headers (part 5)
Date: Tue, 13 Oct 2015 00:10:01 +0530
Message-Id: <1444675215-19484-18-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1444675215-19484-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
