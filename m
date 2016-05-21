Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8h0QyPzDqMq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:08:04 +1000 (AEST)
Received: by mail-lf0-x244.google.com with SMTP id z203so645584lfd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:08:03 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, jk@ozlabs.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0241/1529] Fix typo
Date: Sat, 21 May 2016 14:07:56 +0200
Message-Id: <20160521120756.12577-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/cell/spufs/sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/sched.c b/arch/powerpc/platforms/cell/spufs/sched.c
index 998f632..460f5f3 100644
--- a/arch/powerpc/platforms/cell/spufs/sched.c
+++ b/arch/powerpc/platforms/cell/spufs/sched.c
@@ -622,7 +622,7 @@ static struct spu *spu_get_idle(struct spu_context *ctx)
 
 /**
  * find_victim - find a lower priority context to preempt
- * @ctx:	canidate context for running
+ * @ctx:	candidate context for running
  *
  * Returns the freed physical spu to run the new context on.
  */
-- 
2.8.2.534.g1f66975
