Return-Path: <tnt@246tNt.com>
Received: from outmx002.isp.belgacom.be (outmx002.isp.belgacom.be
	[195.238.3.52]) by ozlabs.org (Postfix) with ESMTP id 94CB167A65
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 10:17:46 +1100 (EST)
Received: from outmx002.isp.belgacom.be (localhost [127.0.0.1])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2BNHVk4025297
	for <linuxppc-embedded@ozlabs.org>; Sat, 12 Mar 2005 00:17:31 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from ayanami.246tNt.com (109-209.243.81.adsl.skynet.be
	[81.243.209.109])
	by outmx002.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j2BNHSbf025277
	for <linuxppc-embedded@ozlabs.org>; Sat, 12 Mar 2005 00:17:28 +0100
	(envelope-from <tnt@246tNt.com>)
Received: from [10.0.0.245] (246tNt-laptop.lan.ayanami.246tNt.com [10.0.0.245])
	by ayanami.246tNt.com (Postfix) with ESMTP id D90DE110DFE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Mar 2005 00:15:20 +0100 (CET)
Message-ID: <42322711.5020702@246tNt.com>
Date: Sat, 12 Mar 2005 00:17:37 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Content-Type: multipart/mixed; boundary="------------080202070005090807050200"
Subject: [PATCH] MPC52xx updates (2nd take) : cleanups + PCI
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------080202070005090807050200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ok, second try.

I've included the remarks alread done (the C99 init and the missing 
space for " MPC52xx  ")


They can be found included (correctly this time I hope), and on-line as well

Bitkeeper tree :
bk://tnt.bkbits.net/linux-2.5-mpc52xx-pending

Patch download :
http://www.246tnt.com/mpc52xx/linux-2.5-mpc52xx-pending-20050311-sparsecleanup.diff  
http://www.246tnt.com/mpc52xx/linux-2.5-mpc52xx-pending-20050311-pci.diff


That'll be hopefully enough  ...

    Sylvain


--------------080202070005090807050200
Content-Type: text/x-patch; name="linux-2.5-mpc52xx-pending-20050311-pci.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-2.5-mpc52xx-pending-20050311-pci.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/11 23:49:52+01:00 tnt@246tNt.com 
#   ppc32: Add PCI bus support for Freescale MPC52xx
#   
#   Note that this support has "known" problem but theses
#   are believed to be due to hardware issues.
#   
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
# 
# arch/ppc/syslib/mpc52xx_pci.h
#   2005/03/11 23:49:35+01:00 tnt@246tNt.com +139 -0
# 
# arch/ppc/syslib/mpc52xx_pci.h
#   2005/03/11 23:49:35+01:00 tnt@246tNt.com +0 -0
#   BitKeeper file /home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_pci.h
# 
# arch/ppc/syslib/mpc52xx_pci.c
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +235 -0
# 
# include/linux/pci_ids.h
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +1 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
# 
# include/asm-ppc/mpc52xx.h
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +2 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
# 
# arch/ppc/syslib/mpc52xx_pci.c
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +0 -0
#   BitKeeper file /home/tnt/musicbox/kernel/linux-2.5-mpc52xx-pending/arch/ppc/syslib/mpc52xx_pci.c
# 
# arch/ppc/syslib/Makefile
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +3 -0
#   ppc32: Add PCI bus support for Freescale MPC52xx
# 
# arch/ppc/platforms/lite5200.c
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +33 -3
#   ppc32: Add PCI bus support for Freescale MPC52xx
# 
# arch/ppc/Kconfig
#   2005/03/11 23:49:34+01:00 tnt@246tNt.com +1 -1
#   ppc32: Add PCI bus support for Freescale MPC52xx
# 
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-03-12 00:02:18 +01:00
+++ b/arch/ppc/Kconfig	2005-03-12 00:02:18 +01:00
@@ -1097,7 +1097,7 @@
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || 83xx || 85xx
+	bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_MPC52xx
 	default y if !40x && !CPM2 && !8xx && !APUS && !83xx && !85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-12 00:02:18 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-12 00:02:18 +01:00
@@ -35,6 +35,8 @@
 #include <asm/ocp.h>
 #include <asm/mpc52xx.h>
 
+#include <syslib/mpc52xx_pci.h>
+
 
 extern int powersave_nap;
 
@@ -79,21 +81,39 @@
 	return 0;
 }
 
