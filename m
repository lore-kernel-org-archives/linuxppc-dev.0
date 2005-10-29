Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0l68u030060@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:35 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 22/43] ppc64 boot: remove include from
	lib/zlib_inflate/inflate.c
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

There is no need to include module.h in inflate.c

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 lib/zlib_inflate/inflate.c |    1 -
 1 files changed, 1 deletion(-)

diff -puN lib/zlib_inflate/inflate.c~ppc64-boot-remove-include-from-lib-zlib_inflate-inflatec lib/zlib_inflate/inflate.c
--- devel/lib/zlib_inflate/inflate.c~ppc64-boot-remove-include-from-lib-zlib_inflate-inflatec	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/lib/zlib_inflate/inflate.c	2005-10-28 17:44:04.000000000 -0700
@@ -3,7 +3,6 @@
  * For conditions of distribution and use, see copyright notice in zlib.h 
  */
 
-#include <linux/module.h>
 #include <linux/zutil.h>
 #include "infblock.h"
 #include "infutil.h"
_
