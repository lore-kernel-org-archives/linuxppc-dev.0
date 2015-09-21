Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA0DF1A0215
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:36 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4039E357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6gMem21299262
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:30 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6g1td014922
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:02 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 15/31] powerpc/booke: Move booke headers (part 3)
Date: Mon, 21 Sep 2015 12:10:42 +0530
Message-Id: <1442817658-2588-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1442817658-2588-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 .../include/asm/{pgtable-ppc64-4k.h => booke/64/pgtable-4k.h}  |  0
 .../asm/{pgtable-ppc64-64k.h => booke/64/pgtable-64k.h}        |  0
 arch/powerpc/include/asm/booke/64/pgtable.h                    | 10 +++++-----
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/powerpc/include/asm/{pgtable-ppc64-4k.h => booke/64/pgtable-4k.h} (100%)
 rename arch/powerpc/include/asm/{pgtable-ppc64-64k.h => booke/64/pgtable-64k.h} (100%)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64-4k.h b/arch/powerpc/include/asm/booke/64/pgtable-4k.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc64-4k.h
rename to arch/powerpc/include/asm/booke/64/pgtable-4k.h
diff --git a/arch/powerpc/include/asm/pgtable-ppc64-64k.h b/arch/powerpc/include/asm/booke/64/pgtable-64k.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-ppc64-64k.h
rename to arch/powerpc/include/asm/booke/64/pgtable-64k.h
diff --git a/arch/powerpc/include/asm/booke/64/pgtable.h b/arch/powerpc/include/asm/booke/64/pgtable.h
index 8c851dbc625f..8cabf26babd9 100644
--- a/arch/powerpc/include/asm/booke/64/pgtable.h
+++ b/arch/powerpc/include/asm/booke/64/pgtable.h
@@ -1,14 +1,14 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_H_
-#define _ASM_POWERPC_PGTABLE_PPC64_H_
+#ifndef _ASM_POWERPC_BOOKE_64_PGTABLE_H
+#define _ASM_POWERPC_BOOKE_64_PGTABLE_H
 /*
  * This file contains the functions and defines necessary to modify and use
  * the ppc64 hashed page table.
  */
 
 #ifdef CONFIG_PPC_64K_PAGES
-#include <asm/pgtable-ppc64-64k.h>
+#include <asm/booke/64/pgtable-64k.h>
 #else
-#include <asm/pgtable-ppc64-4k.h>
+#include <asm/booke/64/pgtable-4k.h>
 #endif
 #include <asm/barrier.h>
 
@@ -629,4 +629,4 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 	return true;
 }
 #endif /* __ASSEMBLY__ */
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
+#endif /* _ASM_POWERPC_BOOKE_64_PGTABLE_H */
-- 
2.5.0
