Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EEE41A0A68
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:00 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D88B4357804F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:58 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2SkNV44302358
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:54 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2SPdu008171
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:26 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 13/31] powerpc/booke: Move booke headers (part 1)
Date: Wed, 30 Sep 2015 07:57:06 +0530
Message-Id: <1443580044-30659-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Move the booke related headers below booke/32 or booke/64

We are splitting this change into multiple patch to make the rebasing
easier. The following patches can be folded into this if needed.
They are kept separate for easier review.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/{pgtable-book3e.h => nohash/pgtable.h} | 0
 arch/powerpc/include/asm/pgtable.h                              | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/include/asm/{pgtable-book3e.h => nohash/pgtable.h} (100%)

diff --git a/arch/powerpc/include/asm/pgtable-book3e.h b/arch/powerpc/include/asm/nohash/pgtable.h
similarity index 100%
rename from arch/powerpc/include/asm/pgtable-book3e.h
rename to arch/powerpc/include/asm/nohash/pgtable.h
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 485b50cd03ff..10f94635ecfb 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -15,7 +15,7 @@ struct mm_struct;
 #ifdef CONFIG_PPC_BOOK3S
 #include <asm/book3s/pgtable.h>
 #else
-#include <asm/pgtable-book3e.h>
+#include <asm/nohash/pgtable.h>
 #endif /* !CONFIG_PPC_BOOK3S */
 
 #ifndef __ASSEMBLY__
-- 
2.5.0
