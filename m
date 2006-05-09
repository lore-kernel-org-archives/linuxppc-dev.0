Return-Path: <mikey@ozlabs.org>
From: Michael Neuling <mikey@neuling.org>
To: linuxppc-dev@ozlabs.org, paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: whitespace cleanup in reg.h
Date: Tue, 09 May 2006 11:33:38 -0500
Sender: mikey@ozlabs.org
Message-Id: <20060509163419.E4E1767A04@ozlabs.org>
Reply-To: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In reg.h we mostly have #define<space> but there are a few #define<tab>
around.  Clean these up so we use space exclusively.

Signed-off-by: Michael Neuling <mikey@neuling.org>

---
It's clear this patch is fundamental to our future prosperity!  

 include/asm-powerpc/reg.h |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

Index: linux-2.6-powerpc/include/asm-powerpc/reg.h
===================================================================
--- linux-2.6-powerpc.orig/include/asm-powerpc/reg.h
+++ linux-2.6-powerpc/include/asm-powerpc/reg.h
@@ -153,7 +153,7 @@
 #define SPRN_DABR	0x3F5	/* Data Address Breakpoint Register */
 #define   DABR_TRANSLATION	(1UL << 2)
 #define SPRN_DAR	0x013	/* Data Address Register */
-#define	SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
+#define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
@@ -258,16 +258,16 @@
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define SPRN_HID4	0x3F4		/* 970 HID4 */
 #define SPRN_HID5	0x3F6		/* 970 HID5 */
-#define	SPRN_HID6	0x3F9	/* BE HID 6 */
-#define	  HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
-#define	  HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
-#define	SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
-#define	  TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
-#define	  TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
-#define	  TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
-#define	  TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
-#define	SPRN_TSC 	0x3FD	/* Thread switch control on others */
-#define	SPRN_TST 	0x3FC	/* Thread switch timeout on others */
+#define SPRN_HID6	0x3F9	/* BE HID 6 */
+#define   HID6_LB	(0x0F<<12) /* Concurrent Large Page Modes */
+#define   HID6_DLP	(1<<20)	/* Disable all large page modes (4K only) */
+#define SPRN_TSC_CELL	0x399	/* Thread switch control on Cell */
+#define   TSC_CELL_DEC_ENABLE_0	0x400000 /* Decrementer Interrupt */
+#define   TSC_CELL_DEC_ENABLE_1	0x200000 /* Decrementer Interrupt */
+#define   TSC_CELL_EE_ENABLE	0x100000 /* External Interrupt */
+#define   TSC_CELL_EE_BOOST	0x080000 /* External Interrupt Boost */
+#define SPRN_TSC 	0x3FD	/* Thread switch control on others */
+#define SPRN_TST 	0x3FC	/* Thread switch timeout on others */
 #if !defined(SPRN_IAC1) && !defined(SPRN_IAC2)
 #define SPRN_IAC1	0x3F4		/* Instruction Address Compare 1 */
 #define SPRN_IAC2	0x3F5		/* Instruction Address Compare 2 */
@@ -362,7 +362,7 @@
 #endif
 #define SPRN_PTEHI	0x3D5	/* 981 7450 PTE HI word (S/W TLB load) */
 #define SPRN_PTELO	0x3D6	/* 982 7450 PTE LO word (S/W TLB load) */
-#define	SPRN_PURR	0x135	/* Processor Utilization of Resources Reg */
+#define SPRN_PURR	0x135	/* Processor Utilization of Resources Reg */
 #define SPRN_PVR	0x11F	/* Processor Version Register */
 #define SPRN_RPA	0x3D6	/* Required Physical Address Register */
 #define SPRN_SDA	0x3BF	/* Sampled Data Address Register */
@@ -559,20 +559,20 @@
 
 /* 64-bit processors */
 /* XXX the prefix should be PVR_, we'll do a global sweep to fix it one day */
-#define	PV_NORTHSTAR	0x0033
-#define	PV_PULSAR	0x0034
-#define	PV_POWER4	0x0035
-#define	PV_ICESTAR	0x0036
-#define	PV_SSTAR	0x0037
-#define	PV_POWER4p	0x0038
+#define PV_NORTHSTAR	0x0033
+#define PV_PULSAR	0x0034
+#define PV_POWER4	0x0035
+#define PV_ICESTAR	0x0036
+#define PV_SSTAR	0x0037
+#define PV_POWER4p	0x0038
 #define PV_970		0x0039
-#define	PV_POWER5	0x003A
+#define PV_POWER5	0x003A
 #define PV_POWER5p	0x003B
 #define PV_970FX	0x003C
-#define	PV_630		0x0040
-#define	PV_630p	0x0041
-#define	PV_970MP	0x0044
-#define	PV_BE		0x0070
+#define PV_630		0x0040
+#define PV_630p	0x0041
+#define PV_970MP	0x0044
+#define PV_BE		0x0070
 
 /*
  * Number of entries in the SLB. If this ever changes we should handle
