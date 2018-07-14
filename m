Return-Path: <rdunlap@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41SGqv5qzczDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Jul 2018 14:27:55 +1000 (AEST)
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] chrp/nvram.c: add MODULE_LICENSE()
Message-ID: <22eb2f31-3b79-3702-071c-d0fe06a50150@infradead.org>
Date: Fri, 13 Jul 2018 21:27:48 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Randy Dunlap <rdunlap@infradead.org>

Add MODULE_LICENSE() to the chrp nvram.c driver to fix the build
warning message:

WARNING: modpost: missing MODULE_LICENSE() in arch/powerpc/platforms/chrp/nvram.o

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
Feel free to adjust the license string if needed.

 arch/powerpc/platforms/chrp/nvram.c |    3 +++
 1 file changed, 3 insertions(+)

--- lnx-418-rc4.orig/arch/powerpc/platforms/chrp/nvram.c
+++ lnx-418-rc4/arch/powerpc/platforms/chrp/nvram.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
@@ -89,3 +90,5 @@ void __init chrp_nvram_init(void)
 
 	return;
 }
+
+MODULE_LICENSE("GPL v2");
