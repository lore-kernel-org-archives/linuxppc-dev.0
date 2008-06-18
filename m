Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080618223329.335415658@linux.vnet.ibm.com>
References: <20080618223254.966080905@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2008 17:32:58 -0500
From: shaggy@linux.vnet.ibm.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 4/6] powerpc: Add SAO Feature bit to the cputable
Cc: linux-mm@kvack.org, Paul Mackerras <paulus@au1.ibm.com>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch applies on top of the patches posted today to linuxppc-dev by
Michael Neuling and Joel Schopp.

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Index: linux-2.6.26-rc5/include/asm-powerpc/cputable.h
===================================================================
--- linux-2.6.26-rc5.orig/include/asm-powerpc/cputable.h
+++ linux-2.6.26-rc5/include/asm-powerpc/cputable.h
@@ -183,6 +183,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
 #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
+#define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -395,7 +396,7 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR)
+	    CPU_FTR_DSCR | CPU_FTR_SAO)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \

-- 