+#ifdef CONFIG_PCI
+static int
+lite5200_map_irq(struct pci_dev *dev, unsigned char idsel,
+                 unsigned char pin) {
+	return (pin == 1) && (idsel==24) ? MPC52xx_IRQ0 : -1;
+}
+#endif
+
 static void __init
 lite5200_setup_cpu(void)
 {
+	struct mpc52xx_xlb  __iomem *xlb;
 	struct mpc52xx_intr __iomem *intr;
 
 	u32 intr_ctrl;
 
 	/* Map zones */
+	xlb  = ioremap(MPC52xx_XLB,sizeof(struct mpc52xx_xlb));
 	intr = ioremap(MPC52xx_INTR,sizeof(struct mpc52xx_intr));
 
-	if (!intr) {
-		printk("lite5200.c: Error while mapping INTR during lite5200_setup_cpu\n");
+	if (!xlb || !intr) {
+		printk("lite5200.c: Error while mapping XLB/INTR during lite5200_setup_cpu\n");
 		goto unmap_regs;
 	}
 
+	/* Configure the XLB Arbiter */
+	out_be32(&xlb->master_pri_enable, 0xff);
+	out_be32(&xlb->master_priority, 0x11111111);
+
+	/* Enable ram snooping for 1GB window */
+	out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_SNOOP);
+	out_be32(&xlb->snoop_window, MPC52xx_PCI_TARGET_MEM | 0x1d);
+
 	/* IRQ[0-3] setup : IRQ0     - Level Active Low  */
 	/*                  IRQ[1-3] - Level Active High */
 	intr_ctrl = in_be32(&intr->ctrl);
@@ -103,6 +123,7 @@
 
 	/* Unmap reg zone */
 unmap_regs:
+	if (xlb)  iounmap(xlb);
 	if (intr) iounmap(intr);
 }
 
@@ -114,6 +135,11 @@
 
 	/* CPU & Port mux setup */
 	lite5200_setup_cpu();
+
+#ifdef CONFIG_PCI
+	/* PCI Bridge setup */
+	mpc52xx_find_bridges();
+#endif
 }
 
 void __init
@@ -152,7 +178,7 @@
 	/* BAT setup */
 	mpc52xx_set_bat();
 
-	/* No ISA bus AFAIK */
+	/* No ISA bus by default */
 	isa_io_base		= 0;
 	isa_mem_base		= 0;
 
@@ -165,6 +191,10 @@
 	ppc_md.show_percpuinfo	= NULL;
 	ppc_md.init_IRQ		= mpc52xx_init_irq;
 	ppc_md.get_irq		= mpc52xx_get_irq;
+
+#ifdef CONFIG_PCI
+	ppc_md.pci_map_irq	= lite5200_map_irq;
+#endif
 
 	ppc_md.find_end_of_memory = mpc52xx_find_end_of_memory;
 	ppc_md.setup_io_mappings  = mpc52xx_map_io;
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	2005-03-12 00:02:18 +01:00
+++ b/arch/ppc/syslib/Makefile	2005-03-12 00:02:18 +01:00
@@ -106,3 +106,6 @@
 endif
 obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
 obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o
