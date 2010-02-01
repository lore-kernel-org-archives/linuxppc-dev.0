Return-Path: <anton@ozlabs.org>
Date: Mon, 1 Feb 2010 17:33:41 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 4/7] powerpc: Remove whitespace in irq chip name fields
Message-ID: <20100201063341.GW2996@kryten>
References: <20100201063023.GT2996@kryten> <20100201063251.GU2996@kryten>
	<20100201063318.GV2996@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100201063318.GV2996@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Now we use printf style alignment there is no need to manually space
these fields.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-cpumask/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c	2010-02-01 17:28:56.700961947 +1100
+++ linux-cpumask/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c	2010-02-01 17:29:02.987211921 +1100
@@ -79,7 +79,7 @@ cpld_unmask_irq(unsigned int irq)
 }
 
 static struct irq_chip cpld_pic = {
-	.name = " CPLD PIC ",
+	.name = "CPLD PIC",
 	.mask = cpld_mask_irq,
 	.ack = cpld_mask_irq,
 	.unmask = cpld_unmask_irq,
Index: linux-cpumask/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/85xx/socrates_fpga_pic.c	2010-02-01 17:28:56.750962488 +1100
+++ linux-cpumask/arch/powerpc/platforms/85xx/socrates_fpga_pic.c	2010-02-01 17:29:02.997212166 +1100
@@ -232,7 +232,7 @@ static int socrates_fpga_pic_set_type(un
 }
 
 static struct irq_chip socrates_fpga_pic_chip = {
-	.name		= " FPGA-PIC ",
+	.name		= "FPGA-PIC",
 	.ack		= socrates_fpga_pic_ack,
 	.mask           = socrates_fpga_pic_mask,
 	.mask_ack       = socrates_fpga_pic_mask_ack,
Index: linux-cpumask/arch/powerpc/platforms/cell/beat_interrupt.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/cell/beat_interrupt.c	2010-02-01 17:28:56.720961496 +1100
+++ linux-cpumask/arch/powerpc/platforms/cell/beat_interrupt.c	2010-02-01 17:29:02.997212166 +1100
@@ -110,7 +110,7 @@ static void beatic_end_irq(unsigned int 
 }
 
 static struct irq_chip beatic_pic = {
-	.name = " CELL-BEAT ",
+	.name = "CELL-BEAT",
 	.unmask = beatic_unmask_irq,
 	.mask = beatic_mask_irq,
 	.eoi = beatic_end_irq,
Index: linux-cpumask/arch/powerpc/platforms/cell/interrupt.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/cell/interrupt.c	2010-02-01 17:28:56.730973203 +1100
+++ linux-cpumask/arch/powerpc/platforms/cell/interrupt.c	2010-02-01 17:29:02.997212166 +1100
@@ -88,7 +88,7 @@ static void iic_eoi(unsigned int irq)
 }
 
 static struct irq_chip iic_chip = {
-	.name = " CELL-IIC ",
+	.name = "CELL-IIC",
 	.mask = iic_mask,
 	.unmask = iic_unmask,
 	.eoi = iic_eoi,
@@ -133,7 +133,7 @@ static void iic_ioexc_cascade(unsigned i
 
 
 static struct irq_chip iic_ioexc_chip = {
-	.name = " CELL-IOEX",
+	.name = "CELL-IOEX",
 	.mask = iic_mask,
 	.unmask = iic_unmask,
 	.eoi = iic_ioexc_eoi,
Index: linux-cpumask/arch/powerpc/platforms/cell/spider-pic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/cell/spider-pic.c	2010-02-01 17:28:56.720961496 +1100
+++ linux-cpumask/arch/powerpc/platforms/cell/spider-pic.c	2010-02-01 17:29:02.997212166 +1100
@@ -168,7 +168,7 @@ static int spider_set_irq_type(unsigned 
 }
 
 static struct irq_chip spider_pic = {
-	.name = " SPIDER   ",
+	.name = "SPIDER",
 	.unmask = spider_unmask_irq,
 	.mask = spider_mask_irq,
 	.ack = spider_ack_irq,
Index: linux-cpumask/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/iseries/irq.c	2010-02-01 17:28:56.690961770 +1100
+++ linux-cpumask/arch/powerpc/platforms/iseries/irq.c	2010-02-01 17:29:02.997212166 +1100
@@ -273,7 +273,7 @@ static void iseries_end_IRQ(unsigned int
 }
 
 static struct irq_chip iseries_pic = {
-	.name	= "iSeries irq controller",
+	.name		= "iSeries",
 	.startup	= iseries_startup_IRQ,
 	.shutdown	= iseries_shutdown_IRQ,
 	.unmask		= iseries_enable_IRQ,
Index: linux-cpumask/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/powermac/pic.c	2010-02-01 17:28:56.710961247 +1100
+++ linux-cpumask/arch/powerpc/platforms/powermac/pic.c	2010-02-01 17:29:02.997212166 +1100
@@ -195,7 +195,7 @@ static int pmac_retrigger(unsigned int v
 }
 
 static struct irq_chip pmac_pic = {
-	.name		= " PMAC-PIC ",
+	.name		= "PMAC-PIC",
 	.startup	= pmac_startup_irq,
 	.mask		= pmac_mask_irq,
 	.ack		= pmac_ack_irq,
Index: linux-cpumask/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/platforms/pseries/xics.c	2010-02-01 17:29:00.980963118 +1100
+++ linux-cpumask/arch/powerpc/platforms/pseries/xics.c	2010-02-01 17:29:02.997212166 +1100
@@ -428,7 +428,7 @@ static int xics_set_affinity(unsigned in
 }
 
 static struct irq_chip xics_pic_direct = {
-	.name = " XICS     ",
+	.name = "XICS",
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
@@ -437,7 +437,7 @@ static struct irq_chip xics_pic_direct =
 };
 
 static struct irq_chip xics_pic_lpar = {
-	.name = " XICS     ",
+	.name = "XICS",
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
Index: linux-cpumask/arch/powerpc/sysdev/cpm1.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/cpm1.c	2010-02-01 17:28:56.810962592 +1100
+++ linux-cpumask/arch/powerpc/sysdev/cpm1.c	2010-02-01 17:29:02.997212166 +1100
@@ -77,7 +77,7 @@ static void cpm_end_irq(unsigned int irq
 }
 
 static struct irq_chip cpm_pic = {
-	.name = " CPM PIC ",
+	.name = "CPM PIC",
 	.mask = cpm_mask_irq,
 	.unmask = cpm_unmask_irq,
 	.eoi = cpm_end_irq,
Index: linux-cpumask/arch/powerpc/sysdev/cpm2_pic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/cpm2_pic.c	2010-02-01 17:28:56.830961830 +1100
+++ linux-cpumask/arch/powerpc/sysdev/cpm2_pic.c	2010-02-01 17:29:02.997212166 +1100
@@ -198,7 +198,7 @@ err_sense:
 }
 
 static struct irq_chip cpm2_pic = {
-	.name = " CPM2 SIU ",
+	.name = "CPM2 SIU",
 	.mask = cpm2_mask_irq,
 	.unmask = cpm2_unmask_irq,
 	.ack = cpm2_ack,
Index: linux-cpumask/arch/powerpc/sysdev/fsl_msi.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/fsl_msi.c	2010-02-01 17:28:56.790962373 +1100
+++ linux-cpumask/arch/powerpc/sysdev/fsl_msi.c	2010-02-01 17:29:02.997212166 +1100
@@ -47,7 +47,7 @@ static struct irq_chip fsl_msi_chip = {
 	.mask		= mask_msi_irq,
 	.unmask		= unmask_msi_irq,
 	.ack		= fsl_msi_end_irq,
-	.name	= " FSL-MSI  ",
+	.name		= "FSL-MSI",
 };
 
 static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
Index: linux-cpumask/arch/powerpc/sysdev/i8259.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/i8259.c	2010-02-01 17:28:56.800961602 +1100
+++ linux-cpumask/arch/powerpc/sysdev/i8259.c	2010-02-01 17:29:02.997212166 +1100
@@ -135,7 +135,7 @@ static void i8259_unmask_irq(unsigned in
 }
 
 static struct irq_chip i8259_pic = {
-	.name		= " i8259    ",
+	.name		= "i8259",
 	.mask		= i8259_mask_irq,
 	.disable	= i8259_mask_irq,
 	.unmask		= i8259_unmask_irq,
Index: linux-cpumask/arch/powerpc/sysdev/ipic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/ipic.c	2010-02-01 17:28:56.770971720 +1100
+++ linux-cpumask/arch/powerpc/sysdev/ipic.c	2010-02-01 17:29:02.997212166 +1100
@@ -660,7 +660,7 @@ static int ipic_set_irq_type(unsigned in
 
 /* level interrupts and edge interrupts have different ack operations */
 static struct irq_chip ipic_level_irq_chip = {
-	.name		= " IPIC  ",
+	.name		= "IPIC",
 	.unmask		= ipic_unmask_irq,
 	.mask		= ipic_mask_irq,
 	.mask_ack	= ipic_mask_irq,
@@ -668,7 +668,7 @@ static struct irq_chip ipic_level_irq_ch
 };
 
 static struct irq_chip ipic_edge_irq_chip = {
-	.name		= " IPIC  ",
+	.name		= "IPIC",
 	.unmask		= ipic_unmask_irq,
 	.mask		= ipic_mask_irq,
 	.mask_ack	= ipic_mask_irq_and_ack,
Index: linux-cpumask/arch/powerpc/sysdev/mpc8xx_pic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/mpc8xx_pic.c	2010-02-01 17:28:56.780962529 +1100
+++ linux-cpumask/arch/powerpc/sysdev/mpc8xx_pic.c	2010-02-01 17:29:02.997212166 +1100
@@ -94,7 +94,7 @@ static int mpc8xx_set_irq_type(unsigned 
 }
 
 static struct irq_chip mpc8xx_pic = {
-	.name = " MPC8XX SIU ",
+	.name = "MPC8XX SIU",
 	.unmask = mpc8xx_unmask_irq,
 	.mask = mpc8xx_mask_irq,
 	.ack = mpc8xx_ack,
Index: linux-cpumask/arch/powerpc/sysdev/mpic_pasemi_msi.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/mpic_pasemi_msi.c	2010-02-01 17:28:56.820964610 +1100
+++ linux-cpumask/arch/powerpc/sysdev/mpic_pasemi_msi.c	2010-02-01 17:29:02.997212166 +1100
@@ -60,7 +60,7 @@ static struct irq_chip mpic_pasemi_msi_c
 	.eoi		= mpic_end_irq,
 	.set_type	= mpic_set_irq_type,
 	.set_affinity	= mpic_set_affinity,
-	.name		= "PASEMI-MSI ",
+	.name		= "PASEMI-MSI",
 };
 
 static int pasemi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
Index: linux-cpumask/arch/powerpc/sysdev/qe_lib/qe_ic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/qe_lib/qe_ic.c	2010-02-01 17:28:56.780962529 +1100
+++ linux-cpumask/arch/powerpc/sysdev/qe_lib/qe_ic.c	2010-02-01 17:29:02.997212166 +1100
@@ -237,7 +237,7 @@ static void qe_ic_mask_irq(unsigned int 
 }
 
 static struct irq_chip qe_ic_irq_chip = {
-	.name = " QEIC  ",
+	.name = "QEIC",
 	.unmask = qe_ic_unmask_irq,
 	.mask = qe_ic_mask_irq,
 	.mask_ack = qe_ic_mask_irq,
Index: linux-cpumask/arch/powerpc/sysdev/uic.c
===================================================================
--- linux-cpumask.orig/arch/powerpc/sysdev/uic.c	2010-02-01 17:28:56.760964179 +1100
+++ linux-cpumask/arch/powerpc/sysdev/uic.c	2010-02-01 17:29:02.997212166 +1100
@@ -177,7 +177,7 @@ static int uic_set_irq_type(unsigned int
 }
 
 static struct irq_chip uic_irq_chip = {
-	.name		= " UIC  ",
+	.name		= "UIC",
 	.unmask		= uic_unmask_irq,
 	.mask		= uic_mask_irq,
  	.mask_ack	= uic_mask_ack_irq,
