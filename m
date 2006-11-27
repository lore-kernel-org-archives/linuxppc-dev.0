Return-Path: <arnd@arndb.de>
Message-Id: <20061127182431.788138000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:59 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 8/9] fix missing #include in sys_ppc32.c
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

sys_mmap is declared in asm/syscalls.h

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/sys_ppc32.c
+++ linux-2.6/arch/powerpc/kernel/sys_ppc32.c
@@ -51,6 +51,7 @@
 #include <asm/time.h>
 #include <asm/mmu_context.h>
 #include <asm/ppc-pci.h>
+#include <asm/syscalls.h>
 
 /* readdir & getdents */
 #define NAME_OFFSET(de) ((int) ((de)->d_name - (char __user *) (de)))

--
