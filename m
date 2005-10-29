Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0l7Ml030063@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:37 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 23/43] ppc64 boot: remove include from include/linux/zutil.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

zutil.h does not need errno.h

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/zutil.h |    1 -
 1 files changed, 1 deletion(-)

diff -puN include/linux/zutil.h~ppc64-boot-remove-include-from-include-linux-zutilh include/linux/zutil.h
--- devel/include/linux/zutil.h~ppc64-boot-remove-include-from-include-linux-zutilh	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/include/linux/zutil.h	2005-10-28 17:44:04.000000000 -0700
@@ -15,7 +15,6 @@
 
 #include <linux/zlib.h>
 #include <linux/string.h>
-#include <linux/errno.h>
 #include <linux/kernel.h>
 
 typedef unsigned char  uch;
_
