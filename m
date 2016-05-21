Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk665c1TzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:50 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id p10so3973251lfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:50 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, scottwood@freescale.com, tiejun.chen@windriver.com,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0224/1529] Fix typo
Date: Sat, 21 May 2016 14:05:35 +0200
Message-Id: <20160521120535.11636-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/kernel/exceptions-64e.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 488e631..2d3b40f 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -453,7 +453,7 @@ exc_##n##_bad_stack:							    \
 	sth	r1,PACA_TRAP_SAVE(r13);	/* store trap */		    \
 	b	bad_stack_book3e;	/* bad stack error */
 
-/* WARNING: If you change the layout of this stub, make sure you chcek
+/* WARNING: If you change the layout of this stub, make sure you check
 	*   the debug exception handler which handles single stepping
 	*   into exceptions from userspace, and the MM code in
 	*   arch/powerpc/mm/tlb_nohash.c which patches the branch here
-- 
2.8.2.534.g1f66975
