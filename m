Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EFA71DDE44
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 01:13:13 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l4AFD8bh012455
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 08:13:08 -0700 (MST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Change include protections to ASM_POWERPC
Date: Thu, 10 May 2007 10:13:04 -0500
Message-Id: <11788099841311-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change several headers in include/asm-powerpc that currently use some variation
of ASM_PPC to use ASM_POWERPC instead.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 include/asm-powerpc/mpc8260.h      |    6 +++---
 include/asm-powerpc/pmac_feature.h |    6 +++---
 include/asm-powerpc/tsi108_irq.h   |    6 +++---
 include/asm-powerpc/tsi108_pci.h   |    6 +++---
 include/asm-powerpc/unistd.h       |    6 +++---
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
index f1b83b0..e0d4807 100644
--- a/include/asm-powerpc/mpc8260.h
+++ b/include/asm-powerpc/mpc8260.h
@@ -5,8 +5,8 @@
  * this one and the configuration switching is done here.
  */
 #ifdef __KERNEL__
-#ifndef __ASM_PPC_MPC8260_H__
-#define __ASM_PPC_MPC8260_H__
+#ifndef __ASM_POWERPC_MPC8260_H__
+#define __ASM_POWERPC_MPC8260_H__
 
 
 #ifdef CONFIG_8260
@@ -20,5 +20,5 @@
 #endif
 
 #endif /* CONFIG_8260 */
-#endif /* !__ASM_PPC_MPC8260_H__ */
+#endif /* !__ASM_POWERPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/pmac_feature.h b/include/asm-powerpc/pmac_feature.h
index d43d91b..26bcb0a 100644
--- a/include/asm-powerpc/pmac_feature.h
+++ b/include/asm-powerpc/pmac_feature.h
@@ -28,8 +28,8 @@
  */
 
 #ifdef __KERNEL__
-#ifndef __PPC_ASM_PMAC_FEATURE_H
-#define __PPC_ASM_PMAC_FEATURE_H
+#ifndef __ASM_POWERPC_PMAC_FEATURE_H
+#define __ASM_POWERPC_PMAC_FEATURE_H
 
 #include <asm/macio.h>
 #include <asm/machdep.h>
@@ -393,5 +393,5 @@ extern u32 __iomem *uninorth_base;
 #define UN_BIC(r,v)	(UN_OUT((r), UN_IN(r) & ~(v)))
 
 
-#endif /* __PPC_ASM_PMAC_FEATURE_H */
+#endif /* __ASM_POWERPC_PMAC_FEATURE_H */
 #endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/tsi108_irq.h b/include/asm-powerpc/tsi108_irq.h
index 3e4d04e..6ed9397 100644
--- a/include/asm-powerpc/tsi108_irq.h
+++ b/include/asm-powerpc/tsi108_irq.h
@@ -26,8 +26,8 @@
  * demultiplexing on TSI108EMU/SVB boards.
  */
 
-#ifndef _ASM_PPC_TSI108_IRQ_H
-#define _ASM_PPC_TSI108_IRQ_H
+#ifndef _ASM_POWERPC_TSI108_IRQ_H
+#define _ASM_POWERPC_TSI108_IRQ_H
 
 /*
  * Tsi108 interrupts
@@ -121,4 +121,4 @@ typedef enum {
 	TSI108_IRQ_DIRECTED,
 	TSI108_IRQ_DISTRIBUTED,
 } TSI108_IRQ_MODE;
-#endif				/*  _ASM_PPC_TSI108_IRQ_H */
+#endif				/*  _ASM_POWERPC_TSI108_IRQ_H */
diff --git a/include/asm-powerpc/tsi108_pci.h b/include/asm-powerpc/tsi108_pci.h
index a9f92f7..5653d7c 100644
--- a/include/asm-powerpc/tsi108_pci.h
+++ b/include/asm-powerpc/tsi108_pci.h
@@ -18,8 +18,8 @@
  * MA 02111-1307 USA
  */
 
-#ifndef _ASM_PPC_TSI108_PCI_H
-#define _ASM_PPC_TSI108_PCI_H
+#ifndef _ASM_POWERPC_TSI108_PCI_H
+#define _ASM_POWERPC_TSI108_PCI_H
 
 #include <asm/tsi108.h>
 
@@ -42,4 +42,4 @@ extern void tsi108_pci_int_init(struct device_node *node);
 extern void tsi108_irq_cascade(unsigned int irq, struct irq_desc *desc);
 extern void tsi108_clear_pci_cfg_error(void);
 
-#endif				/*  _ASM_PPC_TSI108_PCI_H */
+#endif				/*  _ASM_POWERPC_TSI108_PCI_H */
diff --git a/include/asm-powerpc/unistd.h b/include/asm-powerpc/unistd.h
index 2baedbe..ffbc369 100644
--- a/include/asm-powerpc/unistd.h
+++ b/include/asm-powerpc/unistd.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_PPC_UNISTD_H_
-#define _ASM_PPC_UNISTD_H_
+#ifndef _ASM_POWERPC_UNISTD_H_
+#define _ASM_POWERPC_UNISTD_H_
 
 /*
  * This file contains the system call numbers.
@@ -380,4 +380,4 @@
 #endif		/* __ASSEMBLY__ */
 #endif		/* __KERNEL__ */
 
-#endif /* _ASM_PPC_UNISTD_H_ */
+#endif /* _ASM_POWERPC_UNISTD_H_ */
-- 
1.5.0.3
