Return-Path: <adobriyan@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 2F226DDDDB
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Nov 2008 07:18:42 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 6so812457eyi.15
	for <linuxppc-dev@ozlabs.org>; Sun, 02 Nov 2008 12:18:40 -0800 (PST)
Date: Sun, 2 Nov 2008 23:21:57 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: paulus@samba.org
Subject: [PATCH] cell: fix ras.c compilation
Message-ID: <20081102202157.GA11316@x200.localdomain>
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

arch/powerpc/platforms/cell/ras.c:299: error: implicit declaration of function 'crash_shutdown_register'

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/powerpc/platforms/cell/ras.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/platforms/cell/ras.c
+++ b/arch/powerpc/platforms/cell/ras.c
@@ -16,6 +16,7 @@
 #include <linux/kexec.h>
 #include <linux/crash_dump.h>
 
+#include <asm/kexec.h>
 #include <asm/reg.h>
 #include <asm/io.h>
 #include <asm/prom.h>
