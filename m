Return-Path: <galak@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 07BAF67A8A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 11:29:17 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	j1MKhq0r000059 for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 13:43:52 -0700 (MST)
Received: from linen.sps.mot.com (linen.am.freescale.net [10.82.19.0])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id j1MJhtrx005042
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 13:43:55 -0600 (CST)
Date: Tue, 22 Feb 2005 13:42:36 -0600 (CST)
From: Kumar Gala <galak@freescale.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0502221341030.9300@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PPC32] fix formatting of CDS common platform file
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Here is a patch for post 2.6.11.

Fixes formatting of mpc85xx_cds_common.c

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---
diff -Nru a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c
--- a/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-22 13:35:18 -06:00
+++ b/arch/ppc/platforms/85xx/mpc85xx_cds_common.c	2005-02-22 13:35:18 -06:00
@@ -73,60 +73,60 @@
 /* Internal interrupts are all Level Sensitive, and Positive Polarity */
 
 static u_char mpc85xx_cds_openpic_initsenses[] __initdata = {
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  0: L2 Cache */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  1: ECM */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  2: DDR DRAM */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  3: LBIU */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  4: DMA 0 */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  5: DMA 1 */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  6: DMA 2 */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  7: DMA 3 */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  8: PCI/PCI-X */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal  9: RIO Inbound Port Write Error */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 10: RIO Doorbell Inbound */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 11: RIO Outbound Message */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 12: RIO Inbound Message */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 13: TSEC 0 Transmit */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 14: TSEC 0 Receive */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 15: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 16: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 17: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 18: TSEC 0 Receive/Transmit Error */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 19: TSEC 1 Transmit */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 20: TSEC 1 Receive */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 21: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 22: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 23: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 24: TSEC 1 Receive/Transmit Error */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 25: Fast Ethernet */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 26: DUART */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 27: I2C */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 28: Performance Monitor */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 29: Unused */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 30: CPM */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),        /* Internal 31: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  0: L2 Cache */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  1: ECM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  2: DDR DRAM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  3: LBIU */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  4: DMA 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  5: DMA 1 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  6: DMA 2 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  7: DMA 3 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  8: PCI/PCI-X */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal  9: RIO Inbound Port Write Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 10: RIO Doorbell Inbound */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 11: RIO Outbound Message */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 12: RIO Inbound Message */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 13: TSEC 0 Transmit */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 14: TSEC 0 Receive */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 15: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 16: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 17: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 18: TSEC 0 Receive/Transmit Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 19: TSEC 1 Transmit */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 20: TSEC 1 Receive */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 21: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 22: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 23: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 24: TSEC 1 Receive/Transmit Error */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 25: Fast Ethernet */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 26: DUART */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 27: I2C */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 28: Performance Monitor */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 29: Unused */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 30: CPM */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_POSITIVE),	/* Internal 31: Unused */
 #if defined(CONFIG_PCI)
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 0: PCI1 slot */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 1: PCI1 slot */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 2: PCI1 slot */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 3: PCI1 slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 0: PCI1 slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 1: PCI1 slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 2: PCI1 slot */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 3: PCI1 slot */
 #else
-        0x0,                            /* External  0: */
-        0x0,                            /* External  1: */
-        0x0,                            /* External  2: */
-        0x0,                            /* External  3: */
-#endif
-        0x0,                            /* External  4: */
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 5: PHY */
-        0x0,                            /* External  6: */
-        0x0,                            /* External  7: */
-        0x0,                            /* External  8: */
-        0x0,                            /* External  9: */
-        0x0,                            /* External 10: */
+	0x0,						/* External  0: */
+	0x0,						/* External  1: */
+	0x0,						/* External  2: */
+	0x0,						/* External  3: */
+#endif
+	0x0,						/* External  4: */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External  5: PHY */
+	0x0,						/* External  6: */
+	0x0,						/* External  7: */
+	0x0,						/* External  8: */
+	0x0,						/* External  9: */
+	0x0,						/* External 10: */
 #if defined(CONFIG_85xx_PCI2) && defined(CONFIG_PCI)
-        (IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),      /* External 11: PCI2 slot 0 */
+	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 11: PCI2 slot 0 */
 #else
-        0x0,                            /* External 11: */
+	0x0,						/* External 11: */
 #endif
 };
 
