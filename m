Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wc1221BvqzDqCt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 01:32:10 +1000 (AEST)
Message-Id: <0e16df19be949fa1adccd8ec7949b164df73e90e.1496070452.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc/mm: remove __this_fixmap_does_not_exist()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Balbir Singh <bsingharora@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Mon, 29 May 2017 17:32:06 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This function has not been used since commit 9494a1e8428ea
("powerpc: use generic fixmap.h)

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/pgtable_32.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index d151779621fb..d672904bad0c 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -423,8 +423,3 @@ void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
 	map_kernel_page(address, phys, pgprot_val(flags));
 	fixmaps++;
 }
-
-void __this_fixmap_does_not_exist(void)
-{
-	WARN_ON(1);
-}
-- 
2.12.0
