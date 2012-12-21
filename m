Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/7] powerpc: Remove extra zeros from 32 bit CPU features
 definitions
Date: Fri, 21 Dec 2012 11:06:39 +1100
Message-Id: <1356048405-20560-2-git-send-email-mikey@neuling.org>
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

These are 32 bit, so no need to have a bunch of wasted 0s.

The 0s saved here can be put to better use elsewhere, like at the end of my pay
check.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |   62 +++++++++++++++++------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index cbbec56a..0a4c67d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -106,37 +106,37 @@ extern const char *powerpc_base_platform;
 /* CPU kernel features */
 
 /* Retain the 32b definitions all use bottom half of word */
-#define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x0000000000000001)
-#define CPU_FTR_L2CR			ASM_CONST(0x0000000000000002)
-#define CPU_FTR_SPEC7450		ASM_CONST(0x0000000000000004)
-#define CPU_FTR_ALTIVEC			ASM_CONST(0x0000000000000008)
-#define CPU_FTR_TAU			ASM_CONST(0x0000000000000010)
-#define CPU_FTR_CAN_DOZE		ASM_CONST(0x0000000000000020)
-#define CPU_FTR_USE_TB			ASM_CONST(0x0000000000000040)
-#define CPU_FTR_L2CSR			ASM_CONST(0x0000000000000080)
-#define CPU_FTR_601			ASM_CONST(0x0000000000000100)
-#define CPU_FTR_DBELL			ASM_CONST(0x0000000000000200)
-#define CPU_FTR_CAN_NAP			ASM_CONST(0x0000000000000400)
-#define CPU_FTR_L3CR			ASM_CONST(0x0000000000000800)
-#define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x0000000000001000)
-#define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
-#define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
-#define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
-#define CPU_FTR_476_DD2			ASM_CONST(0x0000000000010000)
-#define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
-#define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
-#define CPU_FTR_DEBUG_LVL_EXC		ASM_CONST(0x0000000000080000)
-#define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
-#define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
-#define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
-#define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x0000000000800000)
-#define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
-#define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
-#define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
-#define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)
-#define CPU_FTR_NOEXECUTE		ASM_CONST(0x0000000010000000)
-#define CPU_FTR_INDEXED_DCR		ASM_CONST(0x0000000020000000)
-#define CPU_FTR_EMB_HV			ASM_CONST(0x0000000040000000)
+#define CPU_FTR_COHERENT_ICACHE		ASM_CONST(0x00000001)
+#define CPU_FTR_L2CR			ASM_CONST(0x00000002)
+#define CPU_FTR_SPEC7450		ASM_CONST(0x00000004)
+#define CPU_FTR_ALTIVEC			ASM_CONST(0x00000008)
+#define CPU_FTR_TAU			ASM_CONST(0x00000010)
+#define CPU_FTR_CAN_DOZE		ASM_CONST(0x00000020)
+#define CPU_FTR_USE_TB			ASM_CONST(0x00000040)
+#define CPU_FTR_L2CSR			ASM_CONST(0x00000080)
+#define CPU_FTR_601			ASM_CONST(0x00000100)
+#define CPU_FTR_DBELL			ASM_CONST(0x00000200)
+#define CPU_FTR_CAN_NAP			ASM_CONST(0x00000400)
+#define CPU_FTR_L3CR			ASM_CONST(0x00000800)
+#define CPU_FTR_L3_DISABLE_NAP		ASM_CONST(0x00001000)
+#define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x00002000)
+#define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x00004000)
+#define CPU_FTR_NO_DPM			ASM_CONST(0x00008000)
+#define CPU_FTR_476_DD2			ASM_CONST(0x00010000)
+#define CPU_FTR_NEED_COHERENT		ASM_CONST(0x00020000)
+#define CPU_FTR_NO_BTIC			ASM_CONST(0x00040000)
+#define CPU_FTR_DEBUG_LVL_EXC		ASM_CONST(0x00080000)
+#define CPU_FTR_NODSISRALIGN		ASM_CONST(0x00100000)
+#define CPU_FTR_PPC_LE			ASM_CONST(0x00200000)
+#define CPU_FTR_REAL_LE			ASM_CONST(0x00400000)
+#define CPU_FTR_FPU_UNAVAILABLE		ASM_CONST(0x00800000)
+#define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x01000000)
+#define CPU_FTR_SPE			ASM_CONST(0x02000000)
+#define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x04000000)
+#define CPU_FTR_LWSYNC			ASM_CONST(0x08000000)
+#define CPU_FTR_NOEXECUTE		ASM_CONST(0x10000000)
+#define CPU_FTR_INDEXED_DCR		ASM_CONST(0x20000000)
+#define CPU_FTR_EMB_HV			ASM_CONST(0x40000000)
 
 /*
  * Add the 64-bit processor unique features in the top half of the word;
-- 
1.7.10.4
