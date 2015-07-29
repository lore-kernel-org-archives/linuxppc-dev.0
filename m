Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3921A1761
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:40 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 449C1140E41
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:39 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:37 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 898E1E0083
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:44:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A8qk48496888
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A69N001132
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 1/8] powerpc/slb: Remove a duplicate extern variable
Date: Wed, 29 Jul 2015 12:39:58 +0530
Message-Id: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch just removes one redundant entry for one extern variable
'slb_compare_rr_to_size' from the scope. This patch does not change
any functionality.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 6e450ca..62fafb3 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -253,7 +253,6 @@ static inline void patch_slb_encoding(unsigned int *insn_addr,
 	patch_instruction(insn_addr, insn);
 }
 
-extern u32 slb_compare_rr_to_size[];
 extern u32 slb_miss_kernel_load_linear[];
 extern u32 slb_miss_kernel_load_io[];
 extern u32 slb_compare_rr_to_size[];
-- 
2.1.0
