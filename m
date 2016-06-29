Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfgMj0Sj2zDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 21:25:37 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/kernel: Drop unused extern for current_set
Date: Wed, 29 Jun 2016 21:25:33 +1000
Message-Id: <1467199533-12423-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/mm/init_32.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index c899fe340bbd..e2d7ba124618 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -80,9 +80,6 @@ EXPORT_SYMBOL(agp_special_page);
 
 void MMU_init(void);
 
-/* XXX should be in current.h  -- paulus */
-extern struct task_struct *current_set[NR_CPUS];
-
 /*
  * this tells the system to map all of ram with the segregs
  * (i.e. page tables) instead of the bats.
-- 
2.5.0
