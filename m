Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk5h2RJzzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:05:28 +1000 (AEST)
Received: by mail-lf0-x244.google.com with SMTP id 65so28573lfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:05:28 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0222/1529] Fix typo
Date: Sat, 21 May 2016 14:05:20 +0200
Message-Id: <20160521120520.11534-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/kernel/cpu_setup_6xx.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index f8cd9fb..c5e5a94 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -156,7 +156,7 @@ setup_7410_workarounds:
 	blr
 
 /* 740/750/7400/7410
- * Enable Store Gathering (SGE), Address Brodcast (ABE),
+ * Enable Store Gathering (SGE), Address Broadcast (ABE),
  * Branch History Table (BHTE), Branch Target ICache (BTIC)
  * Dynamic Power Management (DPM), Speculative (SPD)
  * Clear Instruction cache throttling (ICTC)
-- 
2.8.2.534.g1f66975
