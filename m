Return-Path: <andrea.gelmini@gmail.com>
Received: from mail-lb0-x242.google.com (mail-lb0-x242.google.com
 [IPv6:2a00:1450:4010:c04::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rBk8S0R4XzDqWl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 22:07:52 +1000 (AEST)
Received: by mail-lb0-x242.google.com with SMTP id u2so698467lbo.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 May 2016 05:07:51 -0700 (PDT)
Sender: Andrea Gelmini <andrea.gelmini@gmail.com>
From: Andrea Gelmini <andrea.gelmini@gelma.net>
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, jk@ozlabs.org, arnd@arndb.de, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0239/1529] Fix typo
Date: Sat, 21 May 2016 14:07:44 +0200
Message-Id: <20160521120744.12471-1-andrea.gelmini@gelma.net>
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
 arch/powerpc/platforms/cell/spufs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 2936a00..0625446 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -866,7 +866,7 @@ void spufs_wbox_callback(struct spu *spu)
  * - end of the mapped area
  *
  * If the file is opened without O_NONBLOCK, we wait here until
- * space is availabyl, but return when we have been able to
+ * space is available, but return when we have been able to
  * write something.
  */
 static ssize_t spufs_wbox_write(struct file *file, const char __user *buf,
-- 
2.8.2.534.g1f66975
