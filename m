Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkBjZ5HrdzDr1M
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:08:18 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkBjY5Z4xz9sdn
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:08:17 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 39/41] powerpc/mm: Fix build of Book3E/64 with 64K pages
Date: Tue,  5 Jul 2016 15:07:52 +1000
Message-Id: <1467695274-14667-39-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
References: <1467695274-14667-36-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/nohash/64/pgtable-64k.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
index 570fb30..9083245 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable-64k.h
@@ -23,6 +23,7 @@
 #ifndef __ASSEMBLY__
 #define PTE_TABLE_SIZE	PTE_FRAG_SIZE
 #define PMD_TABLE_SIZE	(sizeof(pmd_t) << PMD_INDEX_SIZE)
+#define PUD_TABLE_SIZE	(0)
 #define PGD_TABLE_SIZE	(sizeof(pgd_t) << PGD_INDEX_SIZE)
 #endif	/* __ASSEMBLY__ */
 
-- 
2.7.4
