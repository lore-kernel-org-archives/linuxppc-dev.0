Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wW2P927RPzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 23:16:29 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id u187so14694224pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 May 2017 06:16:29 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 6/9] powerpc/64s: paca EX_SRR0 is unused, remove it
Date: Sun, 21 May 2017 23:15:47 +1000
Message-Id: <20170521131550.25813-7-npiggin@gmail.com>
In-Reply-To: <20170521131550.25813-1-npiggin@gmail.com>
References: <20170521131550.25813-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 3edcad24684f..e1103dc9d8e8 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -31,17 +31,16 @@
 #define EX_R11		16
 #define EX_R12		24
 #define EX_R13		32
-#define EX_SRR0		40
-#define EX_DAR		48
-#define EX_DSISR	56
-#define EX_CCR		60
-#define EX_R3		64
-#define EX_LR		72
-#define EX_CFAR		80
-#define EX_PPR		88	/* SMT thread status register (priority) */
-#define EX_CTR		96
-
-#define EX_SIZE		13	/* size in u64 units */
+#define EX_DAR		40
+#define EX_DSISR	48
+#define EX_CCR		52
+#define EX_R3		56
+#define EX_LR		64
+#define EX_CFAR		72
+#define EX_PPR		80	/* SMT thread status register (priority) */
+#define EX_CTR		88
+
+#define EX_SIZE		12	/* size in u64 units */
 
 #ifdef __ASSEMBLY__
 
-- 
2.11.0
