Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02E9C1A010D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:19 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 21 Sep 2015 16:42:17 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 58E393578052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:16 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8L6g79D64684278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:42:16 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8L6fhPo014171
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 16:41:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 04/31] powerpc/mm: make a separate copy for book3s (part 2)
Date: Mon, 21 Sep 2015 12:10:31 +0530
Message-Id: <1442817658-2588-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Keep it seperate to make rebasing easier

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 4 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 1a58a05be99c..a7738dfbe7e5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC32_H
-#define _ASM_POWERPC_PGTABLE_PPC32_H
+#ifndef _ASM_POWERPC_BOOK3S_32_PGTABLE_H
+#define _ASM_POWERPC_BOOK3S_32_PGTABLE_H
 
 #include <asm-generic/pgtable-nopmd.h>
 
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 4f7d8e2f2a2f..449c61a5d9b0 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_POWERPC_PGTABLE_PPC64_H_
-#define _ASM_POWERPC_PGTABLE_PPC64_H_
+#ifndef _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
+#define _ASM_POWERPC_BOOK3S_64_PGTABLE_H_
 /*
  * This file contains the functions and defines necessary to modify and use
  * the ppc64 hashed page table.
@@ -615,4 +615,4 @@ static inline int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
 	return true;
 }
 #endif /* __ASSEMBLY__ */
-#endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
+#endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
-- 
2.5.0
