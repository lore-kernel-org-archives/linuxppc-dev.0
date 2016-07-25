Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryQsy41LKzDqYN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 12:57:58 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/3] powerpc/mm: Drop unused externs for hpte_init_beat[_v3]()
Date: Mon, 25 Jul 2016 12:57:51 +1000
Message-Id: <1469415471-2476-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
References: <1469415471-2476-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We removed the BEAT support in 2015 in commit bf4981a00636 ("powerpc:
Remove the celleb support"). These externs are unused since then.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 23cff86aa779..e520ee7731a8 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -409,9 +409,6 @@ static inline void hpte_init_pseries(void)
 }
 #endif
 
-extern void hpte_init_beat(void);
-extern void hpte_init_beat_v3(void);
-
 extern void slb_initialize(void);
 extern void slb_flush_and_rebolt(void);
 
-- 
2.7.4
