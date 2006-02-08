Return-Path: <bgill@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 5C35C68A15
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 14:29:45 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k183bm85022936
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 20:37:49 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id k183g9RE005074
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:42:09 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (cde-tx32-ldt329 [10.82.19.206])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	k183QNAi022379
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:26:23 -0600 (CST)
Received: from cde-tx32-ldt329.sps.mot.com (localhost [127.0.0.1])
	by cde-tx32-ldt329.sps.mot.com (Postfix) with ESMTP id 4B5EDC2DD7
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2006 21:29:42 -0600 (CST)
Received: from localhost (bgill@localhost)
	by cde-tx32-ldt329.sps.mot.com (8.12.11/8.12.11/Submit) with ESMTP id
	k183Tgem004011
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2006 21:29:42 -0600
Date: Tue, 7 Feb 2006 21:29:42 -0600 (CST)
From: Becky Bruce <bgill@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: lindent 85xx platform code
Message-ID: <Pine.LNX.4.61.0602072127510.3872@cde-tx32-ldt329.sps.mot.com>
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

Ran arch/powerpc/platforms/85xx through Lindent

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>

---
commit e2e6d20743741c67e67f533c1b412ffab896b22f
tree 6a9a62b53b666201ca7459d28e61fb48683990a0
parent 45b8d5cae619e9dc58ccf5d880999d7517e82b58
author Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 21:17:31 -0600
committer Becky Bruce <becky.bruce@freescale.com> Tue, 07 Feb 2006 21:17:31 -0600

 arch/powerpc/platforms/85xx/mpc8540_ads.h |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |   46 +++++++++++------------------
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
index 47609c9..b3ec88c 100644
--- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
+++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
@@ -57,4 +57,4 @@
 /* Offset of CPM register space */
 #define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
 
-#endif /* __MACH_MPC8540ADS_H__ */
+#endif				/* __MACH_MPC8540ADS_H__ */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 9e8a91b..ba6798d 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -38,7 +38,6 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
-
 /*
  * Internal interrupts are all Level Sensitive, and Positive Polarity
  *
@@ -47,28 +46,27 @@ unsigned long isa_mem_base = 0;
  */
 static u_char mpc85xx_ads_openpic_initsenses[] __initdata = {
 	MPC85XX_INTERNAL_IRQ_SENSES,
-	0x0,						/* External  0: */
+	0x0,			/* External  0: */
 #if defined(CONFIG_PCI)
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 0 */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 1 */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
 #else
-	0x0,				/* External  1: */
-	0x0,				/* External  2: */
-	0x0,				/* External  3: */
-	0x0,				/* External  4: */
+	0x0,			/* External  1: */
+	0x0,			/* External  2: */
+	0x0,			/* External  3: */
+	0x0,			/* External  4: */
 #endif
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
-	0x0,				/* External  6: */
+	0x0,			/* External  6: */
 	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
-	0x0,				/* External  8: */
-	0x0,				/* External  9: */
-	0x0,				/* External 10: */
-	0x0,				/* External 11: */
+	0x0,			/* External  8: */
+	0x0,			/* External  9: */
+	0x0,			/* External 10: */
+	0x0,			/* External 11: */
 };
 
-
 void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic1;
@@ -78,10 +76,11 @@ void __init mpc85xx_ads_pic_init(void)
 	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
 
 	mpic1 = mpic_alloc(OpenPIC_PAddr,
-			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			mpc85xx_ads_openpic_initsenses,
-			sizeof(mpc85xx_ads_openpic_initsenses), " OpenPIC  ");
+			   MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			   4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
+			   mpc85xx_ads_openpic_initsenses,
+			   sizeof(mpc85xx_ads_openpic_initsenses),
+			   " OpenPIC  ");
 	BUG_ON(mpic1 == NULL);
 	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
 	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
@@ -105,12 +104,10 @@ void __init mpc85xx_ads_pic_init(void)
 	mpic_init(mpic1);
 }
 
-
 /*
  * Setup the architecture
  */
-static void __init
-mpc85xx_ads_setup_arch(void)
+static void __init mpc85xx_ads_setup_arch(void)
 {
 	struct device_node *cpu;
 
@@ -128,7 +125,6 @@ mpc85xx_ads_setup_arch(void)
 			loops_per_jiffy = 50000000 / HZ;
 		of_node_put(cpu);
 	}
-
 #ifdef  CONFIG_ROOT_NFS
 	ROOT_DEV = Root_NFS;
 #else
@@ -136,9 +132,7 @@ mpc85xx_ads_setup_arch(void)
 #endif
 }
 
-
-void
-mpc85xx_ads_show_cpuinfo(struct seq_file *m)
+void mpc85xx_ads_show_cpuinfo(struct seq_file *m)
 {
 	uint pvid, svid, phid1;
 	uint memsize = total_memory;
@@ -159,9 +153,7 @@ mpc85xx_ads_show_cpuinfo(struct seq_file
 	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 }
 
-
-void __init
-platform_init(void)
+void __init platform_init(void)
 {
 	ppc_md.setup_arch = mpc85xx_ads_setup_arch;
 	ppc_md.show_cpuinfo = mpc85xx_ads_show_cpuinfo;
@@ -183,5 +175,3 @@ platform_init(void)
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads platform_init(): exit", 0);
 }
-
-