+ifeq ($(CONFIG_PPC_MPC52xx),y)
+obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
+endif
diff -Nru a/arch/ppc/syslib/mpc52xx_pci.c b/arch/ppc/syslib/mpc52xx_pci.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_pci.c	2005-03-12 00:02:18 +01:00
@@ -0,0 +1,235 @@
+/*
+ * arch/ppc/syslib/mpc52xx_pci.c
+ *
+ * PCI code for the Freescale MPC52xx embedded CPU.
+ *
+ * 
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ * 
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+
+#include <asm/pci.h>
+
+#include <asm/mpc52xx.h>
+#include "mpc52xx_pci.h"
+
+#include <asm/delay.h>
+
+
+static int
+mpc52xx_pci_read_config(struct pci_bus *bus, unsigned int devfn,
+                        int offset, int len, u32 *val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	u32 value;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	out_be32(hose->cfg_addr,
+		(1 << 31) |
+		((bus->number - hose->bus_offset) << 16) |
+		(devfn << 8) |
+		(offset & 0xfc));
+
+	value = in_le32(hose->cfg_data);
+
+	if (len != 4) {
+		value >>= ((offset & 0x3) << 3);
+		value &= 0xffffffff >> (32 - (len << 3));
+	}
+
+	*val = value;
+
+	out_be32(hose->cfg_addr, 0);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int
+mpc52xx_pci_write_config(struct pci_bus *bus, unsigned int devfn,
+                         int offset, int len, u32 val)
+{
+	struct pci_controller *hose = bus->sysdata;
+	u32 value, mask;
+
+	if (ppc_md.pci_exclude_device)
+		if (ppc_md.pci_exclude_device(bus->number, devfn))
+			return PCIBIOS_DEVICE_NOT_FOUND;
+
+	out_be32(hose->cfg_addr,
+		(1 << 31) |
+		((bus->number - hose->bus_offset) << 16) |
+		(devfn << 8) |
+		(offset & 0xfc));
+
+	if (len != 4) {
+		value = in_le32(hose->cfg_data);
+
+		offset = (offset & 0x3) << 3;
+		mask = (0xffffffff >> (32 - (len << 3)));
+		mask <<= offset;
+
+		value &= ~mask;
+		val = value | ((val << offset) & mask);
+	}
+
+	out_le32(hose->cfg_data, val);
+
+	out_be32(hose->cfg_addr, 0);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static struct pci_ops mpc52xx_pci_ops = {
+	.read  = mpc52xx_pci_read_config,
+	.write = mpc52xx_pci_write_config
+};
+
+
+static void __init
+mpc52xx_pci_setup(struct mpc52xx_pci __iomem *pci_regs)
+{
+
+	/* Setup control regs */
+		/* Nothing to do afaik */
+
+	/* Setup windows */
+	out_be32(&pci_regs->iw0btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+		MPC52xx_PCI_MEM_START + MPC52xx_PCI_MEM_OFFSET,
+		MPC52xx_PCI_MEM_START,
+		MPC52xx_PCI_MEM_SIZE ));
+
+	out_be32(&pci_regs->iw1btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+		MPC52xx_PCI_MMIO_START + MPC52xx_PCI_MEM_OFFSET,
+		MPC52xx_PCI_MMIO_START,
+		MPC52xx_PCI_MMIO_SIZE ));
+
+	out_be32(&pci_regs->iw2btar, MPC52xx_PCI_IWBTAR_TRANSLATION(
+		MPC52xx_PCI_IO_BASE,
+		MPC52xx_PCI_IO_START,
+		MPC52xx_PCI_IO_SIZE ));
+
+	out_be32(&pci_regs->iwcr, MPC52xx_PCI_IWCR_PACK(
+		( MPC52xx_PCI_IWCR_ENABLE |		/* iw0btar */
+		  MPC52xx_PCI_IWCR_READ_MULTI |
+		  MPC52xx_PCI_IWCR_MEM ),
+		( MPC52xx_PCI_IWCR_ENABLE |		/* iw1btar */
+		  MPC52xx_PCI_IWCR_READ |
+		  MPC52xx_PCI_IWCR_MEM ),
+		( MPC52xx_PCI_IWCR_ENABLE |		/* iw2btar */
+		  MPC52xx_PCI_IWCR_IO )
+	));
+
+
+	out_be32(&pci_regs->tbatr0,
+		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_IO );
+	out_be32(&pci_regs->tbatr1, 
+		MPC52xx_PCI_TBATR_ENABLE | MPC52xx_PCI_TARGET_MEM );
+
+	out_be32(&pci_regs->tcr, MPC52xx_PCI_TCR_LD);
+
+	/* Reset the exteral bus ( internal PCI controller is NOT resetted ) */
+	/* Not necessary and can be a bad thing if for example the bootloader
+	   is displaying a splash screen or ... Just left here for
+	   documentation purpose if anyone need it */
+#if 0
+	u32 tmp;
+	tmp = in_be32(&pci_regs->gscr);
+	out_be32(&pci_regs->gscr, tmp | MPC52xx_PCI_GSCR_PR);
+	udelay(50);
+	out_be32(&pci_regs->gscr, tmp);
+#endif
+}
+
+static void __init
+mpc52xx_pci_fixup_resources(struct pci_dev *dev)
+{
+	int i;
+
+	/* We don't rely on boot loader for PCI and resets all
+	   devices */
+	for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {
+		struct resource *res = &dev->resource[i];
+		if (res->end > res->start) {	/* Only valid resources */
+			res->end -= res->start;
+			res->start = 0;
+			res->flags |= IORESOURCE_UNSET;
+		}
+	}
+
+	/* The PCI Host bridge of MPC52xx has a prefetch memory resource
+	   fixed to 1Gb. Doesn't fit in the resource system so we remove it */
+	if ( (dev->vendor == PCI_VENDOR_ID_MOTOROLA) &&
+	     (dev->device == PCI_DEVICE_ID_MOTOROLA_MPC5200) ) {
+		struct resource *res = &dev->resource[1];
+		res->start = res->end = res->flags = 0;
+	}
+}
+
+void __init
+mpc52xx_find_bridges(void)
+{
+	struct mpc52xx_pci __iomem *pci_regs;
+	struct pci_controller *hose;
+
+	pci_assign_all_busses = 1;
+
+	pci_regs = ioremap(MPC52xx_PCI, sizeof(struct mpc52xx_pci));
+	if (!pci_regs)
+		return;
+
+	hose = pcibios_alloc_controller();
+	if (!hose) {
+		iounmap(pci_regs);
+		return;
+	}
+
+	ppc_md.pci_swizzle = common_swizzle;
+	ppc_md.pcibios_fixup_resources = mpc52xx_pci_fixup_resources;
+
+	hose->first_busno = 0;
+	hose->last_busno = 0xff;
+	hose->bus_offset = 0;
+	hose->ops = &mpc52xx_pci_ops;
+
+	mpc52xx_pci_setup(pci_regs);
+
+	hose->pci_mem_offset = MPC52xx_PCI_MEM_OFFSET;
+
+	isa_io_base =
+		(unsigned long) ioremap(MPC52xx_PCI_IO_BASE,
+					MPC52xx_PCI_IO_SIZE);
+	hose->io_base_virt = (void *) isa_io_base;
+
+	hose->cfg_addr = &pci_regs->car;
+	hose->cfg_data = (void __iomem *) isa_io_base;
+
+	/* Setup resources */
+	pci_init_resource(&hose->mem_resources[0],
+			MPC52xx_PCI_MEM_START,
+			MPC52xx_PCI_MEM_STOP,
+			IORESOURCE_MEM|IORESOURCE_PREFETCH,
+			"PCI prefetchable memory");
+
+	pci_init_resource(&hose->mem_resources[1],
+			MPC52xx_PCI_MMIO_START,
+			MPC52xx_PCI_MMIO_STOP,
+			IORESOURCE_MEM,
+			"PCI memory");
+
+	pci_init_resource(&hose->io_resource,
+			MPC52xx_PCI_IO_START,
+			MPC52xx_PCI_IO_STOP,
+			IORESOURCE_IO,
+			"PCI I/O");
+
+}
diff -Nru a/arch/ppc/syslib/mpc52xx_pci.h b/arch/ppc/syslib/mpc52xx_pci.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/syslib/mpc52xx_pci.h	2005-03-12 00:02:18 +01:00
@@ -0,0 +1,139 @@
+/*
+ * arch/ppc/syslib/mpc52xx_pci.h
+ * 
+ * PCI Include file the Freescale MPC52xx embedded cpu chips
+ *
+ *
+ * Maintainer : Sylvain Munaut <tnt@246tNt.com>
+ *
+ * Inspired from code written by Dale Farnsworth <dfarnsworth@mvista.com> 
+ * for the 2.4 kernel.
+ *
+ * Copyright (C) 2004 Sylvain Munaut <tnt@246tNt.com>
+ * Copyright (C) 2003 MontaVista, Software, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __SYSLIB_MPC52xx_PCI_H__
+#define __SYSLIB_MPC52xx_PCI_H__
+
+/* ======================================================================== */
+/* PCI windows config                                                       */
+/* ======================================================================== */
+
+/*
+ * Master windows : MPC52xx -> PCI
+ * 
+ *  0x80000000 -> 0x9FFFFFFF       PCI Mem prefetchable          IW0BTAR
+ *  0xA0000000 -> 0xAFFFFFFF       PCI Mem                       IW1BTAR
+ *  0xB0000000 -> 0xB0FFFFFF       PCI IO                        IW2BTAR
+ *
+ * Slave windows  : PCI -> MPC52xx
+ *
+ *  0xF0000000 -> 0xF003FFFF       MPC52xx MBAR                  TBATR0
+ *  0x00000000 -> 0x3FFFFFFF       MPC52xx local memory          TBATR1
+ */
+
+#define MPC52xx_PCI_MEM_OFFSET 	0x00000000	/* Offset for MEM MMIO */
+
+#define MPC52xx_PCI_MEM_START	0x80000000
+#define MPC52xx_PCI_MEM_SIZE	0x20000000
+#define MPC52xx_PCI_MEM_STOP	(MPC52xx_PCI_MEM_START+MPC52xx_PCI_MEM_SIZE-1)
+
+#define MPC52xx_PCI_MMIO_START	0xa0000000
+#define MPC52xx_PCI_MMIO_SIZE	0x10000000
+#define MPC52xx_PCI_MMIO_STOP	(MPC52xx_PCI_MMIO_START+MPC52xx_PCI_MMIO_SIZE-1)
+
+#define MPC52xx_PCI_IO_BASE	0xb0000000
+
+#define MPC52xx_PCI_IO_START	0x00000000
+#define MPC52xx_PCI_IO_SIZE	0x01000000
+#define MPC52xx_PCI_IO_STOP	(MPC52xx_PCI_IO_START+MPC52xx_PCI_IO_SIZE-1)
+
+
+#define MPC52xx_PCI_TARGET_IO	MPC52xx_MBAR
+#define MPC52xx_PCI_TARGET_MEM	0x00000000
+
+
+/* ======================================================================== */
+/* Structures mapping & Defines for PCI Unit                                */
+/* ======================================================================== */
+
+#define MPC52xx_PCI_GSCR_BM		0x40000000
+#define MPC52xx_PCI_GSCR_PE		0x20000000
+#define MPC52xx_PCI_GSCR_SE		0x10000000
+#define MPC52xx_PCI_GSCR_XLB2PCI_MASK	0x07000000
+#define MPC52xx_PCI_GSCR_XLB2PCI_SHIFT	24
+#define MPC52xx_PCI_GSCR_IPG2PCI_MASK	0x00070000
+#define MPC52xx_PCI_GSCR_IPG2PCI_SHIFT	16
+#define MPC52xx_PCI_GSCR_BME		0x00004000
+#define MPC52xx_PCI_GSCR_PEE		0x00002000
+#define MPC52xx_PCI_GSCR_SEE		0x00001000
+#define MPC52xx_PCI_GSCR_PR		0x00000001
+
+
+#define MPC52xx_PCI_IWBTAR_TRANSLATION(proc_ad,pci_ad,size)	  \
+		( ( (proc_ad) & 0xff000000 )			| \
+		  ( (((size) - 1) >> 8) & 0x00ff0000 )		| \
+		  ( ((pci_ad) >> 16) & 0x0000ff00 ) )
+		  
+#define MPC52xx_PCI_IWCR_PACK(win0,win1,win2)	(((win0) << 24) | \
+						 ((win1) << 16) | \
+						 ((win2) <<  8))
+
+#define MPC52xx_PCI_IWCR_DISABLE	0x0
+#define MPC52xx_PCI_IWCR_ENABLE		0x1
+#define MPC52xx_PCI_IWCR_READ		0x0
+#define MPC52xx_PCI_IWCR_READ_LINE	0x2
+#define MPC52xx_PCI_IWCR_READ_MULTI	0x4
+#define MPC52xx_PCI_IWCR_MEM		0x0
+#define MPC52xx_PCI_IWCR_IO		0x8
+
+#define MPC52xx_PCI_TCR_P		0x01000000
+#define MPC52xx_PCI_TCR_LD		0x00010000
+
+#define MPC52xx_PCI_TBATR_DISABLE	0x0
+#define MPC52xx_PCI_TBATR_ENABLE	0x1
+
+
+#ifndef __ASSEMBLY__
+
+struct mpc52xx_pci {
+	u32	idr;		/* PCI + 0x00 */
+	u32	scr;		/* PCI + 0x04 */
+	u32	ccrir;		/* PCI + 0x08 */
+	u32	cr1;		/* PCI + 0x0C */
+	u32	bar0;		/* PCI + 0x10 */
+	u32	bar1;		/* PCI + 0x14 */
+	u8	reserved1[16];	/* PCI + 0x18 */
+	u32	ccpr;		/* PCI + 0x28 */
+	u32	sid;		/* PCI + 0x2C */
+	u32	erbar;		/* PCI + 0x30 */
+	u32	cpr;		/* PCI + 0x34 */
+	u8	reserved2[4];	/* PCI + 0x38 */
+	u32	cr2;		/* PCI + 0x3C */
+	u8	reserved3[32];	/* PCI + 0x40 */
+	u32	gscr;		/* PCI + 0x60 */
+	u32	tbatr0;		/* PCI + 0x64 */
+	u32	tbatr1;		/* PCI + 0x68 */
+	u32	tcr;		/* PCI + 0x6C */
+	u32	iw0btar;	/* PCI + 0x70 */
+	u32	iw1btar;	/* PCI + 0x74 */
+	u32	iw2btar;	/* PCI + 0x78 */
+	u8	reserved4[4];	/* PCI + 0x7C */
+	u32	iwcr;		/* PCI + 0x80 */
+	u32	icr;		/* PCI + 0x84 */
+	u32	isr;		/* PCI + 0x88 */
+	u32	arb;		/* PCI + 0x8C */
+	u8	reserved5[104];	/* PCI + 0x90 */
+	u32	car;		/* PCI + 0xF8 */
+	u8	reserved6[4];	/* PCI + 0xFC */
+};
+
+#endif  /* __ASSEMBLY__ */
+
+
+#endif  /* __SYSLIB_MPC52xx_PCI_H__ */
diff -Nru a/include/asm-ppc/mpc52xx.h b/include/asm-ppc/mpc52xx.h
--- a/include/asm-ppc/mpc52xx.h	2005-03-12 00:02:18 +01:00
+++ b/include/asm-ppc/mpc52xx.h	2005-03-12 00:02:18 +01:00
@@ -393,6 +393,8 @@
 extern void mpc52xx_calibrate_decr(void);
 extern void mpc52xx_add_board_devices(struct ocp_def board_ocp[]);
 
