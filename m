Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 14 Jun 2012 16:15:53 +1000
Subject: [PATCH 17/18] powerpc: Add defines for RA 0-R31
In-Reply-To: <1339654536.159274.140684871779.qpush@ale>
Message-Id: <20120614061553.8E3A6D42BEA@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org, schwab@linux-m68k.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

R0 is special since it'll be 0.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |    1 +
 arch/powerpc/include/asm/ppc_asm.h    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -116,6 +116,7 @@
 #define ___PPC_RS(s)	(((s) & 0x1f) << 21)
 #define ___PPC_RT(t)	___PPC_RS(t)
 #define __PPC_RA(a)	___PPC_RA(__REG_##a)
+#define __PPC_RA0(a)	___PPC_RA(__REGA0_##a)
 #define __PPC_RB(b)	___PPC_RB(__REG_##b)
 #define __PPC_RS(s)	___PPC_RS(__REG_##s)
 #define __PPC_RT(t)	___PPC_RT(__REG_##t)
Index: powerpc-test/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc_asm.h
+++ powerpc-test/arch/powerpc/include/asm/ppc_asm.h
@@ -579,6 +579,39 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define	__REG_R30	30
 #define	__REG_R31	31
 
+#define	__REGA0_0	0
+#define	__REGA0_R1	1
+#define	__REGA0_R2	2
+#define	__REGA0_R3	3
+#define	__REGA0_R4	4
+#define	__REGA0_R5	5
+#define	__REGA0_R6	6
+#define	__REGA0_R7	7
+#define	__REGA0_R8	8
+#define	__REGA0_R9	9
+#define	__REGA0_R10	10
+#define	__REGA0_R11	11
+#define	__REGA0_R12	12
+#define	__REGA0_R13	13
+#define	__REGA0_R14	14
+#define	__REGA0_R15	15
+#define	__REGA0_R16	16
+#define	__REGA0_R17	17
+#define	__REGA0_R18	18
+#define	__REGA0_R19	19
+#define	__REGA0_R20	20
+#define	__REGA0_R21	21
+#define	__REGA0_R22	22
+#define	__REGA0_R23	23
+#define	__REGA0_R24	24
+#define	__REGA0_R25	25
+#define	__REGA0_R26	26
+#define	__REGA0_R27	27
+#define	__REGA0_R28	28
+#define	__REGA0_R29	29
+#define	__REGA0_R30	30
+#define	__REGA0_R31	31
+
 /* Floating Point Registers (FPRs) */
 
 #define	fr0	0
