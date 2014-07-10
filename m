Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 057A41A0186
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:34 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 7/9] powerpc: Remove power3 from comments
Date: Thu, 10 Jul 2014 12:29:24 +1000
Message-Id: <1404959366-17664-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are still a few occurences where it remains, because it helps to
explain something that persists.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/copyuser_64.S       | 3 +--
 arch/powerpc/mm/mmu_context_hash32.c | 2 +-
 arch/powerpc/mm/ppc_mmu_32.c         | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 0860ee46013c..f09899e35991 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -461,8 +461,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_UNALIGNED_LD_STD)
 /*
  * Routine to copy a whole page of data, optimized for POWER4.
  * On POWER4 it is more than 50% faster than the simple loop
- * above (following the .Ldst_aligned label) but it runs slightly
- * slower on POWER3.
+ * above (following the .Ldst_aligned label).
  */
 .Lcopy_page_4K:
 	std	r31,-32(1)
diff --git a/arch/powerpc/mm/mmu_context_hash32.c b/arch/powerpc/mm/mmu_context_hash32.c
index 78fef6726e10..aa5a7fd89461 100644
--- a/arch/powerpc/mm/mmu_context_hash32.c
+++ b/arch/powerpc/mm/mmu_context_hash32.c
@@ -2,7 +2,7 @@
  * This file contains the routines for handling the MMU on those
  * PowerPC implementations where the MMU substantially follows the
  * architecture specification.  This includes the 6xx, 7xx, 7xxx,
- * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
+ * and 8260 implementations but excludes the 8xx and 4xx.
  *  -- paulus
  *
  *  Derived from arch/ppc/mm/init.c:
diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
index 11571e118831..5029dc19b517 100644
--- a/arch/powerpc/mm/ppc_mmu_32.c
+++ b/arch/powerpc/mm/ppc_mmu_32.c
@@ -2,7 +2,7 @@
  * This file contains the routines for handling the MMU on those
  * PowerPC implementations where the MMU substantially follows the
  * architecture specification.  This includes the 6xx, 7xx, 7xxx,
- * 8260, and POWER3 implementations but excludes the 8xx and 4xx.
+ * and 8260 implementations but excludes the 8xx and 4xx.
  *  -- paulus
  *
  *  Derived from arch/ppc/mm/init.c:
-- 
1.9.1