+extern void mpc52xx_find_bridges(void);
+
 #endif /* __ASSEMBLY__ */
 
 
diff -Nru a/include/linux/pci_ids.h b/include/linux/pci_ids.h
--- a/include/linux/pci_ids.h	2005-03-12 00:02:18 +01:00
+++ b/include/linux/pci_ids.h	2005-03-12 00:02:18 +01:00
@@ -807,6 +807,7 @@
 #define PCI_DEVICE_ID_MOTOROLA_HAWK	0x4803
 #define PCI_DEVICE_ID_MOTOROLA_CPX8216	0x4806
 #define PCI_DEVICE_ID_MOTOROLA_HARRIER	0x480b
+#define PCI_DEVICE_ID_MOTOROLA_MPC5200	0x5803
 
 #define PCI_VENDOR_ID_PROMISE		0x105a
 #define PCI_DEVICE_ID_PROMISE_20265	0x0d30


--------------080202070005090807050200
Content-Type: text/x-patch;
	name="linux-2.5-mpc52xx-pending-20050311-sparsecleanup.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-2.5-mpc52xx-pending-20050311-sparsecleanup.diff"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/11 23:47:54+01:00 tnt@246tNt.com 
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
#   
#   Theses clean-ups are mainly missing __iomem qualifier,
#   unnecessary (and 'wrong') casting, missing static.
#   
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
# 
# drivers/serial/mpc52xx_uart.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +6 -6
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
# arch/ppc/syslib/mpc52xx_setup.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +13 -13
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
# arch/ppc/syslib/mpc52xx_pic.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +9 -14
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
# arch/ppc/platforms/mpc5200.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +1 -1
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
# arch/ppc/platforms/lite5200.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +3 -4
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
# arch/ppc/boot/simple/mpc52xx_tty.c
#   2005/03/11 23:46:11+01:00 tnt@246tNt.com +7 -6
#   ppc32: sparse clean ups for the Freescale MPC52xx related code
# 
diff -Nru a/arch/ppc/boot/simple/mpc52xx_tty.c b/arch/ppc/boot/simple/mpc52xx_tty.c
--- a/arch/ppc/boot/simple/mpc52xx_tty.c	2005-03-12 00:01:44 +01:00
+++ b/arch/ppc/boot/simple/mpc52xx_tty.c	2005-03-12 00:01:44 +01:00
@@ -33,18 +33,19 @@
 #error "MPC52xx_PF_CONSOLE_PORT not defined"
 #endif
 
