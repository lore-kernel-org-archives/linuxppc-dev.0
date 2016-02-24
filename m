Return-Path: <adam.buchbinder@gmail.com>
Received: from mail-pf0-x22d.google.com (mail-pf0-x22d.google.com
 [IPv6:2607:f8b0:400e:c00::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEF401A04B0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 05:51:21 +1100 (AEDT)
Received: by mail-pf0-x22d.google.com with SMTP id e127so17556475pfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 10:51:21 -0800 (PST)
From: Adam Buchbinder <adam.buchbinder@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: trivial@kernel.org,
	Adam Buchbinder <adam.buchbinder@gmail.com>
Subject: [PATCH] powerpc: Fix misspellings in comments.
Date: Wed, 24 Feb 2016 10:51:11 -0800
Message-Id: <1456339871-4368-1-git-send-email-adam.buchbinder@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Adam Buchbinder <adam.buchbinder@gmail.com>
---
 arch/powerpc/boot/rs6000.h                   | 2 +-
 arch/powerpc/boot/treeboot-akebono.c         | 2 +-
 arch/powerpc/boot/treeboot-currituck.c       | 2 +-
 arch/powerpc/boot/treeboot-iss4xx.c          | 2 +-
 arch/powerpc/crypto/aes-spe-core.S           | 4 ++--
 arch/powerpc/crypto/aes-spe-glue.c           | 2 +-
 arch/powerpc/include/asm/hydra.h             | 2 +-
 arch/powerpc/include/asm/io.h                | 2 +-
 arch/powerpc/include/asm/machdep.h           | 4 ++--
 arch/powerpc/include/asm/module.h            | 2 +-
 arch/powerpc/include/asm/pmac_feature.h      | 2 +-
 arch/powerpc/include/asm/reg.h               | 8 ++++----
 arch/powerpc/include/asm/reg_booke.h         | 2 +-
 arch/powerpc/include/asm/smu.h               | 2 +-
 arch/powerpc/include/asm/uninorth.h          | 2 +-
 arch/powerpc/include/asm/xics.h              | 2 +-
 arch/powerpc/include/uapi/asm/epapr_hcalls.h | 4 ++--
 arch/powerpc/kernel/head_44x.S               | 2 +-
 arch/powerpc/kernel/signal.c                 | 4 ++--
 arch/powerpc/kernel/signal.h                 | 2 +-
 arch/powerpc/kernel/traps.c                  | 2 +-
 arch/powerpc/kvm/book3s_xics.c               | 2 +-
 arch/powerpc/kvm/booke.c                     | 2 +-
 arch/powerpc/kvm/e500mc.c                    | 2 +-
 arch/powerpc/mm/tlb_low_64e.S                | 2 +-
 arch/powerpc/mm/tlb_nohash_low.S             | 4 ++--
 arch/powerpc/oprofile/op_model_cell.c        | 4 ++--
 arch/powerpc/perf/hv-24x7.h                  | 2 +-
 arch/powerpc/perf/power8-pmu.c               | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c    | 2 +-
 arch/powerpc/platforms/85xx/mpc85xx_cds.c    | 2 +-
 arch/powerpc/platforms/powermac/cache.S      | 2 +-
 arch/powerpc/platforms/powermac/feature.c    | 6 +++---
 arch/powerpc/platforms/powernv/idle.c        | 6 +++---
 arch/powerpc/platforms/powernv/npu-dma.c     | 2 +-
 arch/powerpc/platforms/ps3/interrupt.c       | 2 +-
 arch/powerpc/platforms/pseries/hvconsole.c   | 2 +-
 arch/powerpc/platforms/pseries/setup.c       | 2 +-
 arch/powerpc/sysdev/fsl_pci.c                | 2 +-
 arch/powerpc/sysdev/fsl_rmu.c                | 2 +-
 arch/powerpc/sysdev/i8259.c                  | 2 +-
 arch/powerpc/sysdev/mpic.c                   | 4 ++--
 42 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/boot/rs6000.h b/arch/powerpc/boot/rs6000.h
index 433f450..d70517c 100644
--- a/arch/powerpc/boot/rs6000.h
+++ b/arch/powerpc/boot/rs6000.h
@@ -239,5 +239,5 @@ struct external_reloc {
 #define DEFAULT_DATA_SECTION_ALIGNMENT 4
 #define DEFAULT_BSS_SECTION_ALIGNMENT 4
 #define DEFAULT_TEXT_SECTION_ALIGNMENT 4
-/* For new sections we havn't heard of before */
+/* For new sections we haven't heard of before */
 #define DEFAULT_SECTION_ALIGNMENT 4
diff --git a/arch/powerpc/boot/treeboot-akebono.c b/arch/powerpc/boot/treeboot-akebono.c
index b73174c..bcc5902 100644
--- a/arch/powerpc/boot/treeboot-akebono.c
+++ b/arch/powerpc/boot/treeboot-akebono.c
@@ -38,7 +38,7 @@
 
 BSS_STACK(4096);
 
-#define SPRN_PIR	0x11E	/* Processor Indentification Register */
+#define SPRN_PIR	0x11E	/* Processor Identification Register */
 #define USERDATA_LEN	256	/* Length of userdata passed in by PIBS */
 #define MAX_RANKS	0x4
 #define DDR3_MR0CF	0x80010011U
diff --git a/arch/powerpc/boot/treeboot-currituck.c b/arch/powerpc/boot/treeboot-currituck.c
index 925ae43..303d207 100644
--- a/arch/powerpc/boot/treeboot-currituck.c
+++ b/arch/powerpc/boot/treeboot-currituck.c
@@ -80,7 +80,7 @@ static void ibm_currituck_fixups(void)
 	}
 }
 
-#define SPRN_PIR	0x11E	/* Processor Indentification Register */
+#define SPRN_PIR	0x11E	/* Processor Identification Register */
 void platform_init(void)
 {
 	unsigned long end_of_ram, avail_ram;
diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
index 329e710..733f8bf 100644
--- a/arch/powerpc/boot/treeboot-iss4xx.c
+++ b/arch/powerpc/boot/treeboot-iss4xx.c
@@ -59,7 +59,7 @@ static void *iss_4xx_vmlinux_alloc(unsigned long size)
 	return (void *)ibm4xx_memstart;
 }
 
-#define SPRN_PIR	0x11E	/* Processor Indentification Register */
+#define SPRN_PIR	0x11E	/* Processor Identification Register */
 void platform_init(void)
 {
 	unsigned long end_of_ram = 0x08000000;
diff --git a/arch/powerpc/crypto/aes-spe-core.S b/arch/powerpc/crypto/aes-spe-core.S
index 5dc6bce..bc6ff43 100644
--- a/arch/powerpc/crypto/aes-spe-core.S
+++ b/arch/powerpc/crypto/aes-spe-core.S
@@ -61,7 +61,7 @@
  * via bl/blr. It expects that caller has pre-xored input data with first
  * 4 words of encryption key into rD0-rD3. Pointer/counter registers must
  * have also been set up before (rT0, rKP, CTR). Output is stored in rD0-rD3
- * and rW0-rW3 and caller must execute a final xor on the ouput registers.
+ * and rW0-rW3 and caller must execute a final xor on the output registers.
  * All working registers rD0-rD3 & rW0-rW7 are overwritten during processing.
  *
  */
@@ -209,7 +209,7 @@ ppc_encrypt_block_loop:
  * via bl/blr. It expects that caller has pre-xored input data with first
  * 4 words of encryption key into rD0-rD3. Pointer/counter registers must
  * have also been set up before (rT0, rKP, CTR). Output is stored in rD0-rD3
- * and rW0-rW3 and caller must execute a final xor on the ouput registers.
+ * and rW0-rW3 and caller must execute a final xor on the output registers.
  * All working registers rD0-rD3 & rW0-rW7 are overwritten during processing.
  *
  */
diff --git a/arch/powerpc/crypto/aes-spe-glue.c b/arch/powerpc/crypto/aes-spe-glue.c
index 93ee046..6d99ebf 100644
--- a/arch/powerpc/crypto/aes-spe-glue.c
+++ b/arch/powerpc/crypto/aes-spe-glue.c
@@ -32,7 +32,7 @@
  * 16 byte block block or 25 cycles per byte. Thus 768 bytes of input data
  * will need an estimated maximum of 20,000 cycles. Headroom for cache misses
  * included. Even with the low end model clocked at 667 MHz this equals to a
- * critical time window of less than 30us. The value has been choosen to
+ * critical time window of less than 30us. The value has been chosen to
  * process a 512 byte disk block in one or a large 1400 bytes IPsec network
  * packet in two runs.
  *
diff --git a/arch/powerpc/include/asm/hydra.h b/arch/powerpc/include/asm/hydra.h
index 1cb39c9..b3b0f2d 100644
--- a/arch/powerpc/include/asm/hydra.h
+++ b/arch/powerpc/include/asm/hydra.h
@@ -89,7 +89,7 @@ extern volatile struct Hydra __iomem *Hydra;
 #define HYDRA_INT_EXT2		13	/* PCI IRQX */
 #define HYDRA_INT_EXT3		14	/* PCI IRQY */
 #define HYDRA_INT_EXT4		15	/* PCI IRQZ */
-#define HYDRA_INT_EXT5		16	/* IDE Primay/Secondary */
+#define HYDRA_INT_EXT5		16	/* IDE Primary/Secondary */
 #define HYDRA_INT_EXT6		17	/* IDE Secondary */
 #define HYDRA_INT_EXT7		18	/* Power Off Request */
 #define HYDRA_INT_SPARE		19
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 6c1297e..2fd1690 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -300,7 +300,7 @@ extern void _memcpy_toio(volatile void __iomem *dest, const void *src,
  * When CONFIG_PPC_INDIRECT_MMIO is set, the platform can provide hooks
  * on all MMIOs. (Note that this is all 64 bits only for now)
  *
- * To help platforms who may need to differenciate MMIO addresses in
+ * To help platforms who may need to differentiate MMIO addresses in
  * their hooks, a bitfield is reserved for use by the platform near the
  * top of MMIO addresses (not PIO, those have to cope the hard way).
  *
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 3f191f5..5c38e49 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -174,11 +174,11 @@ struct machdep_calls {
 	   platform, called once per cpu. */
 	void		(*enable_pmcs)(void);
 
-	/* Set DABR for this platform, leave empty for default implemenation */
+	/* Set DABR for this platform, leave empty for default implementation */
 	int		(*set_dabr)(unsigned long dabr,
 				    unsigned long dabrx);
 
-	/* Set DAWR for this platform, leave empty for default implemenation */
+	/* Set DAWR for this platform, leave empty for default implementation */
 	int		(*set_dawr)(unsigned long dawr,
 				    unsigned long dawrx);
 
diff --git a/arch/powerpc/include/asm/module.h b/arch/powerpc/include/asm/module.h
index dcfcad1..5f1526f 100644
--- a/arch/powerpc/include/asm/module.h
+++ b/arch/powerpc/include/asm/module.h
@@ -19,7 +19,7 @@
  * Thanks to Paul M for explaining this.
  *
  * PPC can only do rel jumps += 32MB, and often the kernel and other
- * modules are furthur away than this.  So, we jump to a table of
+ * modules are further away than this.  So, we jump to a table of
  * trampolines attached to the module (the Procedure Linkage Table)
  * whenever that happens.
  */
diff --git a/arch/powerpc/include/asm/pmac_feature.h b/arch/powerpc/include/asm/pmac_feature.h
index 10902c9..9256979 100644
--- a/arch/powerpc/include/asm/pmac_feature.h
+++ b/arch/powerpc/include/asm/pmac_feature.h
@@ -46,7 +46,7 @@
 
 /* PowerSurge are the first generation of PCI Pmacs. This include
  * all of the Grand-Central based machines. We currently don't
- * differenciate most of them.
+ * differentiate most of them.
  */
 #define PMAC_TYPE_PSURGE		0x10	/* PowerSurge */
 #define PMAC_TYPE_ANS			0x11	/* Apple Network Server */
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index c4cb2ff..11a81bd 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -376,7 +376,7 @@
 #define SPRN_TSCR	0x399	/* Thread Switch Control Register */
 
 #define SPRN_DEC	0x016		/* Decrement Register */
-#define SPRN_DER	0x095		/* Debug Enable Regsiter */
+#define SPRN_DER	0x095		/* Debug Enable Register */
 #define DER_RSTE	0x40000000	/* Reset Interrupt */
 #define DER_CHSTPE	0x20000000	/* Check Stop */
 #define DER_MCIE	0x10000000	/* Machine Check Interrupt */
@@ -401,7 +401,7 @@
 #define SPRN_DPDES	0x0B0		/* Directed Priv. Doorbell Exc. State */
 #define SPRN_EAR	0x11A		/* External Address Register */
 #define SPRN_HASH1	0x3D2		/* Primary Hash Address Register */
-#define SPRN_HASH2	0x3D3		/* Secondary Hash Address Resgister */
+#define SPRN_HASH2	0x3D3		/* Secondary Hash Address Register */
 #define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
 #define HID0_HDICE_SH	(63 - 23)	/* 970 HDEC interrupt enable */
 #define HID0_EMCP	(1<<31)		/* Enable Machine Check pin */
@@ -514,7 +514,7 @@
 #define ICTRL_EICP	0x00000100	/* enable icache par. check */
 #define SPRN_IMISS	0x3D4		/* Instruction TLB Miss Register */
 #define SPRN_IMMR	0x27E		/* Internal Memory Map Register */
-#define SPRN_L2CR	0x3F9		/* Level 2 Cache Control Regsiter */
+#define SPRN_L2CR	0x3F9		/* Level 2 Cache Control Register */
 #define SPRN_L2CR2	0x3f8
 #define L2CR_L2E		0x80000000	/* L2 enable */
 #define L2CR_L2PE		0x40000000	/* L2 parity enable */
@@ -549,7 +549,7 @@
 #define L2CR_L2DO_745x		0x00010000	/* L2 data only (745x) */
 #define L2CR_L2REP_745x		0x00001000	/* L2 repl. algorithm (745x) */
 #define L2CR_L2HWF_745x		0x00000800	/* L2 hardware flush (745x) */
-#define SPRN_L3CR		0x3FA	/* Level 3 Cache Control Regsiter */
+#define SPRN_L3CR		0x3FA	/* Level 3 Cache Control Register */
 #define L3CR_L3E		0x80000000	/* L3 enable */
 #define L3CR_L3PE		0x40000000	/* L3 data parity enable */
 #define L3CR_L3APE		0x20000000	/* L3 addr parity enable */
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 2fef74b..737e012 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -681,7 +681,7 @@
 #define SPRN_CDBCR	0x3D7	/* Cache Debug Control Register */
 #define SPRN_TBHI	0x3DC	/* Time Base High */
 #define SPRN_TBLO	0x3DD	/* Time Base Low */
-#define SPRN_DBCR	0x3F2	/* Debug Control Regsiter */
+#define SPRN_DBCR	0x3F2	/* Debug Control Register */
 #define SPRN_PBL1	0x3FC	/* Protection Bound Lower 1 */
 #define SPRN_PBL2	0x3FE	/* Protection Bound Lower 2 */
 #define SPRN_PBU1	0x3FD	/* Protection Bound Upper 1 */
diff --git a/arch/powerpc/include/asm/smu.h b/arch/powerpc/include/asm/smu.h
index 37d2da6..f280dd1 100644
--- a/arch/powerpc/include/asm/smu.h
+++ b/arch/powerpc/include/asm/smu.h
@@ -154,7 +154,7 @@
   *
   * The Darwin I2C driver is less subtle though. On any non-success status
   * from the response command, it waits 5ms and tries again up to 20 times,
-  * it doesn't differenciate between fatal errors or "busy" status.
+  * it doesn't differentiate between fatal errors or "busy" status.
   *
   * This driver provides an asynchronous paramblock based i2c command
   * interface to be used either directly by low level code or by a higher
diff --git a/arch/powerpc/include/asm/uninorth.h b/arch/powerpc/include/asm/uninorth.h
index d12b11d..a1d1129 100644
--- a/arch/powerpc/include/asm/uninorth.h
+++ b/arch/powerpc/include/asm/uninorth.h
@@ -132,7 +132,7 @@
 
 /* This one _might_ return the CPU number of the CPU reading it;
  * the bootROM decides whether to boot or to sleep/spinloop depending
- * on this register beeing 0 or not
+ * on this register being 0 or not
  */
 #define UNI_N_CPU_NUMBER		0x0050
 
diff --git a/arch/powerpc/include/asm/xics.h b/arch/powerpc/include/asm/xics.h
index 0e25bdb..5d61bbc 100644
--- a/arch/powerpc/include/asm/xics.h
+++ b/arch/powerpc/include/asm/xics.h
@@ -1,5 +1,5 @@
 /*
- * Common definitions accross all variants of ICP and ICS interrupt
+ * Common definitions across all variants of ICP and ICS interrupt
  * controllers.
  */
 
diff --git a/arch/powerpc/include/uapi/asm/epapr_hcalls.h b/arch/powerpc/include/uapi/asm/epapr_hcalls.h
index 7f9c74b..b4504f3 100644
--- a/arch/powerpc/include/uapi/asm/epapr_hcalls.h
+++ b/arch/powerpc/include/uapi/asm/epapr_hcalls.h
@@ -78,7 +78,7 @@
 #define EV_SUCCESS		0
 #define EV_EPERM		1	/* Operation not permitted */
 #define EV_ENOENT		2	/*  Entry Not Found */
-#define EV_EIO			3	/* I/O error occured */
+#define EV_EIO			3	/* I/O error occurred */
 #define EV_EAGAIN		4	/* The operation had insufficient
 					 * resources to complete and should be
 					 * retried
@@ -89,7 +89,7 @@
 #define EV_ENODEV		7	/* No such device */
 #define EV_EINVAL		8	/* An argument supplied to the hcall
 					   was out of range or invalid */
-#define EV_INTERNAL		9	/* An internal error occured */
+#define EV_INTERNAL		9	/* An internal error occurred */
 #define EV_CONFIG		10	/* A configuration error was detected */
 #define EV_INVALID_STATE	11	/* The object is in an invalid state */
 #define EV_UNIMPLEMENTED	12	/* Unimplemented hypercall */
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index b5061ab..9cdf5c7 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -806,7 +806,7 @@ _GLOBAL(set_context)
 _GLOBAL(init_cpu_state)
 	mflr	r22
 #ifdef CONFIG_PPC_47x
-	/* We use the PVR to differenciate 44x cores from 476 */
+	/* We use the PVR to differentiate 44x cores from 476 */
 	mfspr	r3,SPRN_PVR
 	srwi	r3,r3,16
 	cmplwi	cr0,r3,PVR_476FPE@h
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index cf8c7e4..cb64d6f 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -1,7 +1,7 @@
 /*
  * Common signal handling code for both 32 and 64 bits
  *
- *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
+ *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Corporation
  *    Extracted from signal_32.c and signal_64.c
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -178,7 +178,7 @@ unsigned long get_tm_stackpointer(struct pt_regs *regs)
 	 * need to use the stack pointer from the checkpointed state, rather
 	 * than the speculated state.  This ensures that the signal context
 	 * (written tm suspended) will be written below the stack required for
-	 * the rollback.  The transaction is aborted becuase of the treclaim,
+	 * the rollback.  The transaction is aborted because of the treclaim,
 	 * so any memory written between the tbegin and the signal will be
 	 * rolled back anyway.
 	 *
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index 51b2741..be305c8 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -1,5 +1,5 @@
 /*
- *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
+ *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Corporation
  *    Extracted from signal_32.c and signal_64.c
  *
  * This file is subject to the terms and conditions of the GNU General
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index b6becc7..1b7a2b8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1394,7 +1394,7 @@ void facility_unavailable_exception(struct pt_regs *regs)
 		 * is a read DSCR attempt through a mfspr instruction, we
 		 * just emulate the instruction instead. This code path will
 		 * always emulate all the mfspr instructions till the user
-		 * has attempted atleast one mtspr instruction. This way it
+		 * has attempted at least one mtspr instruction. This way it
 		 * preserves the same behaviour when the user is accessing
 		 * the DSCR through privilege level only SPR number (0x11)
 		 * which is emulated through illegal instruction exception.
diff --git a/arch/powerpc/kvm/book3s_xics.c b/arch/powerpc/kvm/book3s_xics.c
index 905e94a..46871d5 100644
--- a/arch/powerpc/kvm/book3s_xics.c
+++ b/arch/powerpc/kvm/book3s_xics.c
@@ -432,7 +432,7 @@ static void icp_deliver_irq(struct kvmppc_xics *xics, struct kvmppc_icp *icp,
 	 * the whole masked_pending business which is about not
 	 * losing interrupts that occur while masked.
 	 *
-	 * I don't differenciate normal deliveries and resends, this
+	 * I don't differentiate normal deliveries and resends, this
 	 * implementation will differ from PAPR and not lose such
 	 * interrupts.
 	 */
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 778ef86..4d66f44 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -992,7 +992,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 	kvmppc_restart_interrupt(vcpu, exit_nr);
 
 	/*
-	 * get last instruction before beeing preempted
+	 * get last instruction before being preempted
 	 * TODO: for e6500 check also BOOKE_INTERRUPT_LRAT_ERROR & ESR_DATA
 	 */
 	switch (exit_nr) {
diff --git a/arch/powerpc/kvm/e500mc.c b/arch/powerpc/kvm/e500mc.c
index cda695d..f48a0c2 100644
--- a/arch/powerpc/kvm/e500mc.c
+++ b/arch/powerpc/kvm/e500mc.c
@@ -182,7 +182,7 @@ int kvmppc_core_check_processor_compat(void)
 		r = 0;
 #ifdef CONFIG_ALTIVEC
 	/*
-	 * Since guests have the priviledge to enable AltiVec, we need AltiVec
+	 * Since guests have the privilege to enable AltiVec, we need AltiVec
 	 * support in the host to save/restore their context.
 	 * Don't use CPU_FTR_ALTIVEC to identify cores with AltiVec unit
 	 * because it's cleared in the absence of CONFIG_ALTIVEC!
diff --git a/arch/powerpc/mm/tlb_low_64e.S b/arch/powerpc/mm/tlb_low_64e.S
index 29d6987..eb82d78 100644
--- a/arch/powerpc/mm/tlb_low_64e.S
+++ b/arch/powerpc/mm/tlb_low_64e.S
@@ -895,7 +895,7 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_USE_PAIRED_MAS)
 BEGIN_MMU_FTR_SECTION
 virt_page_table_tlb_miss_done:
 
-	/* We have overriden MAS2:EPN but currently our primary TLB miss
+	/* We have overridden MAS2:EPN but currently our primary TLB miss
 	 * handler will always restore it so that should not be an issue,
 	 * if we ever optimize the primary handler to not write MAS2 on
 	 * some cases, we'll have to restore MAS2:EPN here based on the
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_low.S
index 68c4775..eabecfc 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -108,7 +108,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	blr
 2:
 #ifdef CONFIG_PPC_47x
-	oris	r7,r6,0x8000	/* specify way explicitely */
+	oris	r7,r6,0x8000	/* specify way explicitly */
 	clrrwi	r4,r3,12	/* get an EPN for the hashing with V = 0 */
 	ori	r4,r4,PPC47x_TLBE_SIZE
 	tlbwe   r4,r7,0		/* write it */
@@ -149,7 +149,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	li	r3,-1		/* Current set */
 	lis	r10,tlb_47x_boltmap@h
 	ori	r10,r10,tlb_47x_boltmap@l
-	lis	r7,0x8000	/* Specify way explicitely */
+	lis	r7,0x8000	/* Specify way explicitly */
 
 	b	9f		/* For each set */
 
diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprofile/op_model_cell.c
index 863d893..c82497a 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -208,7 +208,7 @@ static void pm_rtas_reset_signals(u32 node)
 
 	/*
 	 * The debug bus is being set to the passthru disable state.
-	 * However, the FW still expects atleast one legal signal routing
+	 * However, the FW still expects at least one legal signal routing
 	 * entry or it will return an error on the arguments.	If we don't
 	 * supply a valid entry, we must ignore all return values.  Ignoring
 	 * all return values means we might miss an error we should be
@@ -1008,7 +1008,7 @@ static int initial_lfsr[] = {
  *
  * To avoid the time to compute the LFSR, a lookup table is used.  The 24 bit
  * LFSR sequence is broken into four ranges.  The spacing of the precomputed
- * values is adjusted in each range so the error between the user specifed
+ * values is adjusted in each range so the error between the user specified
  * number (N) of events between samples and the actual number of events based
  * on the precomputed value will be les then about 6.2%.  Note, if the user
  * specifies N < 2^16, the LFSR value that is 2^16 from the end will be used.
diff --git a/arch/powerpc/perf/hv-24x7.h b/arch/powerpc/perf/hv-24x7.h
index 0f9fa21..c57d67d 100644
--- a/arch/powerpc/perf/hv-24x7.h
+++ b/arch/powerpc/perf/hv-24x7.h
@@ -80,7 +80,7 @@ struct hv_24x7_result {
 	__u8 results_complete;
 	__be16 num_elements_returned;
 
-	/* This is a copy of @data_size from the coresponding hv_24x7_request */
+	/* This is a copy of @data_size from the corresponding hv_24x7_request */
 	__be16 result_element_data_size;
 	__u8 reserved[0x2];
 
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 9958ba8..be9b7ae 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -415,7 +415,7 @@ static int power8_compute_mmcr(u64 event[], int n_ev,
 			pmc_inuse |= 1 << pmc;
 	}
 
-	/* In continous sampling mode, update SDAR on TLB miss */
+	/* In continuous sampling mode, update SDAR on TLB miss */
 	mmcra = MMCRA_SDAR_MODE_TLB;
 	mmcr1 = mmcr2 = 0;
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index 6eb3b2a..00282c2 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -319,7 +319,7 @@ mpc52xx_pci_setup(struct pci_controller *hose,
 
 	tmp = in_be32(&pci_regs->gscr);
 #if 0
-	/* Reset the exteral bus ( internal PCI controller is NOT resetted ) */
+	/* Reset the exteral bus ( internal PCI controller is NOT reset ) */
 	/* Not necessary and can be a bad thing if for example the bootloader
 	   is displaying a splash screen or ... Just left here for
 	   documentation purpose if anyone need it */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 5ac70de..d7e87ff 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -99,7 +99,7 @@ static void mpc85xx_cds_restart(char *cmd)
 		pci_read_config_byte(dev, 0x47, &tmp);
 
 		/*
-		 *  At this point, the harware reset should have triggered.
+		 *  At this point, the hardware reset should have triggered.
 		 *  However, if it doesn't work for some mysterious reason,
 		 *  just fall through to the default reset below.
 		 */
diff --git a/arch/powerpc/platforms/powermac/cache.S b/arch/powerpc/platforms/powermac/cache.S
index 6be1a4a..cc5347e 100644
--- a/arch/powerpc/platforms/powermac/cache.S
+++ b/arch/powerpc/platforms/powermac/cache.S
@@ -23,7 +23,7 @@
  * when going to sleep, when doing a PMU based cpufreq transition,
  * or when "offlining" a CPU on SMP machines. This code is over
  * paranoid, but I've had enough issues with various CPU revs and
- * bugs that I decided it was worth beeing over cautious
+ * bugs that I decided it was worth being over cautious
  */
 
 _GLOBAL(flush_disable_caches)
diff --git a/arch/powerpc/platforms/powermac/feature.c b/arch/powerpc/platforms/powermac/feature.c
index 4882bfd..1e02328 100644
--- a/arch/powerpc/platforms/powermac/feature.c
+++ b/arch/powerpc/platforms/powermac/feature.c
@@ -198,7 +198,7 @@ static long ohare_htw_scc_enable(struct device_node *node, long param,
 			if (htw) {
 				/* Side effect: this will also power up the
 				 * modem, but it's too messy to figure out on which
-				 * ports this controls the tranceiver and on which
+				 * ports this controls the transceiver and on which
 				 * it controls the modem
 				 */
 				if (trans)
@@ -463,7 +463,7 @@ static long heathrow_sound_enable(struct device_node *node, long param,
 	unsigned long		flags;
 
 	/* B&W G3 and Yikes don't support that properly (the
-	 * sound appear to never come back after beeing shut down).
+	 * sound appear to never come back after being shut down).
 	 */
 	if (pmac_mb.model_id == PMAC_TYPE_YOSEMITE ||
 	    pmac_mb.model_id == PMAC_TYPE_YIKES)
@@ -2770,7 +2770,7 @@ set_initial_features(void)
 	 * but I'm not too sure it was audited for side-effects on other
 	 * ohare based machines...
 	 * Since I still have difficulties figuring the right way to
-	 * differenciate them all and since that hack was there for a long
+	 * differentiate them all and since that hack was there for a long
 	 * time, I'll keep it around
 	 */
 	if (macio_chips[0].type == macio_ohare) {
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 15bfbcd..fcc8b68 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -35,9 +35,9 @@ int pnv_save_sprs_for_winkle(void)
 	int rc;
 
 	/*
-	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric accross
+	 * hid0, hid1, hid4, hid5, hmeer and lpcr values are symmetric across
 	 * all cpus at boot. Get these reg values of current cpu and use the
-	 * same accross all cpus.
+	 * same across all cpus.
 	 */
 	uint64_t lpcr_val = mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1;
 	uint64_t hid0_val = mfspr(SPRN_HID0);
@@ -185,7 +185,7 @@ static ssize_t store_fastsleep_workaround_applyonce(struct device *dev,
 	 * fastsleep workaround needs to be left in 'applied' state on all
 	 * the cores. Do this by-
 	 * 1. Patching out the call to 'undo' workaround in fastsleep exit path
-	 * 2. Sending ipi to all the cores which have atleast one online thread
+	 * 2. Sending ipi to all the cores which have at least one online thread
 	 * 3. Patching out the call to 'apply' workaround in fastsleep entry
 	 * path
 	 * There is no need to send ipi to cores which have all threads
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index e85aa90..7229acd 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -278,7 +278,7 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe *npe)
 
 /*
  * Enable/disable bypass mode on the NPU. The NPU only supports one
- * window per link, so bypass needs to be explicity enabled or
+ * window per link, so bypass needs to be explicitly enabled or
  * disabled. Unlike for a PHB3 bypass and non-bypass modes can't be
  * active at the same time.
  */
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 638c406..b831638 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -78,7 +78,7 @@ struct ps3_bmp {
 /**
  * struct ps3_private - a per cpu data structure
  * @bmp: ps3_bmp structure
- * @bmp_lock: Syncronize access to bmp.
+ * @bmp_lock: Synchronize access to bmp.
  * @ipi_debug_brk_mask: Mask for debug break IPIs
  * @ppe_id: HV logical_ppe_id
  * @thread_id: HV thread_id
diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index 849b29b..74da18d 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -31,7 +31,7 @@
 #include <asm/plpar_wrappers.h>
 
 /**
- * hvc_get_chars - retrieve characters from firmware for denoted vterm adatper
+ * hvc_get_chars - retrieve characters from firmware for denoted vterm adapter
  * @vtermno: The vtermno or unit_address of the adapter from which to fetch the
  *	data.
  * @buf: The character buffer into which to put the character data fetched from
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 36df46e..6e944fc 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -515,7 +515,7 @@ static void __init pSeries_setup_arch(void)
 
 	fwnmi_init();
 
-	/* By default, only probe PCI (can be overriden by rtas_pci) */
+	/* By default, only probe PCI (can be overridden by rtas_pci) */
 	pci_add_flags(PCI_PROBE_ONLY);
 
 	/* Find and initialize PCI host bridges */
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c69e88e..85729f4 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -575,7 +575,7 @@ int fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		/* use fsl_indirect_read_config for PCIe */
 		hose->ops = &fsl_indirect_pcie_ops;
-		/* For PCIE read HEADER_TYPE to identify controler mode */
+		/* For PCIE read HEADER_TYPE to identify controller mode */
 		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
 		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
 			goto no_bridge;
diff --git a/arch/powerpc/sysdev/fsl_rmu.c b/arch/powerpc/sysdev/fsl_rmu.c
index b48197a..ffe0ee8 100644
--- a/arch/powerpc/sysdev/fsl_rmu.c
+++ b/arch/powerpc/sysdev/fsl_rmu.c
@@ -570,7 +570,7 @@ int fsl_rio_port_write_init(struct fsl_rio_pw *pw)
 	out_be32(&pw->pw_regs->pwsr,
 		 (RIO_IPWSR_TE | RIO_IPWSR_QFI | RIO_IPWSR_PWD));
 
-	/* Configure port write contoller for snooping enable all reporting,
+	/* Configure port write controller for snooping enable all reporting,
 	   clear queue full */
 	out_be32(&pw->pw_regs->pwmr,
 		 RIO_IPWMR_SEN | RIO_IPWMR_QFIE | RIO_IPWMR_EIE | RIO_IPWMR_CQ);
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 6f99ed3..aa2c186 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -238,7 +238,7 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	/* init master interrupt controller */
 	outb(0x11, 0x20); /* Start init sequence */
 	outb(0x00, 0x21); /* Vector base */
-	outb(0x04, 0x21); /* edge tiggered, Cascade (slave) on IRQ2 */
+	outb(0x04, 0x21); /* edge triggered, Cascade (slave) on IRQ2 */
 	outb(0x01, 0x21); /* Select 8086 mode */
 
 	/* init slave interrupt controller */
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 2a0452e..afe3c7c 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -2,7 +2,7 @@
  *  arch/powerpc/kernel/mpic.c
  *
  *  Driver for interrupt controllers following the OpenPIC standard, the
- *  common implementation beeing IBM's MPIC. This driver also can deal
+ *  common implementation being IBM's MPIC. This driver also can deal
  *  with various broken implementations of this HW.
  *
  *  Copyright (C) 2004 Benjamin Herrenschmidt, IBM Corp.
@@ -1657,7 +1657,7 @@ void __init mpic_init(struct mpic *mpic)
 		}
 	}
 
-	/* FSL mpic error interrupt intialization */
+	/* FSL mpic error interrupt initialization */
 	if (mpic->flags & MPIC_FSL_HAS_EIMR)
 		mpic_err_int_init(mpic, MPIC_FSL_ERR_INT);
 }
-- 
2.7.0.rc3.207.g0ac5344
