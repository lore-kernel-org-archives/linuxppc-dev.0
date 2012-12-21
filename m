Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 4/7] powerpc: Add DAWR CPU feature bit definition
Date: Fri, 21 Dec 2012 11:06:42 +1100
Message-Id: <1356048405-20560-5-git-send-email-mikey@neuling.org>
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

.. and add it to POWER8 cpu features.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index d1f5911..2134e26 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -173,6 +173,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_VMX_COPY		LONG_ASM_CONST(0x0040000000000000)
 #define CPU_FTR_TM			LONG_ASM_CONST(0x0080000000000000)
 #define CPU_FTR_BCTAR			LONG_ASM_CONST(0x0100000000000000)
+#define CPU_FTR_DAWR			LONG_ASM_CONST(0x0200000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -418,7 +419,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
-	    CPU_FTR_DBELL | CPU_FTR_TM_COMP | CPU_FTR_BCTAR)
+	    CPU_FTR_DBELL | CPU_FTR_TM_COMP | CPU_FTR_BCTAR | CPU_FTR_DAWR)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-- 
1.7.10.4
