Return-Path: <arnd@arndb.de>
Message-Id: <20060429233920.561256000@localhost.localdomain>
References: <20060429232812.825714000@localhost.localdomain>
Date: Sun, 30 Apr 2006 01:28:17 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 05/13] cell: enable CPU_FTR_CI_LARGE_PAGE
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Reflect the fact that the Cell Broadband Engine supports 64k
pages by adding the bit to the CPU features.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/cputable.h	2006-04-29 22:47:55.000000000 +0200
+++ linus-2.6/include/asm-powerpc/cputable.h	2006-04-29 22:53:42.000000000 +0200
@@ -329,7 +329,7 @@
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO)
+	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif

--
