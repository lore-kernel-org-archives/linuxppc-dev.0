Return-Path: <richard@nod.at>
Received: from mail.sigma-star.at (mail.sigma-star.at [95.130.255.111])
 by ozlabs.org (Postfix) with ESMTP id 0B2281400D4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 05:13:06 +1000 (EST)
From: Richard Weinberger <richard@nod.at>
To: linux-arch@vger.kernel.org,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/27] powerpc: Use common bits from generic tlb.h
Date: Wed, 14 May 2014 20:59:52 +0200
Message-Id: <1400093999-18703-21-git-send-email-richard@nod.at>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Cc: Richard Weinberger <richard@nod.at>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is no longer needed to define them on our own.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/powerpc/include/asm/tlb.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index 392e5ef..bdea7f5 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -25,9 +25,6 @@
 
 #include <linux/pagemap.h>
 
-#define tlb_start_vma(tlb, vma)	do { } while (0)
-#define tlb_end_vma(tlb, vma)	do { } while (0)
-
 extern void tlb_flush(struct mmu_gather *tlb);
 
 /* These defines are needed to override the defaults from asm-generic/tlb.h */
-- 
1.8.4.2
