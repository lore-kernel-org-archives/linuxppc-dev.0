Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98544DE3D4
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 04:38:49 +1000 (EST)
Date: Mon, 7 Apr 2008 11:38:17 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407183817.GB7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407183228.GA7438@farnsworth.org>
Subject: [PATCH 1/9 v2] powerpc: change FDT compatible prefix to mrvl
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Follow the convention that compatible names are prefixed by the
vendor's stock ticker symbol.  For Marvell Technology Group Ltd.,
that's MRVL.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Acked-by: Mark A. Greer <mgreer@mvista.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -44,7 +44,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
-		compatible = "marvell,mv64x60";
+		compatible = "mrvl,mv64x60";
 		clock-frequency = <7f28155>;		/* 133.333333 MHz */
 		reg = <f1000000 00010000>;
 		virtual-reg = <f1000000>;
@@ -72,7 +72,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "mdio";
-			compatible = "marvell,mv64x60-mdio";
+			compatible = "mrvl,mv64x60-mdio";
 			ethernet-phy@1 {
 				device_type = "ethernet-phy";
 				compatible = "broadcom,bcm5421";
@@ -93,7 +93,7 @@
 			reg = <2000 2000>;
 			eth0 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
+				compatible = "mrvl,mv64x60-eth";
 				block-index = <0>;
 				interrupts = <20>;
 				interrupt-parent = <&/mv64x60/pic>;
@@ -102,7 +102,7 @@
 			};
 			eth1 {
 				device_type = "network";
-				compatible = "marvell,mv64x60-eth";
+				compatible = "mrvl,mv64x60-eth";
 				block-index = <1>;
 				interrupts = <21>;
 				interrupt-parent = <&/mv64x60/pic>;
@@ -113,7 +113,7 @@
 
 		sdma@4000 {
 			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
+			compatible = "mrvl,mv64x60-sdma";
 			reg = <4000 c18>;
 			virtual-reg = <f1004000>;
 			interrupt-base = <0>;
@@ -123,7 +123,7 @@
 
 		sdma@6000 {
 			device_type = "dma";
-			compatible = "marvell,mv64x60-sdma";
+			compatible = "mrvl,mv64x60-sdma";
 			reg = <6000 c18>;
 			virtual-reg = <f1006000>;
 			interrupt-base = <0>;
@@ -132,7 +132,7 @@
 		};
 
 		brg@b200 {
-			compatible = "marvell,mv64x60-brg";
+			compatible = "mrvl,mv64x60-brg";
 			reg = <b200 8>;
 			clock-src = <8>;
 			clock-frequency = <7ed6b40>;
@@ -141,7 +141,7 @@
 		};
 
 		brg@b208 {
-			compatible = "marvell,mv64x60-brg";
+			compatible = "mrvl,mv64x60-brg";
 			reg = <b208 8>;
 			clock-src = <8>;
 			clock-frequency = <7ed6b40>;
@@ -164,7 +164,7 @@
 
 		mpsc@8000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
+			compatible = "mrvl,mpsc";
 			reg = <8000 38>;
 			virtual-reg = <f1008000>;
 			sdma = <&/mv64x60/sdma@4000>;
@@ -184,7 +184,7 @@
 
 		mpsc@9000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
+			compatible = "mrvl,mpsc";
 			reg = <9000 38>;
 			virtual-reg = <f1009000>;
 			sdma = <&/mv64x60/sdma@6000>;
@@ -203,14 +203,14 @@
 		};
 
 		wdt@b410 {			/* watchdog timer */
-			compatible = "marvell,mv64x60-wdt";
+			compatible = "mrvl,mv64x60-wdt";
 			reg = <b410 8>;
 			timeout = <a>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
 			device_type = "i2c";
-			compatible = "marvell,mv64x60-i2c";
+			compatible = "mrvl,mv64x60-i2c";
 			reg = <c000 20>;
 			virtual-reg = <f100c000>;
 			freq_m = <8>;
@@ -224,18 +224,18 @@
 		pic {
 			#interrupt-cells = <1>;
 			#address-cells = <0>;
-			compatible = "marvell,mv64x60-pic";
+			compatible = "mrvl,mv64x60-pic";
 			reg = <0000 88>;
 			interrupt-controller;
 		};
 
 		mpp@f000 {
-			compatible = "marvell,mv64x60-mpp";
+			compatible = "mrvl,mv64x60-mpp";
 			reg = <f000 10>;
 		};
 
 		gpp@f100 {
-			compatible = "marvell,mv64x60-gpp";
+			compatible = "mrvl,mv64x60-gpp";
 			reg = <f100 20>;
 		};
 
@@ -244,7 +244,7 @@
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
 			device_type = "pci";
-			compatible = "marvell,mv64x60-pci";
+			compatible = "mrvl,mv64x60-pci";
 			reg = <0cf8 8>;
 			ranges = <01000000 0        0 88000000 0 01000000
 				  02000000 0 80000000 80000000 0 08000000>;
@@ -281,28 +281,28 @@
 		};
 
 		cpu-error@0070 {
-			compatible = "marvell,mv64x60-cpu-error";
+			compatible = "mrvl,mv64x60-cpu-error";
 			reg = <0070 10 0128 28>;
 			interrupts = <03>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		sram-ctrl@0380 {
-			compatible = "marvell,mv64x60-sram-ctrl";
+			compatible = "mrvl,mv64x60-sram-ctrl";
 			reg = <0380 80>;
 			interrupts = <0d>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		pci-error@1d40 {
-			compatible = "marvell,mv64x60-pci-error";
+			compatible = "mrvl,mv64x60-pci-error";
 			reg = <1d40 40 0c28 4>;
 			interrupts = <0c>;
 			interrupt-parent = <&/mv64x60/pic>;
 		};
 
 		mem-ctrl@1400 {
-			compatible = "marvell,mv64x60-mem-ctrl";
+			compatible = "mrvl,mv64x60-mem-ctrl";
 			reg = <1400 60>;
 			interrupts = <11>;
 			interrupt-parent = <&/mv64x60/pic>;
Index: linux-2.6/arch/powerpc/boot/serial.c
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/serial.c
+++ linux-2.6/arch/powerpc/boot/serial.c
@@ -119,7 +119,7 @@ int serial_console_init(void)
 
 	if (dt_is_compatible(devp, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
-	else if (dt_is_compatible(devp, "marvell,mpsc"))
+	else if (dt_is_compatible(devp, "mrvl,mpsc"))
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
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-mpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-mpp");
 	reg = of_get_property(np, "reg", NULL);
 	paddr = of_translate_address(np, reg);
 	of_node_put(np);
 	mv64x60_mpp_reg_base = ioremap(paddr, reg[1]);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-gpp");
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
-	for_each_compatible_node(np, "serial", "marvell,mpsc")
+	for_each_compatible_node(np, "serial", "mrvl,mpsc")
 		if ((err = mv64x60_mpsc_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "network", "marvell,mv64x60-eth")
+	for_each_compatible_node(np, "network", "mrvl,mv64x60-eth")
 		if ((err = mv64x60_eth_device_setup(np, id++)))
 			goto error;
 
 	id = 0;
-	for_each_compatible_node(np, "i2c", "marvell,mv64x60-i2c")
+	for_each_compatible_node(np, "i2c", "mrvl,mv64x60-i2c")
 		if ((err = mv64x60_i2c_device_setup(np, id++)))
 			goto error;
 
 	/* support up to one watchdog timer */
-	np = of_find_compatible_node(np, NULL, "marvell,mv64x60-wdt");
+	np = of_find_compatible_node(np, NULL, "mrvl,mv64x60-wdt");
 	if (np) {
 		if ((err = mv64x60_wdt_device_setup(np, id)))
 			goto error;
@@ -489,7 +489,7 @@ static int __init mv64x60_add_mpsc_conso
 	if (!np)
 		goto not_mpsc;
 
-	if (!of_device_is_compatible(np, "marvell,mpsc"))
+	if (!of_device_is_compatible(np, "mrvl,mpsc"))
 		goto not_mpsc;
 
 	prop = of_get_property(np, "block-index", NULL);
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_pci.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_pci.c
@@ -86,14 +86,14 @@ static int __init mv64x60_sysfs_init(voi
 	struct platform_device *pdev;
 	const unsigned int *prop;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60");
 	if (!np)
 		return 0;
 
 	prop = of_get_property(np, "hs_reg_valid", NULL);
 	of_node_put(np);
 
-	pdev = platform_device_register_simple("marvell,mv64x60", 0, NULL, 0);
+	pdev = platform_device_register_simple("mrvl,mv64x60", 0, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
 
@@ -166,6 +166,6 @@ void __init mv64x60_pci_init(void)
 {
 	struct device_node *np;
 
-	for_each_compatible_node(np, "pci", "marvell,mv64x60-pci")
+	for_each_compatible_node(np, "pci", "mrvl,mv64x60-pci")
 		mv64x60_add_bridge(np);
 }
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_pic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_pic.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_pic.c
@@ -238,13 +238,13 @@ void __init mv64x60_init_irq(void)
 	const unsigned int *reg;
 	unsigned long flags;
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-gpp");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-gpp");
 	reg = of_get_property(np, "reg", &size);
 	paddr = of_translate_address(np, reg);
 	mv64x60_gpp_reg_base = ioremap(paddr, reg[1]);
 	of_node_put(np);
 
-	np = of_find_compatible_node(NULL, NULL, "marvell,mv64x60-pic");
+	np = of_find_compatible_node(NULL, NULL, "mrvl,mv64x60-pic");
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
 
-	for_each_compatible_node(np, "serial", "marvell,mpsc") {
+	for_each_compatible_node(np, "serial", "mrvl,mpsc") {
 		if (np == stdout)
 			break;
 	}
