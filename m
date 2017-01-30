Return-Path: <vlvrdv@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC4Xt5kg6zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:57:34 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id f2so31760516uaf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jan 2017 14:57:33 -0800 (PST)
From: Sergio Valverde <vlvrdv@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, rsa@us.ibm.com, gregkh@linuxfoundation.org
Cc: trivial@kernel.org,
	Sergio Valverde <vlvrdv@gmail.com>
Subject: [PATCH] Remove extra include in HVC console tty framework
Date: Mon, 30 Jan 2017 16:57:23 -0600
Message-Id: <1485817043-7195-1-git-send-email-vlvrdv@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sergio Valverde <vlvrdv@gmail.com>

An extra "init.h" include is found in the HVC console code.

While the code works as it is right now, it is a defect nevertheless.
As such, the extra line is deleted.

Signed-off-by: Sergio Valverde <vlvrdv@gmail.com>
---
 drivers/tty/hvc/hvc_console.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9b5c0fb..b19ae36 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -29,7 +29,6 @@
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/list.h>
-#include <linux/init.h>
 #include <linux/major.h>
 #include <linux/atomic.h>
 #include <linux/sysrq.h>
-- 
1.9.1