@@ -134,32 +134,32 @@
 int
 mpc85xx_cds_show_cpuinfo(struct seq_file *m)
 {
-        uint pvid, svid, phid1;
-        uint memsize = total_memory;
-        bd_t *binfo = (bd_t *) __res;
-        unsigned int freq;
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
 
-        /* get the core frequency */
-        freq = binfo->bi_intfreq;
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
 
-        pvid = mfspr(PVR);
-        svid = mfspr(SVR);
+	pvid = mfspr(PVR);
+	svid = mfspr(SVR);
 
 	seq_printf(m, "chip\t\t: %s\n", cur_ppc_sys_spec->ppc_sys_name);
-        seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
 	seq_printf(m, "Machine\t\t: CDS (%x)\n", cadmus[CM_VER]);
 	seq_printf(m, "clock\t\t: %dMHz\n", freq / 1000000);
-        seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
-        seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
 
-        /* Display cpu Pll setting */
-        phid1 = mfspr(HID1);
-        seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+	/* Display cpu Pll setting */
+	phid1 = mfspr(HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
 
-        /* Display the amount of memory */
-        seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
 
-        return 0;
+	return 0;
 }
 
 #ifdef CONFIG_CPM2
@@ -186,21 +186,21 @@
 	int i;
 #endif
 
-        /* Determine the Physical Address of the OpenPIC regs */
-        phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
-        OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
-        OpenPIC_InitSenses = mpc85xx_cds_openpic_initsenses;
-        OpenPIC_NumInitSenses = sizeof (mpc85xx_cds_openpic_initsenses);
-
-        /* Skip reserved space and internal sources */
-        openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
-        /* Map PIC IRQs 0-11 */
-        openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
-
-        /* we let openpic interrupts starting from an offset, to
-         * leave space for cascading interrupts underneath.
-         */
-        openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
+	/* Determine the Physical Address of the OpenPIC regs */
+	phys_addr_t OpenPIC_PAddr = binfo->bi_immr_base + MPC85xx_OPENPIC_OFFSET;
+	OpenPIC_Addr = ioremap(OpenPIC_PAddr, MPC85xx_OPENPIC_SIZE);
+	OpenPIC_InitSenses = mpc85xx_cds_openpic_initsenses;
+	OpenPIC_NumInitSenses = sizeof (mpc85xx_cds_openpic_initsenses);
+
+	/* Skip reserved space and internal sources */
+	openpic_set_sources(0, 32, OpenPIC_Addr + 0x10200);
+	/* Map PIC IRQs 0-11 */
+	openpic_set_sources(32, 12, OpenPIC_Addr + 0x10000);
+
+	/* we let openpic interrupts starting from an offset, to
+	 * leave space for cascading interrupts underneath.
+	 */
+	openpic_init(MPC85xx_OPENPIC_IRQ_OFFSET);
 
 #ifdef CONFIG_CPM2
 	/* disable all CPM interupts */
@@ -220,7 +220,7 @@
 	setup_irq(MPC85xx_IRQ_CPM, &cpm2_irqaction);
 #endif
 
-        return;
+	return;
 }
 
 #ifdef CONFIG_PCI
@@ -279,8 +279,8 @@
 	}
 }
 
-#define ARCADIA_HOST_BRIDGE_IDSEL     17
-#define ARCADIA_2ND_BRIDGE_IDSEL     3
+#define ARCADIA_HOST_BRIDGE_IDSEL	17
+#define ARCADIA_2ND_BRIDGE_IDSEL	3
 
 extern int mpc85xx_pci1_last_busno;
 
@@ -290,7 +290,7 @@
 	if (bus == 0 && PCI_SLOT(devfn) == 0)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 #ifdef CONFIG_85xx_PCI2
-	if (mpc85xx_pci1_last_busno) 
+	if (mpc85xx_pci1_last_busno)
 		if (bus == (mpc85xx_pci1_last_busno + 1) && PCI_SLOT(devfn) == 0)
 			return PCIBIOS_DEVICE_NOT_FOUND;
 #endif
@@ -312,14 +312,14 @@
 static void __init
 mpc85xx_cds_setup_arch(void)
 {
-        bd_t *binfo = (bd_t *) __res;
-        unsigned int freq;
+	bd_t *binfo = (bd_t *) __res;
+	unsigned int freq;
 	struct gianfar_platform_data *pdata;
 
-        /* get the core frequency */
-        freq = binfo->bi_intfreq;
+	/* get the core frequency */
+	freq = binfo->bi_intfreq;
 
-        printk("mpc85xx_cds_setup_arch\n");
+	printk("mpc85xx_cds_setup_arch\n");
 
 #ifdef CONFIG_CPM2
 	cpm2_reset();
@@ -329,17 +329,17 @@
 	cds_pci_slot = ((cadmus[CM_CSR] >> 6) & 0x3) + 1;
 	printk("CDS Version = %x in PCI slot %d\n", cadmus[CM_VER], cds_pci_slot);
 
-        /* Set loops_per_jiffy to a half-way reasonable value,
-           for use until calibrate_delay gets called. */
-        loops_per_jiffy = freq / HZ;
+	/* Set loops_per_jiffy to a half-way reasonable value,
+	   for use until calibrate_delay gets called. */
+	loops_per_jiffy = freq / HZ;
 
 #ifdef CONFIG_PCI
-        /* setup PCI host bridges */
-        mpc85xx_setup_hose();
+	/* setup PCI host bridges */
+	mpc85xx_setup_hose();
 #endif
 
 #ifdef CONFIG_SERIAL_8250
-        mpc85xx_early_serial_map();
+	mpc85xx_early_serial_map();
 #endif
 
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
@@ -367,14 +367,14 @@
 
 
 #ifdef CONFIG_BLK_DEV_INITRD
-        if (initrd_start)
-                ROOT_DEV = Root_RAM0;
-        else
+	if (initrd_start)
+		ROOT_DEV = Root_RAM0;
+	else
 #endif
 #ifdef  CONFIG_ROOT_NFS
-                ROOT_DEV = Root_NFS;
+		ROOT_DEV = Root_NFS;
 #else
-                ROOT_DEV = Root_HDA1;
+	ROOT_DEV = Root_HDA1;
 #endif
 }
 
