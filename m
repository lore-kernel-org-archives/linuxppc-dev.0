Return-Path: <B32579@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.182])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A0C6AB6F7C
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Mar 2011 15:46:53 +1100 (EST)
From: Prabhakar Kushwaha <prabhakar@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts:Update PCIe memory maps to match u-boot of
	Px020RDB
Date: Fri, 25 Mar 2011 10:17:45 +0530
Message-ID: <1301028465-3897-1-git-send-email-prabhakar@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: meet2prabhu@gmail.com, Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PCIe memory address space is 1:1 mapped with u-boot.

Update dts of Px020RDB i.e. P1020RDB and P2020RDB to match the address map
changes in u-boot.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Acked-by: Kumar Gala <kumar.gala@freescale.com>
---
 Based upon git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git (Branch master)

 arch/powerpc/boot/dts/p1020rdb.dts            |   12 ++++++------
 arch/powerpc/boot/dts/p2020rdb.dts            |   12 ++++++------
 arch/powerpc/boot/dts/p2020rdb_camp_core0.dts |    4 ++--
 arch/powerpc/boot/dts/p2020rdb_camp_core1.dts |   10 +++++-----
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dts b/arch/powerpc/boot/dts/p1020rdb.dts
index 22f64b6..e0668f8 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dts
+++ b/arch/powerpc/boot/dts/p1020rdb.dts
@@ -1,7 +1,7 @@
 /*
  * P1020 RDB Device Tree Source
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -553,7 +553,7 @@
 		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <16 2>;
@@ -580,8 +580,8 @@
 		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <16 2>;
@@ -590,8 +590,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index da4cb0d..e2d48fd 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -1,7 +1,7 @@
 /*
  * P2020 RDB Device Tree Source
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -537,7 +537,7 @@
 		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
@@ -564,8 +564,8 @@
 		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <26 2>;
@@ -574,8 +574,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
index 0fe93d0..b69c3a5 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core0.dts
@@ -6,7 +6,7 @@
  * This dts file allows core0 to have memory, l2, i2c, spi, gpio, dma1, usb,
  * eth1, eth2, sdhc, crypto, global-util, pci0.
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -342,7 +342,7 @@
 		reg = <0 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
 		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc30000 0x0 0x10000>;
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <25 2>;
diff --git a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
index e95a512..7a31d46c 100644
--- a/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
+++ b/arch/powerpc/boot/dts/p2020rdb_camp_core1.dts
@@ -7,7 +7,7 @@
  *
  * Please note to add "-b 1" for core1's dts compiling.
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -162,8 +162,8 @@
 		#address-cells = <3>;
 		reg = <0 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0 0xc0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupt-parent = <&mpic>;
 		interrupts = <26 2>;
@@ -172,8 +172,8 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			device_type = "pci";
-			ranges = <0x2000000 0x0 0xc0000000
-				  0x2000000 0x0 0xc0000000
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
 				  0x0 0x20000000
 
 				  0x1000000 0x0 0x0
-- 
1.7.3
