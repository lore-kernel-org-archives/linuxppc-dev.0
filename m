Return-Path: <pbathija@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BE741B6F0C
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Nov 2009 10:06:17 +1100 (EST)
From: Pravin Bathija <pbathija@amcc.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH]  [PPC4xx] Fix device tree dts file for katmai board.
Date: Mon, 23 Nov 2009 15:06:13 -0800
Message-Id: <1259017573-27985-1-git-send-email-pbathija@amcc.com>
Cc: sr@denx.de, Pravin Bathija <pbathija@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 Description: Set PCI-E node inbound DMA ranges size to 4GB for correct
 boot up of katmai. Including only changes for PCI-E DMA ranges as
 suggested by Stefan.

Signed-off-by: Pravin Bathija <pbathija@amcc.com>
Acked-by: Feng Kan <fkan@amcc.com>
Acked-by: Prodyut Hazarika <phazarika@amcc.com>
Acked-by: Loc Ho <lho@amcc.com>
Acked-by: Tirumala Reddy Marri <tmarri@amcc.com>
Acked-by: Victor Gallardo <vgallardo@amcc.com>
---
 arch/powerpc/boot/dts/katmai.dts |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index 077819b..d2595b2 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -245,8 +245,8 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000d 0x80000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000c 0x08000000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
 			/* This drives busses 0 to 0xf */
 			bus-range = <0x0 0xf>;
@@ -289,10 +289,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x00000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80000000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
-			/* This drives busses 10 to 0x1f */
+			/* This drives busses 0x10 to 0x1f */
 			bus-range = <0x10 0x1f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
@@ -330,10 +330,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000e 0x80000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80010000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
-			/* This drives busses 10 to 0x1f */
+			/* This drives busses 0x20 to 0x2f */
 			bus-range = <0x20 0x2f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
@@ -371,10 +371,10 @@
 			ranges = <0x02000000 0x00000000 0x80000000 0x0000000f 0x00000000 0x00000000 0x80000000
 				  0x01000000 0x00000000 0x00000000 0x0000000f 0x80020000 0x00000000 0x00010000>;
 
-			/* Inbound 2GB range starting at 0 */
-			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x80000000>;
+			/* Inbound 4GB range starting at 0 */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x1 0x00000000>;
 
-			/* This drives busses 10 to 0x1f */
+			/* This drives busses 0x30 to 0x3f */
 			bus-range = <0x30 0x3f>;
 
 			/* Legacy interrupts (note the weird polarity, the bridge seems
-- 
1.5.5
