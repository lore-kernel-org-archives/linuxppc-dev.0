Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8Z3K94zDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:58 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id mx9so6881078lbb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:58 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, jk@ozlabs.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0240/1529] Fix typo
Date: Sat, 21 May 2016 14:07:50 +0200
Message-Id: <20160521120750.12526-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/cell/spufs/run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index 9f79004..64c90e5 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -435,7 +435,7 @@ long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *event)
 
 	/* Note: we don't need to force_sig SIGTRAP on single-step
 	 * since we have TIF_SINGLESTEP set, thus the kernel will do
-	 * it upon return from the syscall anyawy
+	 * it upon return from the syscall anyway
 	 */
 	if (unlikely(status & SPU_STATUS_SINGLE_STEP))
 		ret = -ERESTARTSYS;
-- 
2.8.2.534.g1f66975
