Return-Path: <r63061@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3E689B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 20:57:48 +1100 (EST)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/dts: Add magic-packet properties for etsec
Date: Tue, 17 Jan 2012 17:59:51 +0800
Message-ID: <1326794391-6105-2-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
References: <y>
 <1326794391-6105-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The properties indicates that the hardware supports waking up via magic packet.

Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
 arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi |    3 ++-
 arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi |    3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
index a1979ae..3b0650a 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-0.dtsi
@@ -1,7 +1,7 @@
 /*
  * PQ3 eTSEC device tree stub [ @ offsets 0x24000 ]
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -41,6 +41,7 @@ ethernet@24000 {
 	compatible = "gianfar";
 	reg = <0x24000 0x1000>;
 	ranges = <0x0 0x24000 0x1000>;
+	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
 	interrupts = <29 2 0 0 30 2 0 0 34 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
index 4c4fdde..96693b4 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-1.dtsi
@@ -1,7 +1,7 @@
 /*
  * PQ3 eTSEC device tree stub [ @ offsets 0x25000 ]
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -41,6 +41,7 @@ ethernet@25000 {
 	compatible = "gianfar";
 	reg = <0x25000 0x1000>;
 	ranges = <0x0 0x25000 0x1000>;
+	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
 	interrupts = <35 2 0 0 36 2 0 0 40 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
index 4b8ab43..6b3fab1 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-2.dtsi
@@ -1,7 +1,7 @@
 /*
  * PQ3 eTSEC device tree stub [ @ offsets 0x26000 ]
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -41,6 +41,7 @@ ethernet@26000 {
 	compatible = "gianfar";
 	reg = <0x26000 0x1000>;
 	ranges = <0x0 0x26000 0x1000>;
+	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
 	interrupts = <31 2 0 0 32 2 0 0 33 2 0 0>;
 };
diff --git a/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi b/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
index 40c9137..0da592d 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-etsec1-3.dtsi
@@ -1,7 +1,7 @@
 /*
  * PQ3 eTSEC device tree stub [ @ offsets 0x27000 ]
  *
- * Copyright 2011 Freescale Semiconductor Inc.
+ * Copyright 2011-2012 Freescale Semiconductor Inc.
  *
  * Redistribution and use in source and binary forms, with or without
  * modification, are permitted provided that the following conditions are met:
@@ -41,6 +41,7 @@ ethernet@27000 {
 	compatible = "gianfar";
 	reg = <0x27000 0x1000>;
 	ranges = <0x0 0x27000 0x1000>;
+	fsl,magic-packet;
 	local-mac-address = [ 00 00 00 00 00 00 ];
 	interrupts = <37 2 0 0 38 2 0 0 39 2 0 0>;
 };
-- 
1.7.5.1
