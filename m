Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/7] powerpc: Repack 64bit CPU features to remove holes
Date: Fri, 21 Dec 2012 11:06:40 +1100
Message-Id: <1356048405-20560-3-git-send-email-mikey@neuling.org>
In-Reply-To: <1356048405-20560-1-git-send-email-mikey@neuling.org>
References: <1356048405-20560-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This frees up 7 bits for crazy new CPU features.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |   50 +++++++++++++++++------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 0a4c67d..d1f5911 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -148,31 +148,31 @@ extern const char *powerpc_base_platform;
 #define LONG_ASM_CONST(x)		0
 #endif
 
-#define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000200000000)
-#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000400000000)
-#define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000800000000)
-#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000001000000000)
-#define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
-#define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
-#define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
-#define CPU_FTR_SMT			LONG_ASM_CONST(0x0000010000000000)
-#define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
-#define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
-#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
-#define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
-#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
-#define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
-#define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
-#define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
-#define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
-#define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0100000000000000)
-#define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0200000000000000)
-#define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0400000000000000)
-#define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0800000000000000)
-#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x1000000000000000)
-#define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x2000000000000000)
-#define CPU_FTR_TM			LONG_ASM_CONST(0x4000000000000000)
-#define CPU_FTR_BCTAR			LONG_ASM_CONST(0x8000000000000000)
+#define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000100000000)
+#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
+#define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
+#define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000000800000000)
+#define CPU_FTR_IABR			LONG_ASM_CONST(0x0000001000000000)
+#define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
+#define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
+#define CPU_FTR_SMT			LONG_ASM_CONST(0x0000008000000000)
+#define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000010000000000)
+#define CPU_FTR_PURR			LONG_ASM_CONST(0x0000020000000000)
+#define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000040000000000)
+#define CPU_FTR_SPURR			LONG_ASM_CONST(0x0000080000000000)
+#define CPU_FTR_DSCR			LONG_ASM_CONST(0x0000100000000000)
+#define CPU_FTR_VSX			LONG_ASM_CONST(0x0000200000000000)
+#define CPU_FTR_SAO			LONG_ASM_CONST(0x0000400000000000)
+#define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0000800000000000)
+#define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0001000000000000)
+#define CPU_FTR_ASYM_SMT		LONG_ASM_CONST(0x0002000000000000)
+#define CPU_FTR_STCX_CHECKS_ADDRESS	LONG_ASM_CONST(0x0004000000000000)
+#define CPU_FTR_POPCNTB			LONG_ASM_CONST(0x0008000000000000)
+#define CPU_FTR_POPCNTD			LONG_ASM_CONST(0x0010000000000000)
+#define CPU_FTR_ICSWX			LONG_ASM_CONST(0x0020000000000000)
+#define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
+#define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
+#define CPU_FTR_BCTAR			LONG_ASM_CONST(0x0100000000000000)
 
 #ifndef __ASSEMBLY__
 
-- 
1.7.10.4
