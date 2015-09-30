Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98F801A0AE6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:25 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 12:29:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 316872CE8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:22 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8U2TErk54919404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:29:22 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8U2Sns0008919
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2015 12:28:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 23/31] powerpc/mm: Increase the width of #define
Date: Wed, 30 Sep 2015 07:57:16 +0530
Message-Id: <1443580044-30659-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

No real change, only style changes

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index f377757d2cbf..f5b57d1c00dc 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -71,22 +71,22 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_PRESENT		0x0001 /* software: pte contains a translation */
-#define _PAGE_USER		0x0002 /* matches one of the PP bits */
+#define _PAGE_PRESENT		0x00001 /* software: pte contains a translation */
+#define _PAGE_USER		0x00002 /* matches one of the PP bits */
 #define _PAGE_BIT_SWAP_TYPE	2
-#define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
-#define _PAGE_GUARDED		0x0008
+#define _PAGE_EXEC		0x00004 /* No execute on POWER4 and newer (we invert) */
+#define _PAGE_GUARDED		0x00008
 /* We can derive Memory coherence from _PAGE_NO_CACHE */
 #define _PAGE_COHERENT		0x0
-#define _PAGE_NO_CACHE		0x0020 /* I: cache inhibit */
-#define _PAGE_WRITETHRU		0x0040 /* W: cache write-through */
-#define _PAGE_DIRTY		0x0080 /* C: page changed */
-#define _PAGE_ACCESSED		0x0100 /* R: page referenced */
-#define _PAGE_RW		0x0200 /* software: user write access allowed */
-#define _PAGE_HASHPTE		0x0400 /* software: pte has an associated HPTE */
-#define _PAGE_BUSY		0x0800 /* software: PTE & hash are busy */
-#define _PAGE_F_GIX		0x7000 /* full page: hidx bits */
-#define _PAGE_F_SECOND		0x8000 /* Whether to use secondary hash or not */
+#define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
+#define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
+#define _PAGE_DIRTY		0x00080 /* C: page changed */
+#define _PAGE_ACCESSED		0x00100 /* R: page referenced */
+#define _PAGE_RW		0x00200 /* software: user write access allowed */
+#define _PAGE_HASHPTE		0x00400 /* software: pte has an associated HPTE */
+#define _PAGE_BUSY		0x00800 /* software: PTE & hash are busy */
+#define _PAGE_F_GIX		0x07000 /* full page: hidx bits */
+#define _PAGE_F_SECOND		0x08000 /* Whether to use secondary hash or not */
 #define _PAGE_SPECIAL		0x10000 /* software: special page */
 
 /* No separate kernel read-only */
-- 
2.5.0
