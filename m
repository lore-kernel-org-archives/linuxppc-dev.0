Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0l8UZ030067@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:37 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 24/43] ppc64 boot: missing include for size_t
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

string.h needs definition of size_t, but not the one from linux/include

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/boot/string.h |    1 +
 1 files changed, 1 insertion(+)

diff -puN arch/ppc64/boot/string.h~ppc64-boot-missing-include-for-size_t arch/ppc64/boot/string.h
--- devel/arch/ppc64/boot/string.h~ppc64-boot-missing-include-for-size_t	2005-10-28 17:44:04.000000000 -0700
+++ devel-akpm/arch/ppc64/boot/string.h	2005-10-28 17:44:04.000000000 -0700
@@ -1,5 +1,6 @@
 #ifndef _PPC_BOOT_STRING_H_
 #define _PPC_BOOT_STRING_H_
+#include <stddef.h>
 
 extern char *strcpy(char *dest, const char *src);
 extern char *strncpy(char *dest, const char *src, size_t n);
_
