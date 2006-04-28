Return-Path: <geoffrey.levand@am.sony.com>
Message-ID: <44528CCA.70602@am.sony.com>
Date: Fri, 28 Apr 2006 14:44:42 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 1/4] spufs: add missing headers
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add spu.h header dependencies.  Fixes these errors:

spu.h:168: warning: 'struct file' declared inside parameter list
spu.h:186: error: syntax error before 'cell_spumem_init'


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Index: linux-powerpc.git/include/asm-powerpc/spu.h
===================================================================
--- linux-powerpc.git.orig/include/asm-powerpc/spu.h	2006-04-28 14:32:25.000000000 -0700
+++ linux-powerpc.git/include/asm-powerpc/spu.h	2006-04-28 14:38:18.000000000 -0700
@@ -27,6 +27,8 @@
 #include <linux/config.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
+#include <linux/file.h>
+#include <linux/init.h>

 #define LS_SIZE (256 * 1024)
 #define LS_ADDR_MASK (LS_SIZE - 1)
