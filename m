Return-Path: <geliangtang@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP5nM2YGnzDwNH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 02:27:51 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so806611pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 07:27:51 -0800 (PST)
From: Geliang Tang <geliangtang@gmail.com>
To: Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] cxl: drop duplicate header sched.h
Date: Wed, 23 Nov 2016 23:27:38 +0800
Message-Id: <b7081e3aaf7867b3f9fef64e48198d3025352633.1479914776.git.geliangtang@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop duplicate header sched.h from native.c.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 drivers/misc/cxl/native.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index c336350..aeefa53 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -10,7 +10,6 @@
 #include <linux/spinlock.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/sched.h>
 #include <linux/mutex.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
-- 
2.9.3
