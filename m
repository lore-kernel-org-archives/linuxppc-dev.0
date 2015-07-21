Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D3D51A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 16:59:07 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9BB82140E0F
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 16:59:06 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 21 Jul 2015 12:29:04 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 67A6D1258061
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:31:58 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6L6wwqd48365576
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:59 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6L6wwIN007389
 for <linuxppc-dev@ozlabs.org>; Tue, 21 Jul 2015 12:28:58 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mikey@neuling.org, mpe@ellerman.id.au
Subject: [RFC 1/8] powerpc/slb: Remove a duplicate extern variable
Date: Tue, 21 Jul 2015 12:28:39 +0530
Message-Id: <1437461926-8908-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>

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
