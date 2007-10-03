Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 82937DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:20:43 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id l93FKbqR026046
	for <linuxppc-dev@ozlabs.org>; Wed, 3 Oct 2007 10:20:39 -0500
Date: Wed, 3 Oct 2007 10:20:11 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] Cleaned up whitespace in head_fsl_booke.S
Message-ID: <Pine.LNX.4.64.0710031019260.20394@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

---
 arch/powerpc/kernel/head_fsl_booke.S |   76 +++++++++++++++++-----------------
 1 files changed, 38 insertions(+), 38 deletions(-)

Its just for show, this exists in my git-tree.

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index bfc3870..4dab680 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -2,27 +2,27 @@
  * Kernel execution entry point code.
  *
  *    Copyright (c) 1995-1996 Gary Thomas <gdt@linuxppc.org>
- *      Initial PowerPC version.
+ *	Initial PowerPC version.
  *    Copyright (c) 1996 Cort Dougan <cort@cs.nmt.edu>
- *      Rewritten for PReP
+ *	Rewritten for PReP
  *    Copyright (c) 1996 Paul Mackerras <paulus@cs.anu.edu.au>
- *      Low-level exception handers, MMU support, and rewrite.
+ *	Low-level exception handers, MMU support, and rewrite.
  *    Copyright (c) 1997 Dan Malek <dmalek@jlc.net>
- *      PowerPC 8xx modifications.
+ *	PowerPC 8xx modifications.
  *    Copyright (c) 1998-1999 TiVo, Inc.
- *      PowerPC 403GCX modifications.
+ *	PowerPC 403GCX modifications.
  *    Copyright (c) 1999 Grant Erickson <grant@lcse.umn.edu>
- *      PowerPC 403GCX/405GP modifications.
+ *	PowerPC 403GCX/405GP modifications.
  *    Copyright 2000 MontaVista Software Inc.
  *	PPC405 modifications
- *      PowerPC 403GCX/405GP modifications.
- * 	Author: MontaVista Software, Inc.
- *         	frank_rowand@mvista.com or source@mvista.com
- * 	   	debbie_chu@mvista.com
+ *	PowerPC 403GCX/405GP modifications.
+ *	Author: MontaVista Software, Inc.
+ *		frank_rowand@mvista.com or source@mvista.com
+ *		debbie_chu@mvista.com
  *    Copyright 2002-2004 MontaVista Software, Inc.
- *      PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
+ *	PowerPC 44x support, Matt Porter <mporter@kernel.crashing.org>
  *    Copyright 2004 Freescale Semiconductor, Inc
- *      PowerPC e500 modifications, Kumar Gala <galak@kernel.crashing.org>
+ *	PowerPC e500 modifications, Kumar Gala <galak@kernel.crashing.org>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -146,13 +146,13 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	bne	1b				/* If not, repeat */

 	/* Invalidate TLB0 */
-	li      r6,0x04
+	li	r6,0x04
 	tlbivax 0,r6
 #ifdef CONFIG_SMP
 	tlbsync
 #endif
 	/* Invalidate TLB1 */
-	li      r6,0x0c
+	li	r6,0x0c
 	tlbivax 0,r6
 #ifdef CONFIG_SMP
 	tlbsync
@@ -211,7 +211,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_MAS1,r6
 	tlbwe
 	/* Invalidate TLB1 */
-	li      r9,0x0c
+	li	r9,0x0c
 	tlbivax 0,r9
 #ifdef CONFIG_SMP
 	tlbsync
@@ -254,7 +254,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_MAS1,r8
 	tlbwe
 	/* Invalidate TLB1 */
-	li      r9,0x0c
+	li	9,0x0c
 	tlbivax 0,r9
 #ifdef CONFIG_SMP
 	tlbsync
@@ -294,7 +294,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #ifdef CONFIG_E200
 	oris	r2,r2,MAS4_TLBSELD(1)@h
 #endif
-   	mtspr	SPRN_MAS4, r2
+	mtspr	SPRN_MAS4, r2

 #if 0
 	/* Enable DOZE */
@@ -305,7 +305,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #ifdef CONFIG_E200
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r2,SPRN_HID0
-	ori 	r2,r2,HID0_DAPUEN@l
+	ori	r2,r2,HID0_DAPUEN@l
 	mtspr	SPRN_HID0,r2
 #endif

@@ -391,7 +391,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 #ifdef CONFIG_PTE_64BIT
 #define PTE_FLAGS_OFFSET	4
 #define FIND_PTE	\
-	rlwinm 	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
+	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
 	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
 	beq	2f;			/* Bail if no table */		\
@@ -487,7 +487,7 @@ interrupt_base:
 	 */
 	andi.	r11, r11, _PAGE_HWEXEC
 	rlwimi	r11, r11, 31, 27, 27	/* SX <- _PAGE_HWEXEC */
-	ori     r11, r11, (MAS3_UW|MAS3_SW|MAS3_UR|MAS3_SR)@l /* set static perms */
+	ori	r11, r11, (MAS3_UW|MAS3_SW|MAS3_UR|MAS3_SR)@l /* set static perms */

 	/* update search PID in MAS6, AS = 0 */
 	mfspr	r12, SPRN_PID0
