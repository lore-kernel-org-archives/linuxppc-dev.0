Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x243.google.com (mail-lb0-x243.google.com
 [IPv6:2a00:1450:4010:c04::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk7H733PzDqPX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:06:51 +1000 (AEST)
Received: by mail-lb0-x243.google.com with SMTP id t6so64560lbv.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:06:51 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rric@kernel.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, oprofile-list@lists.sf.net,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0231/1529] Fix typo
Date: Sat, 21 May 2016 14:06:44 +0200
Message-Id: <20160521120644.12000-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/oprofile/cell/spu_task_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/oprofile/cell/spu_task_sync.c b/arch/powerpc/oprofile/cell/spu_task_sync.c
index ed7b097..ef2142f 100644
--- a/arch/powerpc/oprofile/cell/spu_task_sync.c
+++ b/arch/powerpc/oprofile/cell/spu_task_sync.c
@@ -51,7 +51,7 @@ static void spu_buff_add(unsigned long int value, int spu)
 	 * That way we can tell the difference between the
 	 * buffer being full versus empty.
 	 *
-	 *  ASSUPTION: the buffer_lock is held when this function
+	 *  ASSUMPTION: the buffer_lock is held when this function
 	 *             is called to lock the buffer, head and tail.
 	 */
 	int full = 1;
-- 
2.8.2.534.g1f66975
