Return-Path: <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <michael@ellerman.id.au>
From: Michael Neuling <mikey@neuling.org>
Date: Thu, 21 Jun 2012 12:04:32 +1000
Subject: [PATCH 5/18] powerpc: convert to %r for all GPR usage
In-Reply-To: <1340244266.960241.475925824909.qpush@ale>
Message-Id: <20120621020432.28A92D431D9@localhost.localdomain>
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

Now all the fixes are in place, let's rock-n-roll!

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/include/asm/ppc_asm.h |   72 ++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 33 deletions(-)

Index: powerpc-test/arch/powerpc/include/asm/ppc_asm.h
===================================================================
--- powerpc-test.orig/arch/powerpc/include/asm/ppc_asm.h
+++ powerpc-test/arch/powerpc/include/asm/ppc_asm.h
@@ -490,40 +490,46 @@ END_FTR_SECTION_IFCLR(CPU_FTR_601)
 #define	cr7	7
 
 
-/* General Purpose Registers (GPRs) */
+/*
+ * General Purpose Registers (GPRs)
+ *
+ * The lower case r0-r31 should be used in preference to the upper
+ * case R0-R31 as they provide more error checking in the assembler.
+ * Use R0-31 only when really nessesary.
+ */
 
-#define	r0	0
-#define	r1	1
-#define	r2	2
-#define	r3	3
-#define	r4	4
-#define	r5	5
-#define	r6	6
-#define	r7	7
-#define	r8	8
-#define	r9	9
-#define	r10	10
-#define	r11	11
-#define	r12	12
-#define	r13	13
-#define	r14	14
-#define	r15	15
-#define	r16	16
-#define	r17	17
-#define	r18	18
-#define	r19	19
-#define	r20	20
-#define	r21	21
-#define	r22	22
-#define	r23	23
-#define	r24	24
-#define	r25	25
-#define	r26	26
-#define	r27	27
-#define	r28	28
-#define	r29	29
-#define	r30	30
-#define	r31	31
+#define	r0	%r0
+#define	r1	%r1
+#define	r2	%r2
+#define	r3	%r3
+#define	r4	%r4
+#define	r5	%r5
+#define	r6	%r6
+#define	r7	%r7
+#define	r8	%r8
+#define	r9	%r9
+#define	r10	%r10
+#define	r11	%r11
+#define	r12	%r12
+#define	r13	%r13
+#define	r14	%r14
+#define	r15	%r15
+#define	r16	%r16
+#define	r17	%r17
+#define	r18	%r18
+#define	r19	%r19
+#define	r20	%r20
+#define	r21	%r21
+#define	r22	%r22
+#define	r23	%r23
+#define	r24	%r24
+#define	r25	%r25
+#define	r26	%r26
+#define	r27	%r27
+#define	r28	%r28
+#define	r29	%r29
+#define	r30	%r30
+#define	r31	%r31
 
 
 /* Floating Point Registers (FPRs) */
