Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 08 Jun 2012 21:36:05 +1000
Subject: [PATCH 1/15] powerpc: Add defines for R0-R31
In-Reply-To: <1339155365.316308.981577666228.qpush@ale>
Message-Id: <20120608113605.5C17FD43B23@localhost.localdomain>
Cc: mikey@neuling.org, linuxppc-dev@ozlabs.org,
 Anton Blanchard <anton@samba.org>, Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are going to use these later and convert r0 to %r0 etc.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc_asm.h |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Index: clone3/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- clone3.orig/arch/powerpc/include/asm/ppc_asm.h
+++ clone3/arch/powerpc/include/asm/ppc_asm.h
@@ -525,6 +525,39 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define	r30	30
 #define	r31	31
 
+#define	R0	0
+#define	R1	1
+#define	R2	2
+#define	R3	3
+#define	R4	4
+#define	R5	5
+#define	R6	6
+#define	R7	7
+#define	R8	8
+#define	R9	9
+#define	R10	10
+#define	R11	11
+#define	R12	12
+#define	R13	13
+#define	R14	14
+#define	R15	15
+#define	R16	16
+#define	R17	17
+#define	R18	18
+#define	R19	19
+#define	R20	20
+#define	R21	21
+#define	R22	22
+#define	R23	23
+#define	R24	24
+#define	R25	25
+#define	R26	26
+#define	R27	27
+#define	R28	28
+#define	R29	29
+#define	R30	30
+#define	R31	31
+
 
 /* Floating Point Registers (FPRs) */
 
