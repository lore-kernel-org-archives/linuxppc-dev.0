Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8L2rXrzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:46 +1000 (AEST)
Received: by mail-lf0-x242.google.com with SMTP id 65so30470lfq.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:46 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0238/1529] Fix typo
Date: Sat, 21 May 2016 14:07:35 +0200
Message-Id: <20160521120735.12405-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/cell/spu_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 3cbe38f..bb4a8e0 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -69,7 +69,7 @@ static DEFINE_SPINLOCK(spu_lock);
  * spu_full_list_lock and spu_full_list_mutex held, while iterating
  * through it requires either of these locks.
  *
- * In addition spu_full_list_lock protects all assignmens to
+ * In addition spu_full_list_lock protects all assignments to
  * spu->mm.
  */
 static LIST_HEAD(spu_full_list);
@@ -253,7 +253,7 @@ static inline int __slb_present(struct copro_slb *slbs, int nr_slbs,
  * Setup the SPU kernel SLBs, in preparation for a context save/restore. We
  * need to map both the context save area, and the save/restore code.
  *
- * Because the lscsa and code may cross segment boundaires, we check to see
+ * Because the lscsa and code may cross segment boundaries, we check to see
  * if mappings are required for the start and end of each range. We currently
  * assume that the mappings are smaller that one segment - if not, something
  * is seriously wrong.
-- 
2.8.2.534.g1f66975
