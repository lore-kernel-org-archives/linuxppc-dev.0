Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080707143011.371263359@linux.vnet.ibm.com>
References: <20080707142850.034542257@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2008 09:28:53 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Subject: [patch 3/5] powerpc: Add SAO Feature bit to the cputable
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

---
 include/asm-powerpc/cputable.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: b/include/asm-powerpc/cputable.h
===================================================================
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -185,6 +185,7 @@
 #define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
 #define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
+#define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -400,7 +401,7 @@
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR)
+	    CPU_FTR_DSCR | CPU_FTR_SAO)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \

-- 
Dave Kleikamp
IBM Linux Technology Center
