Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 21 Mar 2006 20:45:58 +1100
Subject: [PATCH 3/11] powerpc: trivial: Cleanup whitespace in cputable.h
In-Reply-To: <1142934351.193140.181086235013.qpush@concordia>
Message-Id: <20060321094628.3B450679FC@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove redundant whitespace in include/asm-powerpc/cputable.h

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/cputable.h |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)

Index: to-merge/include/asm-powerpc/cputable.h
===================================================================
--- to-merge.orig/include/asm-powerpc/cputable.h
+++ to-merge/include/asm-powerpc/cputable.h
@@ -102,19 +102,19 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
 #define CPU_FTR_BIG_PHYS		ASM_CONST(0x0000000000080000)
-#define CPU_FTR_NODSISRALIGN  		ASM_CONST(0x0000000000100000)
+#define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 
 #ifdef __powerpc64__
 /* Add the 64b processor unique features in the top half of the word */
-#define CPU_FTR_SLB           		ASM_CONST(0x0000000100000000)
-#define CPU_FTR_16M_PAGE      		ASM_CONST(0x0000000200000000)
-#define CPU_FTR_TLBIEL         		ASM_CONST(0x0000000400000000)
-#define CPU_FTR_NOEXECUTE     		ASM_CONST(0x0000000800000000)
-#define CPU_FTR_IABR  			ASM_CONST(0x0000002000000000)
-#define CPU_FTR_MMCRA  			ASM_CONST(0x0000004000000000)
+#define CPU_FTR_SLB			ASM_CONST(0x0000000100000000)
+#define CPU_FTR_16M_PAGE		ASM_CONST(0x0000000200000000)
+#define CPU_FTR_TLBIEL			ASM_CONST(0x0000000400000000)
+#define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000800000000)
+#define CPU_FTR_IABR			ASM_CONST(0x0000002000000000)
+#define CPU_FTR_MMCRA			ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			ASM_CONST(0x0000008000000000)
-#define CPU_FTR_SMT  			ASM_CONST(0x0000010000000000)
-#define CPU_FTR_COHERENT_ICACHE  	ASM_CONST(0x0000020000000000)
+#define CPU_FTR_SMT			ASM_CONST(0x0000010000000000)
+#define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0000020000000000)
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0000040000000000)
 #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0000080000000000)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0000100000000000)
@@ -123,15 +123,15 @@ extern void do_cpu_ftr_fixups(unsigned l
 #else
 /* ensure on 32b processors the flags are available for compiling but
  * don't do anything */
-#define CPU_FTR_SLB           		ASM_CONST(0x0)
-#define CPU_FTR_16M_PAGE      		ASM_CONST(0x0)
-#define CPU_FTR_TLBIEL         		ASM_CONST(0x0)
-#define CPU_FTR_NOEXECUTE     		ASM_CONST(0x0)
-#define CPU_FTR_IABR  			ASM_CONST(0x0)
-#define CPU_FTR_MMCRA  			ASM_CONST(0x0)
+#define CPU_FTR_SLB			ASM_CONST(0x0)
+#define CPU_FTR_16M_PAGE		ASM_CONST(0x0)
+#define CPU_FTR_TLBIEL			ASM_CONST(0x0)
+#define CPU_FTR_NOEXECUTE		ASM_CONST(0x0)
+#define CPU_FTR_IABR			ASM_CONST(0x0)
+#define CPU_FTR_MMCRA			ASM_CONST(0x0)
 #define CPU_FTR_CTRL			ASM_CONST(0x0)
-#define CPU_FTR_SMT  			ASM_CONST(0x0)
-#define CPU_FTR_COHERENT_ICACHE  	ASM_CONST(0x0)
+#define CPU_FTR_SMT			ASM_CONST(0x0)
+#define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0)
 #define CPU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x0)
 #define CPU_FTR_MMCRA_SIHV		ASM_CONST(0x0)
 #define CPU_FTR_CI_LARGE_PAGE		ASM_CONST(0x0)
