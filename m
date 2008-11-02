Return-Path: <adobriyan@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 662EADDDE0
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 04:23:36 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so791800eyi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Nov 2008 09:23:34 -0800 (PST)
Date: Sun, 2 Nov 2008 20:26:51 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: paulus@samba.org
Subject: [PATCH] ps3: ps3-lpm.c compile fix
Message-ID: <20081102172650.GA7219@x200.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

drivers/ps3/ps3-lpm.c:838: error: implicit declaration of function 'get_hard_smp_processor_id'

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ps3/ps3-lpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/ps3/ps3-lpm.c
+++ b/drivers/ps3/ps3-lpm.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/uaccess.h>
+#include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/ps3.h>
 #include <asm/lv1call.h>