@@ -694,7 +694,7 @@ interrupt_base:
 	START_EXCEPTION(SPEUnavailable)
 	NORMAL_EXCEPTION_PROLOG
 	bne	load_up_spe
-	addi    r3,r1,STACK_FRAME_OVERHEAD
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
 #else
 	EXCEPTION(0x2020, SPEUnavailable, unknown_exception, EXC_XFER_EE)
@@ -741,10 +741,10 @@ data_access:

  * Both the instruction and data TLB miss get to this
  * point to load the TLB.
- * 	r10 - EA of fault
- * 	r11 - TLB (info from Linux PTE)
- * 	r12, r13 - available to use
- * 	CR5 - results of addr < TASK_SIZE
+ *	r10 - EA of fault
+ *	r11 - TLB (info from Linux PTE)
+ *	r12, r13 - available to use
+ *	CR5 - results of addr < TASK_SIZE
  *	MAS0, MAS1 - loaded with proper value when we get here
  *	MAS2, MAS3 - will need additional info from Linux PTE
  *	Upon exit, we reload everything and RFI.
@@ -813,7 +813,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_BIG_PHYS)
 	lwz	r13, tlbcam_index@l(r13)
 	rlwimi	r12, r13, 0, 20, 31
 7:
-	mtspr   SPRN_MAS0,r12
+	mtspr	SPRN_MAS0,r12
 #endif /* CONFIG_E200 */

 	tlbwe
@@ -855,17 +855,17 @@ load_up_spe:
 	beq	1f
 	addi	r4,r4,THREAD	/* want THREAD of last_task_used_spe */
 	SAVE_32EVRS(0,r10,r4)
-   	evxor	evr10, evr10, evr10	/* clear out evr10 */
+	evxor	evr10, evr10, evr10	/* clear out evr10 */
 	evmwumiaa evr10, evr10, evr10	/* evr10 <- ACC = 0 * 0 + ACC */
 	li	r5,THREAD_ACC
-   	evstddx	evr10, r4, r5		/* save off accumulator */
+	evstddx	evr10, r4, r5		/* save off accumulator */
 	lwz	r5,PT_REGS(r4)
 	lwz	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 	lis	r10,MSR_SPE@h
 	andc	r4,r4,r10	/* disable SPE for previous task */
 	stw	r4,_MSR-STACK_FRAME_OVERHEAD(r5)
 1:
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 	/* enable use of SPE after return */
 	oris	r9,r9,MSR_SPE@h
 	mfspr	r5,SPRN_SPRG3		/* current task's THREAD (phys) */
@@ -878,7 +878,7 @@ load_up_spe:
 #ifndef CONFIG_SMP
 	subi	r4,r5,THREAD
 	stw	r4,last_task_used_spe@l(r3)
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 	/* restore registers and return */
 2:	REST_4GPRS(3, r11)
 	lwz	r10,_CCR(r11)
@@ -963,10 +963,10 @@ _GLOBAL(giveup_spe)
 	lwz	r5,PT_REGS(r3)
 	cmpi	0,r5,0
 	SAVE_32EVRS(0, r4, r3)
-   	evxor	evr6, evr6, evr6	/* clear out evr6 */
+	evxor	evr6, evr6, evr6	/* clear out evr6 */
 	evmwumiaa evr6, evr6, evr6	/* evr6 <- ACC = 0 * 0 + ACC */
 	li	r4,THREAD_ACC
-   	evstddx	evr6, r4, r3		/* save off accumulator */
+	evstddx	evr6, r4, r3		/* save off accumulator */
 	mfspr	r6,SPRN_SPEFSCR
 	stw	r6,THREAD_SPEFSCR(r3)	/* save spefscr register value */
 	beq	1f
@@ -979,7 +979,7 @@ _GLOBAL(giveup_spe)
 	li	r5,0
 	lis	r4,last_task_used_spe@ha
 	stw	r5,last_task_used_spe@l(r4)
-#endif /* CONFIG_SMP */
+#endif /* !CONFIG_SMP */
 	blr
 #endif /* CONFIG_SPE */

@@ -1000,15 +1000,15 @@ _GLOBAL(giveup_fpu)
  */
 _GLOBAL(abort)
 	li	r13,0
-        mtspr   SPRN_DBCR0,r13		/* disable all debug events */
+	mtspr	SPRN_DBCR0,r13		/* disable all debug events */
 	isync
 	mfmsr	r13
 	ori	r13,r13,MSR_DE@l	/* Enable Debug Events */
 	mtmsr	r13
 	isync
-        mfspr   r13,SPRN_DBCR0
-        lis	r13,(DBCR0_IDM|DBCR0_RST_CHIP)@h
-        mtspr   SPRN_DBCR0,r13
+	mfspr	r13,SPRN_DBCR0
+	lis	r13,(DBCR0_IDM|DBCR0_RST_CHIP)@h
+	mtspr	SPRN_DBCR0,r13
 	isync

 _GLOBAL(set_context)
@@ -1043,7 +1043,7 @@ swapper_pg_dir:
 /* Reserved 4k for the critical exception stack & 4k for the machine
  * check stack per CPU for kernel mode exceptions */
 	.section .bss
-        .align 12
+	.align 12
 exception_stack_bottom:
 	.space	BOOKE_EXCEPTION_STACK_SIZE * NR_CPUS
 	.globl	exception_stack_top
-- 
1.5.2.4
