Return-Path: <B31383@freescale.com>
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:Add dr_mode property in USB nodes
Date: Wed, 18 Jan 2012 12:18:46 +0530
Message-ID: <1326869326-4271-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree-discuss@lists.ozlabs.org,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add usb2 controller node for P1020RDB, P2020RDB, P2020DS, P1021MDS

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
(branch next)

 arch/powerpc/boot/dts/p1020rdb.dtsi |    2 ++
 arch/powerpc/boot/dts/p1021mds.dts  |    3 ++-
 arch/powerpc/boot/dts/p2020ds.dtsi  |    3 ++-
 arch/powerpc/boot/dts/p2020rdb.dts  |    3 ++-
 4 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1020rdb.dtsi b/arch/powerpc/boot/dts/p1020rdb.dtsi
index 17559c4..1fb7e0e 100644
--- a/arch/powerpc/boot/dts/p1020rdb.dtsi
+++ b/arch/powerpc/boot/dts/p1020rdb.dtsi
@@ -190,6 +190,7 @@
 
 	usb@22000 {
 		phy_type = "ulpi";
+		dr_mode = "host";
 	};
 
 	/* USB2 is shared with localbus. It is used
@@ -197,6 +198,7 @@
 	   appropriate device-tree fixup done by uboot */
 	usb@23000 {
 		phy_type = "ulpi";
+		dr_mode = "host";
 	};
 
 	mdio@24000 {
diff --git a/arch/powerpc/boot/dts/p1021mds.dts b/arch/powerpc/boot/dts/p1021mds.dts
index d954079..97116f1 100644
--- a/arch/powerpc/boot/dts/p1021mds.dts
+++ b/arch/powerpc/boot/dts/p1021mds.dts
@@ -1,7 +1,7 @@
 /*
  * P1021 MDS Device Tree Source
  *
- * Copyright 2010 Freescale Semiconductor Inc.
+ * Copyright 2010,2012 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -151,6 +151,7 @@
 
 		usb@22000 {
 			phy_type = "ulpi";
+			dr_mode = "host";
 		};
 
 		mdio@24000 {
diff --git a/arch/powerpc/boot/dts/p2020ds.dtsi b/arch/powerpc/boot/dts/p2020ds.dtsi
index c1cf6ce..d3b939c 100644
--- a/arch/powerpc/boot/dts/p2020ds.dtsi
+++ b/arch/powerpc/boot/dts/p2020ds.dtsi
@@ -1,7 +1,7 @@
 /*
  * P2020DS Device Tree Source stub (no addresses or top-level ranges)
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -134,6 +134,7 @@
 &board_soc {
 	usb@22000 {
 		phy_type = "ulpi";
+		dr_mode = "host";
 	};
 
 	mdio@24520 {
diff --git a/arch/powerpc/boot/dts/p2020rdb.dts b/arch/powerpc/boot/dts/p2020rdb.dts
index 26759a5..eb8a6aa 100644
--- a/arch/powerpc/boot/dts/p2020rdb.dts
+++ b/arch/powerpc/boot/dts/p2020rdb.dts
@@ -1,7 +1,7 @@
 /*
  * P2020 RDB Device Tree Source
  *
- * Copyright 2009-2011 Freescale Semiconductor Inc.
+ * Copyright 2009-2012 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -197,6 +197,7 @@
 
 		usb@22000 {
 			phy_type = "ulpi";
+			dr_mode = "host";
 		};
 
 		mdio@24520 {
-- 
1.7.1
