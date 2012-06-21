Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:42 +1000
Subject: [PATCH 15/18] powerpc: Introduce new __REG_R macros
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020442.64EAFD431D9@localhost.localdomain>
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

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc-opcode.h |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

Index: powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc-opcode.h
+++ powerpc-test/arch/powerpc/include/asm/ppc-opcode.h
@@ -48,6 +48,39 @@
 #define	R30	30
 #define	R31	31
 
+#define	__REG_R0	0
+#define	__REG_R1	1
+#define	__REG_R2	2
+#define	__REG_R3	3
+#define	__REG_R4	4
+#define	__REG_R5	5
+#define	__REG_R6	6
+#define	__REG_R7	7
+#define	__REG_R8	8
+#define	__REG_R9	9
+#define	__REG_R10	10
+#define	__REG_R11	11
+#define	__REG_R12	12
+#define	__REG_R13	13
+#define	__REG_R14	14
+#define	__REG_R15	15
+#define	__REG_R16	16
+#define	__REG_R17	17
+#define	__REG_R18	18
+#define	__REG_R19	19
+#define	__REG_R20	20
+#define	__REG_R21	21
+#define	__REG_R22	22
+#define	__REG_R23	23
+#define	__REG_R24	24
+#define	__REG_R25	25
+#define	__REG_R26	26
+#define	__REG_R27	27
+#define	__REG_R28	28
+#define	__REG_R29	29
+#define	__REG_R30	30
+#define	__REG_R31	31
+
 /* sorted alphabetically */
 #define PPC_INST_DCBA			0x7c0005ec
 #define PPC_INST_DCBA_MASK		0xfc0007fe