@@ -383,18 +383,18 @@
 platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
               unsigned long r6, unsigned long r7)
 {
-        /* parse_bootinfo must always be called first */
-        parse_bootinfo(find_bootinfo());
+	/* parse_bootinfo must always be called first */
+	parse_bootinfo(find_bootinfo());
 
-        /*
-         * If we were passed in a board information, copy it into the
-         * residual data area.
-         */
-        if (r3) {
-                memcpy((void *) __res, (void *) (r3 + KERNELBASE),
-                       sizeof (bd_t));
+	/*
+	 * If we were passed in a board information, copy it into the
+	 * residual data area.
+	 */
+	if (r3) {
+		memcpy((void *) __res, (void *) (r3 + KERNELBASE),
+				sizeof (bd_t));
 
-        }
+	}
 #ifdef CONFIG_SERIAL_TEXT_DEBUG
 	{
 		bd_t *binfo = (bd_t *) __res;
@@ -402,7 +402,7 @@
 
 		/* Use the last TLB entry to map CCSRBAR to allow access to DUART regs */
 		settlbcam(NUM_TLBCAMS - 1, binfo->bi_immr_base,
-			  binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
+				binfo->bi_immr_base, MPC85xx_CCSRBAR_SIZE, _PAGE_IO, 0);
 
 		memset(&p, 0, sizeof (p));
 		p.iotype = SERIAL_IO_MEM;
@@ -421,49 +421,49 @@
 #endif
 
 #if defined(CONFIG_BLK_DEV_INITRD)
-        /*
-         * If the init RAM disk has been configured in, and there's a valid
-         * starting address for it, set it up.
-         */
-        if (r4) {
-                initrd_start = r4 + KERNELBASE;
-                initrd_end = r5 + KERNELBASE;
-        }
-#endif                          /* CONFIG_BLK_DEV_INITRD */
-
-        /* Copy the kernel command line arguments to a safe place. */
-
-        if (r6) {
-                *(char *) (r7 + KERNELBASE) = 0;
-                strcpy(cmd_line, (char *) (r6 + KERNELBASE));
-        }
+	/*
+	 * If the init RAM disk has been configured in, and there's a valid
+	 * starting address for it, set it up.
+	 */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
+	/* Copy the kernel command line arguments to a safe place. */
+
+	if (r6) {
+		*(char *) (r7 + KERNELBASE) = 0;
+		strcpy(cmd_line, (char *) (r6 + KERNELBASE));
+	}
 
 	identify_ppc_sys_by_id(mfspr(SVR));
 
-        /* setup the PowerPC module struct */
-        ppc_md.setup_arch = mpc85xx_cds_setup_arch;
-        ppc_md.show_cpuinfo = mpc85xx_cds_show_cpuinfo;
-
-        ppc_md.init_IRQ = mpc85xx_cds_init_IRQ;
-        ppc_md.get_irq = openpic_get_irq;
-
-        ppc_md.restart = mpc85xx_restart;
-        ppc_md.power_off = mpc85xx_power_off;
-        ppc_md.halt = mpc85xx_halt;
-
-        ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
-
-        ppc_md.time_init = NULL;
-        ppc_md.set_rtc_time = NULL;
-        ppc_md.get_rtc_time = NULL;
-        ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
+	/* setup the PowerPC module struct */
+	ppc_md.setup_arch = mpc85xx_cds_setup_arch;
+	ppc_md.show_cpuinfo = mpc85xx_cds_show_cpuinfo;
+
+	ppc_md.init_IRQ = mpc85xx_cds_init_IRQ;
+	ppc_md.get_irq = openpic_get_irq;
+
+	ppc_md.restart = mpc85xx_restart;
+	ppc_md.power_off = mpc85xx_power_off;
+	ppc_md.halt = mpc85xx_halt;
+
+	ppc_md.find_end_of_memory = mpc85xx_find_end_of_memory;
+
+	ppc_md.time_init = NULL;
+	ppc_md.set_rtc_time = NULL;
+	ppc_md.get_rtc_time = NULL;
+	ppc_md.calibrate_decr = mpc85xx_calibrate_decr;
 
 #if defined(CONFIG_SERIAL_8250) && defined(CONFIG_SERIAL_TEXT_DEBUG)
-        ppc_md.progress = gen550_progress;
+	ppc_md.progress = gen550_progress;
 #endif /* CONFIG_SERIAL_8250 && CONFIG_SERIAL_TEXT_DEBUG */
 
-        if (ppc_md.progress)
-                ppc_md.progress("mpc85xx_cds_init(): exit", 0);
+	if (ppc_md.progress)
+		ppc_md.progress("mpc85xx_cds_init(): exit", 0);
 
-        return;
+	return;
 }
