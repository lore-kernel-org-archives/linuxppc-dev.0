Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
 [216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E3B5CB6F67
 for <linuxppc-dev@ozlabs.org>; Sat, 10 Dec 2011 02:20:12 +1100 (EST)
Received: from mail80-va3 (localhost [127.0.0.1])	by mail80-va3-R.bigfish.com
 (Postfix) with ESMTP id 200994A065A	for <linuxppc-dev@ozlabs.org>;
 Fri,  9 Dec 2011 15:20:08 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.238])	by
 mail80-va3.bigfish.com (Postfix) with ESMTP id BD078661590	for
 <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 15:20:07 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [for-3.2] powerpc/85xx: fix PCI and localbus properties in
 p1022ds.dts
Date: Fri, 9 Dec 2011 09:20:03 -0600
Message-ID: <1323444003-2797-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index e627f70..d4c1439 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -51,12 +51,12 @@
 		#address-cells = <2>;
 		#size-cells = <1>;
 		compatible = "fsl,p1022-elbc", "fsl,elbc", "simple-bus";
-		reg = <0 0xffe05000 0 0x1000>;
+		reg = <0xf 0xffe05000 0 0x1000>;
 		interrupts = <19 2 0 0>;
 
 		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
 			  0x1 0x0 0xf 0xe0000000 0x08000000
-			  0x2 0x0 0x0 0xffa00000 0x00040000
+			  0x2 0x0 0xf 0xff800000 0x00040000
 			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
 
 		nor@0,0 {
@@ -561,7 +561,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe09000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xa0000000 0xc 0x20000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupts = <16 2 0 0>;
@@ -596,7 +596,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe0a000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0xc0000000 0xc 0x40000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupts = <16 2 0 0>;
@@ -632,7 +632,7 @@
 		#address-cells = <3>;
 		reg = <0xf 0xffe0b000 0 0x1000>;
 		bus-range = <0 255>;
-		ranges = <0x2000000 0x0 0x80000000 0xc 0x00000000 0x0 0x20000000
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
 		clock-frequency = <33333333>;
 		interrupts = <16 2 0 0>;
-- 
1.7.3.4
