Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48E69DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 10:26:42 +1100 (EST)
Date: Tue, 13 Nov 2007 17:26:31 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: fix 2nd UCC entry in mpc832x_mds.dts
Message-Id: <20071113172631.7b42e1e1.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

correct the reg property, remove duplicate io port entry, whitespace fixes.

Thanks to Peter Van Ackeren for pointing this out.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index fcd333c..eeafa8b 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -104,7 +104,7 @@
 			reg = <700 100>;
 			device_type = "ipic";
 		};
-		
+
 		par_io@1400 {
 			reg = <1400 100>;
 			device_type = "par_io";
@@ -117,7 +117,6 @@
 					3  5  1  0  2  0  /* MDC */
 					0  d  2  0  1  0 	/* RX_CLK (CLK9) */
 					3 18  2  0  1  0 	/* TX_CLK (CLK10) */
-					1  1  1  0  1  0 	/* TxD1 */
 					1  0  1  0  1  0 	/* TxD0 */
 					1  1  1  0  1  0 	/* TxD1 */
 					1  2  1  0  1  0 	/* TxD2 */
@@ -165,11 +164,11 @@
 		reg = <e0100000 480>;
 		brg-frequency = <0>;
 		bus-frequency = <BCD3D80>;
-		
+
 		muram@10000 {
 			device_type = "muram";
 			ranges = <0 00010000 00004000>;
-	
+
 			data-only@0 {
 				reg = <0 4000>;
 			};
@@ -228,7 +227,7 @@
 			compatible = "ucc_geth";
 			model = "UCC";
 			device-id = <4>;
-			reg = <3000 200>;
+			reg = <3200 200>;
 			interrupts = <23>;
 			interrupt-parent = < &qeic >;
 			/*
-- 
1.5.2.2
