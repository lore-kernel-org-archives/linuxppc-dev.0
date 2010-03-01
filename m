Return-Path: <martyn.welch@ge.com>
Received: from exprod5og114.obsmtp.com (exprod5og114.obsmtp.com [64.18.0.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00131B7D1F
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Mar 2010 01:39:02 +1100 (EST)
From: Martyn Welch <martyn.welch@ge.com>
Subject: [PATCH] powerpc: Renaming following split of GE Fanuc joint venture
To: kumar.gala@freescale.com
Date: Mon, 01 Mar 2010 14:41:59 +0000
Message-ID: <20100301144159.23431.18196.stgit@ES-J7S4D2J.amer.consind.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch renames GE Fanuc boards following the split-up of the GE Fanuc joint venture. These boards are now made by GE Intelligent platorms.

Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
---

 arch/powerpc/boot/dts/gef_ppc9a.dts      |    4 ++--
 arch/powerpc/boot/dts/gef_sbc310.dts     |    4 ++--
 arch/powerpc/boot/dts/gef_sbc610.dts     |    4 ++--
 arch/powerpc/platforms/86xx/Kconfig      |   12 ++++++------
 arch/powerpc/platforms/86xx/gef_gpio.c   |   10 +++++-----
 arch/powerpc/platforms/86xx/gef_pic.c    |    6 +++---
 arch/powerpc/platforms/86xx/gef_ppc9a.c  |   12 ++++++------
 arch/powerpc/platforms/86xx/gef_sbc310.c |   12 ++++++------
 arch/powerpc/platforms/86xx/gef_sbc610.c |   12 ++++++------
 9 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index 977f260..83f4b79 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -1,7 +1,7 @@
 /*
- * GE Fanuc PPC9A Device Tree Source
+ * GE PPC9A Device Tree Source
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 8e4efff..fc3a331 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -1,7 +1,7 @@
 /*
- * GE Fanuc SBC310 Device Tree Source
+ * GE SBC310 Device Tree Source
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index bb70600..c0671cc 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -1,7 +1,7 @@
 /*
- * GE Fanuc SBC610 Device Tree Source
+ * GE SBC610 Device Tree Source
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 2bbfd53..fbe9f36 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -33,32 +33,32 @@ config MPC8610_HPCD
 	  This option enables support for the MPC8610 HPCD board.
 
 config GEF_PPC9A
-	bool "GE Fanuc PPC9A"
+	bool "GE PPC9A"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
-	  This option enables support for GE Fanuc's PPC9A.
+	  This option enables support for the GE PPC9A.
 
 config GEF_SBC310
-	bool "GE Fanuc SBC310"
+	bool "GE SBC310"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	help
-	  This option enables support for GE Fanuc's SBC310.
+	  This option enables support for the GE SBC310.
 
 config GEF_SBC610
-	bool "GE Fanuc SBC610"
+	bool "GE SBC610"
 	select DEFAULT_UIMAGE
 	select MMIO_NVRAM
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select HAS_RAPIDIO
 	help
-	  This option enables support for GE Fanuc's SBC610.
+	  This option enables support for the GE SBC610.
 
 endif
 
diff --git a/arch/powerpc/platforms/86xx/gef_gpio.c b/arch/powerpc/platforms/86xx/gef_gpio.c
index b2ea887..11f7b2b 100644
--- a/arch/powerpc/platforms/86xx/gef_gpio.c
+++ b/arch/powerpc/platforms/86xx/gef_gpio.c
@@ -1,9 +1,9 @@
 /*
- * Driver for GE Fanuc's FPGA based GPIO pins
+ * Driver for GE FPGA based GPIO
  *
- * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ * Author: Martyn Welch <martyn.welch@ge.com>
  *
- * 2008 (c) GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * 2008 (c) GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
@@ -164,6 +164,6 @@ static int __init gef_gpio_init(void)
 };
 arch_initcall(gef_gpio_init);
 
-MODULE_DESCRIPTION("GE Fanuc I/O FPGA GPIO driver");
-MODULE_AUTHOR("Martyn Welch <martyn.welch@gefanuc.com");
+MODULE_DESCRIPTION("GE I/O FPGA GPIO driver");
+MODULE_AUTHOR("Martyn Welch <martyn.welch@ge.com");
 MODULE_LICENSE("GPL");
diff --git a/arch/powerpc/platforms/86xx/gef_pic.c b/arch/powerpc/platforms/86xx/gef_pic.c
index 0110a87..c92d5fb 100644
--- a/arch/powerpc/platforms/86xx/gef_pic.c
+++ b/arch/powerpc/platforms/86xx/gef_pic.c
@@ -1,9 +1,9 @@
 /*
- * Interrupt handling for GE Fanuc's FPGA based PIC
+ * Interrupt handling for GE FPGA based PIC
  *
- * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ * Author: Martyn Welch <martyn.welch@ge.com>
  *
- * 2008 (c) GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * 2008 (c) GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This file is licensed under the terms of the GNU General Public License
  * version 2.  This program is licensed "as is" without any warranty of any
diff --git a/arch/powerpc/platforms/86xx/gef_ppc9a.c b/arch/powerpc/platforms/86xx/gef_ppc9a.c
index a792e5d..60ce07e 100644
--- a/arch/powerpc/platforms/86xx/gef_ppc9a.c
+++ b/arch/powerpc/platforms/86xx/gef_ppc9a.c
@@ -1,9 +1,9 @@
 /*
- * GE Fanuc PPC9A board support
+ * GE PPC9A board support
  *
- * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ * Author: Martyn Welch <martyn.welch@ge.com>
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -82,7 +82,7 @@ static void __init gef_ppc9a_setup_arch(void)
 	}
 #endif
 
-	printk(KERN_INFO "GE Fanuc Intelligent Platforms PPC9A 6U VME SBC\n");
+	printk(KERN_INFO "GE Intelligent Platforms PPC9A 6U VME SBC\n");
 
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
@@ -151,7 +151,7 @@ static void gef_ppc9a_show_cpuinfo(struct seq_file *m)
 {
 	uint svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
+	seq_printf(m, "Vendor\t\t: GE Intelligent Platforms\n");
 
 	seq_printf(m, "Revision\t: %u%c\n", gef_ppc9a_get_pcb_rev(),
 		('A' + gef_ppc9a_get_board_rev()));
@@ -235,7 +235,7 @@ static int __init declare_of_platform_devices(void)
 machine_device_initcall(gef_ppc9a, declare_of_platform_devices);
 
 define_machine(gef_ppc9a) {
-	.name			= "GE Fanuc PPC9A",
+	.name			= "GE PPC9A",
 	.probe			= gef_ppc9a_probe,
 	.setup_arch		= gef_ppc9a_setup_arch,
 	.init_IRQ		= gef_ppc9a_init_irq,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc310.c b/arch/powerpc/platforms/86xx/gef_sbc310.c
index 6a1a613..3ecee25 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc310.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc310.c
@@ -1,9 +1,9 @@
 /*
- * GE Fanuc SBC310 board support
+ * GE SBC310 board support
  *
- * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ * Author: Martyn Welch <martyn.welch@ge.com>
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -82,7 +82,7 @@ static void __init gef_sbc310_setup_arch(void)
 	}
 #endif
 
-	printk(KERN_INFO "GE Fanuc Intelligent Platforms SBC310 6U VPX SBC\n");
+	printk(KERN_INFO "GE Intelligent Platforms SBC310 6U VPX SBC\n");
 
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
@@ -142,7 +142,7 @@ static void gef_sbc310_show_cpuinfo(struct seq_file *m)
 {
 	uint svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
+	seq_printf(m, "Vendor\t\t: GE Intelligent Platforms\n");
 
 	seq_printf(m, "Board ID\t: 0x%2.2x\n", gef_sbc310_get_board_id());
 	seq_printf(m, "Revision\t: %u%c\n", gef_sbc310_get_pcb_rev(),
@@ -223,7 +223,7 @@ static int __init declare_of_platform_devices(void)
 machine_device_initcall(gef_sbc310, declare_of_platform_devices);
 
 define_machine(gef_sbc310) {
-	.name			= "GE Fanuc SBC310",
+	.name			= "GE SBC310",
 	.probe			= gef_sbc310_probe,
 	.setup_arch		= gef_sbc310_setup_arch,
 	.init_IRQ		= gef_sbc310_init_irq,
diff --git a/arch/powerpc/platforms/86xx/gef_sbc610.c b/arch/powerpc/platforms/86xx/gef_sbc610.c
index e10688a..5090d60 100644
--- a/arch/powerpc/platforms/86xx/gef_sbc610.c
+++ b/arch/powerpc/platforms/86xx/gef_sbc610.c
@@ -1,9 +1,9 @@
 /*
- * GE Fanuc SBC610 board support
+ * GE SBC610 board support
  *
- * Author: Martyn Welch <martyn.welch@gefanuc.com>
+ * Author: Martyn Welch <martyn.welch@ge.com>
  *
- * Copyright 2008 GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+ * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -82,7 +82,7 @@ static void __init gef_sbc610_setup_arch(void)
 	}
 #endif
 
-	printk(KERN_INFO "GE Fanuc Intelligent Platforms SBC610 6U VPX SBC\n");
+	printk(KERN_INFO "GE Intelligent Platforms SBC610 6U VPX SBC\n");
 
 #ifdef CONFIG_SMP
 	mpc86xx_smp_init();
@@ -133,7 +133,7 @@ static void gef_sbc610_show_cpuinfo(struct seq_file *m)
 {
 	uint svid = mfspr(SPRN_SVR);
 
-	seq_printf(m, "Vendor\t\t: GE Fanuc Intelligent Platforms\n");
+	seq_printf(m, "Vendor\t\t: GE Intelligent Platforms\n");
 
 	seq_printf(m, "Revision\t: %u%c\n", gef_sbc610_get_pcb_rev(),
 		('A' + gef_sbc610_get_board_rev() - 1));
@@ -212,7 +212,7 @@ static int __init declare_of_platform_devices(void)
 machine_device_initcall(gef_sbc610, declare_of_platform_devices);
 
 define_machine(gef_sbc610) {
-	.name			= "GE Fanuc SBC610",
+	.name			= "GE SBC610",
 	.probe			= gef_sbc610_probe,
 	.setup_arch		= gef_sbc610_setup_arch,
 	.init_IRQ		= gef_sbc610_init_irq,


--
Martyn Welch (Principal Software Engineer)   |   Registered in England and
GE Intelligent Platforms                     |   Wales (3828642) at 100
T +44(0)127322748                            |   Barbirolli Square, Manchester,
E martyn.welch@ge.com                        |   M2 3AB  VAT:GB 927559189
