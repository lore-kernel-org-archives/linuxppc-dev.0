Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 70A25DDDED
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 15:05:56 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n1A45pJx025232
	for <linuxppc-dev@ozlabs.org>; Mon, 9 Feb 2009 22:05:52 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Fixed PCI IO region sizes in mpc8572ds*.dts
Date: Mon,  9 Feb 2009 22:05:50 -0600
Message-Id: <1234238751-11900-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PCI IO region sizes where incorrectly set to 1M instead of 64k.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/mpc8572ds.dts            |   10 +++++-----
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |    8 ++++----
 arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts |    4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 359c3b7..6c9354b 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8572 DS Device Tree Source
  *
- * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ * Copyright 2007-2009 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -643,7 +643,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 			uli1575@0 {
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				#size-cells = <2>;
@@ -654,7 +654,7 @@
 
 					  0x1000000 0x0 0x0
 					  0x1000000 0x0 0x0
-					  0x0 0x100000>;
+					  0x0 0x10000>;
 				isa@1e {
 					device_type = "isa";
 					#interrupt-cells = <2>;
@@ -744,7 +744,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 		};
 	};
 
@@ -781,7 +781,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index fd462ef..15d9e35 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -6,7 +6,7 @@
  * This dts file allows core0 to have memory, l2, i2c, dma1, global-util, eth0,
  * eth1, crypto, pci0, pci1.
  *
- * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ * Copyright 2007-2009 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -376,7 +376,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 			uli1575@0 {
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				#size-cells = <2>;
@@ -387,7 +387,7 @@
 
 					  0x1000000 0x0 0x0
 					  0x1000000 0x0 0x0
-					  0x0 0x100000>;
+					  0x0 0x10000>;
 				isa@1e {
 					device_type = "isa";
 					#interrupt-cells = <2>;
@@ -477,7 +477,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 		};
 	};
 };
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
index e35230f..eace811 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core1.dts
@@ -7,7 +7,7 @@
  *
  * Please note to add "-b 1" for core1's dts compiling.
  *
- * Copyright 2007, 2008 Freescale Semiconductor Inc.
+ * Copyright 2007-2009 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -228,7 +228,7 @@
 
 				  0x1000000 0x0 0x0
 				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
+				  0x0 0x10000>;
 		};
 	};
 };
-- 
1.5.6.6