-static struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
+static struct mpc52xx_psc __iomem *psc =
+	(struct mpc52xx_psc __iomem *) MPC52xx_CONSOLE;
 
 /* The decrementer counts at the system bus clock frequency
  * divided by four.  The most accurate time base is connected to the
  * rtc.  We read the decrementer change during one rtc tick (one second)
  * and multiply by 4 to get the system bus clock frequency.
  */
-int
+static int
 mpc52xx_ipbfreq(void)
 {
-	struct mpc52xx_rtc *rtc = (struct mpc52xx_rtc*)MPC52xx_RTC;
-	struct mpc52xx_cdm *cdm = (struct mpc52xx_cdm*)MPC52xx_CDM;
+	struct mpc52xx_rtc __iomem *rtc = (struct mpc52xx_rtc __iomem *)MPC52xx_RTC;
+	struct mpc52xx_cdm __iomem *cdm = (struct mpc52xx_cdm __iomem *)MPC52xx_CDM;
 	int current_time, previous_time;
 	int tbl_start, tbl_end;
 	int xlbfreq, ipbfreq;
@@ -67,7 +68,7 @@
 unsigned long
 serial_init(int ignored, void *ignored2)
 {
-	struct mpc52xx_gpio *gpio = (struct mpc52xx_gpio *)MPC52xx_GPIO;
+	struct mpc52xx_gpio __iomem *gpio = (struct mpc52xx_gpio __iomem *)MPC52xx_GPIO;
 	int divisor;
 	int mode1;
 	int mode2;
@@ -117,7 +118,7 @@
 void
 serial_putc(void *ignored, const char c)
 {
-	serial_init(0, 0);
+	serial_init(0, NULL);
 
 	while (!(in_be16(&psc->mpc52xx_psc_status) & MPC52xx_PSC_SR_TXEMP)) ;
 	out_8(&psc->mpc52xx_psc_buffer_8, c);
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c	2005-03-12 00:01:44 +01:00
+++ b/arch/ppc/platforms/lite5200.c	2005-03-12 00:01:44 +01:00
@@ -53,7 +53,7 @@
  * driver ( eg drivers/serial/mpc52xx_uart.c for the PSC in uart mode )
  */
 
-struct ocp_def board_ocp[] = {
+static struct ocp_def board_ocp[] = {
 	{
 		.vendor		= OCP_VENDOR_FREESCALE,
 		.function	= OCP_FUNC_PSC_UART,
@@ -82,13 +82,12 @@
 static void __init
 lite5200_setup_cpu(void)
 {
-	struct mpc52xx_intr *intr;
+	struct mpc52xx_intr __iomem *intr;
 
 	u32 intr_ctrl;
 
 	/* Map zones */
-	intr = (struct mpc52xx_intr *)
-		ioremap(MPC52xx_INTR,sizeof(struct mpc52xx_intr));
+	intr = ioremap(MPC52xx_INTR,sizeof(struct mpc52xx_intr));
 
 	if (!intr) {
 		printk("lite5200.c: Error while mapping INTR during lite5200_setup_cpu\n");
diff -Nru a/arch/ppc/platforms/mpc5200.c b/arch/ppc/platforms/mpc5200.c
--- a/arch/ppc/platforms/mpc5200.c	2005-03-12 00:01:44 +01:00
+++ b/arch/ppc/platforms/mpc5200.c	2005-03-12 00:01:44 +01:00
@@ -17,7 +17,7 @@
 #include <asm/mpc52xx.h>
 
 
-struct ocp_fs_i2c_data mpc5200_i2c_def = {
+static struct ocp_fs_i2c_data mpc5200_i2c_def = {
         .flags  = FS_I2C_CLOCK_5200,
 };
 
diff -Nru a/arch/ppc/syslib/mpc52xx_pic.c b/arch/ppc/syslib/mpc52xx_pic.c
--- a/arch/ppc/syslib/mpc52xx_pic.c	2005-03-12 00:01:44 +01:00
+++ b/arch/ppc/syslib/mpc52xx_pic.c	2005-03-12 00:01:44 +01:00
@@ -33,8 +33,8 @@
 #include <asm/mpc52xx.h>
 
 
-static struct mpc52xx_intr *intr;
-static struct mpc52xx_sdma *sdma;
+static struct mpc52xx_intr __iomem *intr;
+static struct mpc52xx_sdma __iomem *sdma;
 
 static void
 mpc52xx_ic_disable(unsigned int irq)
@@ -166,14 +166,11 @@
 }
 
 static struct hw_interrupt_type mpc52xx_ic = {
-	"MPC52xx",
-	NULL,				/* startup(irq) */
-	NULL,				/* shutdown(irq) */
-	mpc52xx_ic_enable,		/* enable(irq) */
-	mpc52xx_ic_disable,		/* disable(irq) */
-	mpc52xx_ic_disable_and_ack,	/* disable_and_ack(irq) */
-	mpc52xx_ic_end,			/* end(irq) */
-	0				/* set_affinity(irq, cpumask) SMP. */
+	.typename	= " MPC52xx  ",
+	.enable		= mpc52xx_ic_enable,
+	.disable	= mpc52xx_ic_disable,
+	.ack		= mpc52xx_ic_disable_and_ack,
+	.end		= mpc52xx_ic_end,
 };
 
 void __init
@@ -183,10 +180,8 @@
 	u32 intr_ctrl;
 
 	/* Remap the necessary zones */
-	intr = (struct mpc52xx_intr *)
-		ioremap(MPC52xx_INTR, sizeof(struct mpc52xx_intr));
-	sdma = (struct mpc52xx_sdma *)
-		ioremap(MPC52xx_SDMA, sizeof(struct mpc52xx_sdma));
+	intr = ioremap(MPC52xx_INTR, sizeof(struct mpc52xx_intr));
+	sdma = ioremap(MPC52xx_SDMA, sizeof(struct mpc52xx_sdma));
 
 	if ((intr==NULL) || (sdma==NULL))
 		panic("Can't ioremap PIC/SDMA register for init_irq !");
diff -Nru a/arch/ppc/syslib/mpc52xx_setup.c b/arch/ppc/syslib/mpc52xx_setup.c
--- a/arch/ppc/syslib/mpc52xx_setup.c	2005-03-12 00:01:44 +01:00
+++ b/arch/ppc/syslib/mpc52xx_setup.c	2005-03-12 00:01:44 +01:00
@@ -39,7 +39,8 @@
 void
 mpc52xx_restart(char *cmd)
 {
-	struct mpc52xx_gpt* gpt0 = (struct mpc52xx_gpt*) MPC52xx_GPTx(0);
+	struct mpc52xx_gpt __iomem *gpt0 =
+		(struct mpc52xx_gpt __iomem *) MPC52xx_GPTx(0);
 
 	local_irq_disable();
 
@@ -102,7 +103,7 @@
 #endif
 
 static void
-mpc52xx_psc_putc(struct mpc52xx_psc * psc, unsigned char c)
+mpc52xx_psc_putc(struct mpc52xx_psc __iomem *psc, unsigned char c)
 {
 	while (!(in_be16(&psc->mpc52xx_psc_status) &
 	         MPC52xx_PSC_SR_TXRDY));
@@ -112,8 +113,9 @@
 void
 mpc52xx_progress(char *s, unsigned short hex)
 {
-	struct mpc52xx_psc *psc = (struct mpc52xx_psc *)MPC52xx_CONSOLE;
 	char c;
+	struct mpc52xx_psc __iomem *psc =
+		(struct mpc52xx_psc __iomem *)MPC52xx_CONSOLE;
 
 	while ((c = *s++) != 0) {
 		if (c == '\n')
@@ -138,11 +140,11 @@
 	 * else get size from sdram config registers
 	 */
 	if (ramsize == 0) {
-		struct mpc52xx_mmap_ctl *mmap_ctl;
+		struct mpc52xx_mmap_ctl __iomem *mmap_ctl;
 		u32 sdram_config_0, sdram_config_1;
 
 		/* Temp BAT2 mapping active when this is called ! */
-		mmap_ctl = (struct mpc52xx_mmap_ctl*) MPC52xx_MMAP_CTL;
+		mmap_ctl = (struct mpc52xx_mmap_ctl __iomem *) MPC52xx_MMAP_CTL;
 
 		sdram_config_0 = in_be32(&mmap_ctl->sdram0);
 		sdram_config_1 = in_be32(&mmap_ctl->sdram1);
@@ -169,13 +171,11 @@
 	/* if bootloader didn't pass bus frequencies, calculate them */
 	if (xlbfreq == 0) {
 		/* Get RTC & Clock manager modules */
-		struct mpc52xx_rtc *rtc;
-		struct mpc52xx_cdm *cdm;
+		struct mpc52xx_rtc __iomem *rtc;
+		struct mpc52xx_cdm __iomem *cdm;
 
-		rtc = (struct mpc52xx_rtc*)
-			ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
-		cdm = (struct mpc52xx_cdm*)
-			ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));
+		rtc = ioremap(MPC52xx_RTC, sizeof(struct mpc52xx_rtc));
+		cdm = ioremap(MPC52xx_CDM, sizeof(struct mpc52xx_cdm));
 
 		if ((rtc==NULL) || (cdm==NULL))
 			panic("Can't ioremap RTC/CDM while computing bus freq");
@@ -212,8 +212,8 @@
 		__res.bi_pcifreq = pcifreq;
 
 		/* Release mapping */
-		iounmap((void*)rtc);
-		iounmap((void*)cdm);
+		iounmap(rtc);
+		iounmap(cdm);
 	}
 
 	divisor = 4;
diff -Nru a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
--- a/drivers/serial/mpc52xx_uart.c	2005-03-12 00:01:44 +01:00
+++ b/drivers/serial/mpc52xx_uart.c	2005-03-12 00:01:44 +01:00
@@ -86,7 +86,7 @@
 	 *        the console_init
 	 */
 
-#define PSC(port) ((struct mpc52xx_psc *)((port)->membase))
+#define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
 
 
 /* Forward declaration of the interruption handling routine */
@@ -190,7 +190,7 @@
 static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
-	struct mpc52xx_psc *psc = PSC(port);
+	struct mpc52xx_psc __iomem *psc = PSC(port);
 
 	/* Reset/activate the port, clear and enable interrupts */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -217,7 +217,7 @@
 static void
 mpc52xx_uart_shutdown(struct uart_port *port)
 {
-	struct mpc52xx_psc *psc = PSC(port);
+	struct mpc52xx_psc __iomem *psc = PSC(port);
 	
 	/* Shut down the port, interrupt and all */
 	out_8(&psc->command,MPC52xx_PSC_RST_RX);
@@ -231,7 +231,7 @@
 mpc52xx_uart_set_termios(struct uart_port *port, struct termios *new,
                          struct termios *old)
 {
-	struct mpc52xx_psc *psc = PSC(port);
+	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned long flags;
 	unsigned char mr1, mr2;
 	unsigned short ctr;
@@ -562,7 +562,7 @@
 mpc52xx_console_get_options(struct uart_port *port,
                             int *baud, int *parity, int *bits, int *flow)
 {
-	struct mpc52xx_psc *psc = PSC(port);
+	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned char mr1;
 
 	/* Read the mode registers */
@@ -592,7 +592,7 @@
 mpc52xx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct uart_port *port = &mpc52xx_uart_ports[co->index];
-	struct mpc52xx_psc *psc = PSC(port);
+	struct mpc52xx_psc __iomem *psc = PSC(port);
 	unsigned int i, j;
 	
 	/* Disable interrupts */


--------------080202070005090807050200--
