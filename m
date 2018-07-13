Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Rym94YzJzDr55
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 02:23:37 +1000 (AEST)
Message-Id: <237810f0c0051e54eef94777ac5381cc99538a99.1531498345.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1531498345.git.christophe.leroy@c-s.fr>
References: <cover.1531498345.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 2/4] powerpc: add missing header in pgtable-types.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Date: Fri, 13 Jul 2018 16:23:33 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pte_basic_t is defined in page.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/pgtable-types.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index eccb30b38b47..3d8f68aebea3 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_PGTABLE_TYPES_H
 #define _ASM_POWERPC_PGTABLE_TYPES_H
 
+#include <asm/page.h>
+
 /* PTE level */
 typedef struct { pte_basic_t pte; } pte_t;
 #define __pte(x)	((pte_t) { (x) })
-- 
2.13.3
