Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] remove unused CPU_FTRS_POWER6X
Date: Tue, 23 Jan 2007 15:59:26 +1100
Message-ID: <20293.1169528366@neuling.org>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

CPU_FTRS_POWER6X is unused, hence remove it.

Signed-off-by Michael Neuling <mikey@neuling.org>
---
 include/asm-powerpc/cputable.h |    6 ------
 1 file changed, 6 deletions(-)

Paulus, this is a followup from our conversation yesterday.  This is for
the next merge window.

Index: linux-2.6-ozlabs/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/cputable.h
+++ linux-2.6-ozlabs/include/asm-powerpc/cputable.h
@@ -337,12 +337,6 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
-#define CPU_FTRS_POWER6X (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
-	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_SPURR | CPU_FTR_REAL_LE | CPU_FTR_DSCR)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
