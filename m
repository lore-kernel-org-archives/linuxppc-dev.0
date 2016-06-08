Return-Path: <geliangtang@gmail.com>
Received: from mail-pf0-f193.google.com (mail-pf0-f193.google.com
 [209.85.192.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPkY96sW4zDqGK
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 20:03:57 +1000 (AEST)
Received: by mail-pf0-f193.google.com with SMTP id l188so291132pfl.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 03:03:57 -0700 (PDT)
From: Geliang Tang <geliangtang@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/nvram: remove unused pstore headers
Date: Wed,  8 Jun 2016 18:02:37 +0800
Message-Id: <4bd4cc6de1d163cb5c67270596bad7a03b569d7a.1465380013.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since the pstore code has moved away from nvram.c, remove unused
pstore headers pstore.h and kmsg_dump.h.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 arch/powerpc/platforms/pseries/nvram.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/nvram.c b/arch/powerpc/platforms/pseries/nvram.c
index 9f818417..79aef8c 100644
--- a/arch/powerpc/platforms/pseries/nvram.c
+++ b/arch/powerpc/platforms/pseries/nvram.c
@@ -17,8 +17,6 @@
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
-#include <linux/kmsg_dump.h>
-#include <linux/pstore.h>
 #include <linux/ctype.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
-- 
1.9.1
