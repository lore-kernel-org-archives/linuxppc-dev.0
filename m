Return-Path: <arnd@arndb.de>
Message-Id: <20060407150743.869611000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060407150124.422051000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Fri, 07 Apr 2006 00:00:05 +0200
From: arnd@arndb.de
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 5/5] cell: enable CPU_FTR_CI_LARGE_PAGE
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

Reflect the fact that the Cell Broadband Engine supports 64k
pages by adding the bit to the CPU features.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---
Index: linus-2.6/include/asm-powerpc/cputable.h
===================================================================
--- linus-2.6.orig/include/asm-powerpc/cputable.h
+++ linus-2.6/include/asm-powerpc/cputable.h
@@ -323,7 +323,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO)
+	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif

--
