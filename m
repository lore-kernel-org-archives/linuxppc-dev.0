Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk5B1xtWzDqN1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:02 +1000 (AEST)
Received: by mail-lf0-x244.google.com with SMTP id z203so643061lfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:02 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, aneesh.kumar@linux.vnet.ibm.com,
 scottwood@freescale.com, imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0219/1529] Fix typo
Date: Sat, 21 May 2016 14:04:52 +0200
Message-Id: <20160521120452.11363-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/include/asm/pte-common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index 2eeaf80..4ba26dd 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -96,7 +96,7 @@ static inline bool pte_user(pte_t pte)
 #define PTE_RPN_SHIFT	(PAGE_SHIFT)
 #endif
 
-/* The mask convered by the RPN must be a ULL on 32-bit platforms with
+/* The mask covered by the RPN must be a ULL on 32-bit platforms with
  * 64-bit PTEs
  */
 #if defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
-- 
2.8.2.534.g1f66975
