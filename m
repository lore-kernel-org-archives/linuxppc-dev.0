Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 455D6DE04C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 10:47:13 +1100 (EST)
Date: Fri, 28 Mar 2008 16:47:04 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080328234704.GD30214@farnsworth.org>
References: <20080328233954.GA29499@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080328233954.GA29499@farnsworth.org>
Subject: [PATCH 4/9] [POWERPC] mv64x60: Fix FDT compatible names: mv64x60
	=> mv64360
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Compatible names should refer to a specific version of the hardware,
without wildcards.  Change each instance of mv64x60 to mv64360, which
is the oldest version we currently support.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -46,7 +46,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
-		compatible = "mrvl,mv64x60";
+		compatible = "mrvl,mv64360";
 		clock-frequency = <133333333>;
 		reg = <0xf1000000 0x10000>;
 		virtual-reg = <0xf1000000>;
@@ -74,7 +74,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "mdio";
-			compatible = "mrvl,mv64x60-mdio";
+			compatible = "mrvl,mv64360-mdio";
 			PHY0: ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
@@ -95,7 +95,7 @@
 			reg = <0x2000 0x2000>;
 			eth0 {
 				device_type = "network";
-				compatible = "mrvl,mv64x60-eth";
+				compatible = "mrvl,mv64360-eth";
 				block-index = <0>;
 				interrupts = <32>;
 				interrupt-parent = <&PIC>;
@@ -104,7 +104,7 @@
 			};
 			eth1 {
 				device_type = "network";
-				compatible = "mrvl,mv64x60-eth";
+				compatible = "mrvl,mv64360-eth";
 				block-index = <1>;
 				interrupts = <33>;
 				interrupt-parent = <&PIC>;
@@ -115,7 +115,7 @@
 
 		SDMA0: sdma@4000 {
 			device_type = "dma";
-			compatible = "mrvl,mv64x60-sdma";
+			compatible = "mrvl,mv64360-sdma";
 			reg = <0x4000 0xc18>;
 			virtual-reg = <0xf1004000>;
 			interrupt-base = <0>;
@@ -125,7 +125,7 @@
 
 		SDMA1: sdma@6000 {
 			device_type = "dma";
-			compatible = "mrvl,mv64x60-sdma";
+			compatible = "mrvl,mv64360-sdma";
 			reg = <0x6000 0xc18>;
 			virtual-reg = <0xf1006000>;
 			interrupt-base = <0>;
@@ -134,7 +134,7 @@
 		};
 
 		BRG0: brg@b200 {
-			compatible = "mrvl,mv64x60-brg";
+			compatible = "mrvl,mv64360-brg";
 			reg = <0xb200 0x8>;
 			clock-src = <8>;
 			clock-frequency = <133333333>;
@@ -143,7 +143,7 @@
 		};
 
 		BRG1: brg@b208 {
-			compatible = "mrvl,mv64x60-brg";
+			compatible = "mrvl,mv64360-brg";
 			reg = <0xb208 0x8>;
 			clock-src = <8>;
 			clock-frequency = <133333333>;
@@ -166,7 +166,7 @@
 
 		MPSC0: mpsc@8000 {
 			device_type = "serial";
-			compatible = "mrvl,mpsc";
+			compatible = "mrvl,mv64360-mpsc";
 			reg = <0x8000 0x38>;
 			virtual-reg = <0xf1008000>;
 			sdma = <&SDMA0>;
@@ -186,7 +186,7 @@
 
 		MPSC1: mpsc@9000 {
 			device_type = "serial";
-			compatible = "mrvl,mpsc";
+			compatible = "mrvl,mv64360-mpsc";
 			reg = <0x9000 0x38>;
 			virtual-reg = <0xf1009000>;
 			sdma = <&SDMA1>;
@@ -205,14 +205,14 @@
 		};
 
 		wdt@b410 {			/* watchdog timer */
-			compatible = "mrvl,mv64x60-wdt";
+			compatible = "mrvl,mv64360-wdt";
 			reg = <0xb410 0x8>;
 			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
-			compatible = "mrvl,mv64x60-i2c";
+			compatible = "mrvl,mv64360-i2c";
 			reg = <0xc000 0x20>;
 			virtual-reg = <0xf100c000>;
 			freq_m = <8>;
@@ -226,18 +226,18 @@
 		PIC: pic {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-			compatible = "mrvl,mv64x60-pic";
+			compatible = "mrvl,mv64360-pic";
 			reg = <0x0 0x88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
-			compatible = "mrvl,mv64x60-mpp";
+			compatible = "mrvl,mv64360-mpp";
 			reg = <0xf000 0x10>;
 		};
 
 		gpp@f100 {
-			compatible = "mrvl,mv64x60-gpp";
+			compatible = "mrvl,mv64360-gpp";
 			reg = <0xf100 0x20>;
 		};
 
@@ -246,7 +246,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			device_type = "pci";
-			compatible = "mrvl,mv64x60-pci";
+			compatible = "mrvl,mv64360-pci";
 			reg = <0xcf8 0x8>;
 			ranges = <0x01000000 0x0        0x0
 					0x88000000 0x0 0x01000000
@@ -285,28 +285,28 @@
 		};
 
 		cpu-error@0070 {
-			compatible = "mrvl,mv64x60-cpu-error";
+			compatible = "mrvl,mv64360-cpu-error";
 			reg = <0x70 0x10 0x128 0x28>;
 			interrupts = <3>;
 			interrupt-parent = <&PIC>;
 		};
 
 		sram-ctrl@0380 {
-			compatible = "mrvl,mv64x60-sram-ctrl";
+			compatible = "mrvl,mv64360-sram-ctrl";
 			reg = <0x380 0x80>;
 			interrupts = <13>;
 			interrupt-parent = <&PIC>;
 		};
 
 		pci-error@1d40 {
-			compatible = "mrvl,mv64x60-pci-error";
+			compatible = "mrvl,mv64360-pci-error";
 			reg = <0x1d40 0x40 0xc28 0x4>;
 			interrupts = <12>;
 			interrupt-parent = <&PIC>;
 		};
 
 		mem-ctrl@1400 {
-			compatible = "mrvl,mv64x60-mem-ctrl";
+			compatible = "mrvl,mv64360-mem-ctrl";
 			reg = <0x1400 0x60>;
 			interrupts = <17>;
 			interrupt-parent = <&PIC>;
Index: linux-2.6/arch/powerpc/boot/serial.c
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/serial.c
+++ linux-2.6/arch/powerpc/boot/serial.c
@@ -119,7 +119,7 @@ int serial_console_init(void)
 
 	if (dt_is_compatible(devp, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
-	else if (dt_is_compatible(devp, "mrvl,mpsc"))
+	else if (dt_is_compatible(devp, "mrvl,mv64360-mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/prpmc2800.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/prpmc2800.c
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/prpmc2800.c
@@ -49,13 +49,13 @@ static void __init prpmc2800_setup_arch(
 	 * ioremap mpp and gpp registers in case they are later
 	 * needed by prpmc2800_reset_board().
 	 */
-	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-mpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64360-mpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
 	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
 
-	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64360-gpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
@@ -446,22 +446,22 @@ static int __init mv64x60_device_setup(v
 	int err;
 
 	id = 0;
-	for_each_compatible_node(np, "serial", "mrvl,mpsc")
+	for_each_compatible_node(np, "serial", "mrvl,mv64360-mpsc")
 		if ((err = mv64x60_mpsc_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "network", "mrvl,mv64x60-eth")
+	for_each_compatible_node(np, "network", "mrvl,mv64360-eth")
 		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "i2c", "mrvl,mv64x60-i2c")
+	for_each_compatible_node(np, "i2c", "mrvl,mv64360-i2c")
 		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
 	/* support up to one watchdog timer */
-	np = of_find_compatible_node(np, NULL, "mrvl,mv64x60-wdt");
+	np = of_find_compatible_node(np, NULL, "mrvl,mv64360-wdt");
 	if (np) {
 		if ((err = mv64x60_wdt_device_setup(np, id)))
 			goto error;
@@ -489,7 +489,7 @@ static int __init mv64x60_add_mpsc_conso
 	if (!np)
 		goto not_mpsc;
 
-	if (!of_device_is_compatible(np, "mrvl,mpsc"))
+	if (!of_device_is_compatible(np, "mrvl,mv64360-mpsc"))
 		goto not_mpsc;
 
 	prop = of_get_property(np, "block-index", NULL);
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_pci.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c
@@ -86,14 +86,14 @@ static int __init mv64x60_sysfs_init(voi
 	struct platform_device *pdev;
 	const unsigned int *prop;
 
-	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64360");
 	if (!np)
 		return 0;
 
 	prop = of_get_property(np, "hs_reg_valid", NULL);
 	of_node_put(np);
 
-	pdev = platform_device_register_simple("mrvl,mv64x60", 0, NULL, 0);
+	pdev = platform_device_register_simple("mrvl,mv64360", 0, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -166,6 +166,6 @@ void __init mv64x60_pci_init(void)
 {
 	struct device_node *np;
 
-	for_each_compatible_node(np, "pci", "mrvl,mv64x60-pci")
+	for_each_compatible_node(np, "pci", "mrvl,mv64360-pci")
 		mv64x60_add_bridge(np);
 }
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_pic.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_pic.c
@@ -238,13 +238,13 @@ void __init mv64x60_init_irq(void)
 	const unsigned int *reg;
 	unsigned long flags;
 
-	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64360-gpp");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
 	of_node_put(np);
 
-	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-pic");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64360-pic");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_irq_reg_base = ioremap(paddr, reg[1]);
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_udbg.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_udbg.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -85,7 +85,7 @@ static void mv64x60_udbg_init(void)
 	if (!stdout)
 		return;
 
-	for_each_compatible_node(np, "serial", "mrvl,mpsc") {
+	for_each_compatible_node(np, "serial", "mrvl,mv64360-mpsc") {
 		if (np == stdout)
 			break;
 	}
