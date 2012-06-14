Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F3E36B7080
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 09:41:09 +1000 (EST)
Date: Thu, 14 Jun 2012 18:40:55 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, <galak@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc/mm: remove obsolete comment about page size name
 array
Message-ID: <20120614234055.GA17147@tyr.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The array of names in hugetlbpage.c no longer exists.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/include/asm/mmu.h |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index f014552..a9e9ec6 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -163,12 +163,7 @@ extern u64 ppc64_rma_size;
  * to think about, feedback welcome. --BenH.
  */
 
-/* There are #define as they have to be used in assembly
- *
- * WARNING: If you change this list, make sure to update the array of
- * names currently in arch/powerpc/mm/hugetlbpage.c or bad things will
- * happen
- */
+/* There are #define as they have to be used in assembly */
 #define MMU_PAGE_4K	0
 #define MMU_PAGE_16K	1
 #define MMU_PAGE_64K	2
-- 
1.7.5.4
