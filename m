Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 254A067A3D
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2006 08:49:16 +1000 (EST)
Date: Mon, 28 Aug 2006 17:49:10 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] corrected PCI interrupt sense values to level low in
	mpc8349emds.dts
Message-Id: <20060828174910.236bf042.kim.phillips@freescale.com>
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

Corrected PCI interrupt sense values to level low in mpc8349emds.dts, per Leo's recommendation.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---

applies on top of "[PATCH 4/4] Add MPC8349E MDS device tree source file to arch/powerpc/boot/dts"


 arch/powerpc/boot/dts/mpc8349emds.dts |  112 +++++++++++++++++----------------
 1 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index 7e4508b..0643db9 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -178,46 +178,46 @@
 			interrupt-map = <
 
 					/* IDSEL 0x11 */
-					 8800 0 0 1 700 14 0
-					 8800 0 0 2 700 15 0
-					 8800 0 0 3 700 16 0
-					 8800 0 0 4 700 17 0
+					 8800 0 0 1 700 14 2
+					 8800 0 0 2 700 15 2
+					 8800 0 0 3 700 16 2
+					 8800 0 0 4 700 17 2
 
 					/* IDSEL 0x12 */
-					 9000 0 0 1 700 16 0
-					 9000 0 0 2 700 17 0
-					 9000 0 0 3 700 14 0
-					 9000 0 0 4 700 15 0
+					 9000 0 0 1 700 16 2
+					 9000 0 0 2 700 17 2
+					 9000 0 0 3 700 14 2
+					 9000 0 0 4 700 15 2
 
 					/* IDSEL 0x13 */
-					 9800 0 0 1 700 17 0
-					 9800 0 0 2 700 14 0
-					 9800 0 0 3 700 15 0
-					 9800 0 0 4 700 16 0
+					 9800 0 0 1 700 17 2
+					 9800 0 0 2 700 14 2
+					 9800 0 0 3 700 15 2
+					 9800 0 0 4 700 16 2
 
 					/* IDSEL 0x15 */
-					 a800 0 0 1 700 14 0
-					 a800 0 0 2 700 15 0
-					 a800 0 0 3 700 16 0
-					 a800 0 0 4 700 17 0
+					 a800 0 0 1 700 14 2
+					 a800 0 0 2 700 15 2
+					 a800 0 0 3 700 16 2
+					 a800 0 0 4 700 17 2
 
 					/* IDSEL 0x16 */
-					 b000 0 0 1 700 17 0
-					 b000 0 0 2 700 14 0
-					 b000 0 0 3 700 15 0
-					 b000 0 0 4 700 16 0
+					 b000 0 0 1 700 17 2
+					 b000 0 0 2 700 14 2
+					 b000 0 0 3 700 15 2
+					 b000 0 0 4 700 16 2
 
 					/* IDSEL 0x17 */
-					 b800 0 0 1 700 16 0
-					 b800 0 0 2 700 17 0
-					 b800 0 0 3 700 14 0
-					 b800 0 0 4 700 15 0
+					 b800 0 0 1 700 16 2
+					 b800 0 0 2 700 17 2
+					 b800 0 0 3 700 14 2
+					 b800 0 0 4 700 15 2
 
 					/* IDSEL 0x18 */
-					 b000 0 0 1 700 15 0
-					 b000 0 0 2 700 16 0
-					 b000 0 0 3 700 17 0
-					 b000 0 0 4 700 14 0>;
+					 b000 0 0 1 700 15 2
+					 b000 0 0 2 700 16 2
+					 b000 0 0 3 700 17 2
+					 b000 0 0 4 700 14 2>;
 			interrupt-parent = <700>;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
@@ -238,46 +238,46 @@
 			interrupt-map = <
 
 					/* IDSEL 0x11 */
-					 8800 0 0 1 700 14 0
-					 8800 0 0 2 700 15 0
-					 8800 0 0 3 700 16 0
-					 8800 0 0 4 700 17 0
+					 8800 0 0 1 700 14 2
+					 8800 0 0 2 700 15 2
+					 8800 0 0 3 700 16 2
+					 8800 0 0 4 700 17 2
 
 					/* IDSEL 0x12 */
-					 9000 0 0 1 700 16 0
-					 9000 0 0 2 700 17 0
-					 9000 0 0 3 700 14 0
-					 9000 0 0 4 700 15 0
+					 9000 0 0 1 700 16 2
+					 9000 0 0 2 700 17 2
+					 9000 0 0 3 700 14 2
+					 9000 0 0 4 700 15 2
 
 					/* IDSEL 0x13 */
-					 9800 0 0 1 700 17 0
-					 9800 0 0 2 700 14 0
-					 9800 0 0 3 700 15 0
-					 9800 0 0 4 700 16 0
+					 9800 0 0 1 700 17 2
+					 9800 0 0 2 700 14 2
+					 9800 0 0 3 700 15 2
+					 9800 0 0 4 700 16 2
 
 					/* IDSEL 0x15 */
-					 a800 0 0 1 700 14 0
-					 a800 0 0 2 700 15 0
-					 a800 0 0 3 700 16 0
-					 a800 0 0 4 700 17 0
+					 a800 0 0 1 700 14 2
+					 a800 0 0 2 700 15 2
+					 a800 0 0 3 700 16 2
+					 a800 0 0 4 700 17 2
 
 					/* IDSEL 0x16 */
-					 b000 0 0 1 700 17 0
-					 b000 0 0 2 700 14 0
-					 b000 0 0 3 700 15 0
-					 b000 0 0 4 700 16 0
+					 b000 0 0 1 700 17 2
+					 b000 0 0 2 700 14 2
+					 b000 0 0 3 700 15 2
+					 b000 0 0 4 700 16 2
 
 					/* IDSEL 0x17 */
-					 b800 0 0 1 700 16 0
-					 b800 0 0 2 700 17 0
-					 b800 0 0 3 700 14 0
-					 b800 0 0 4 700 15 0
+					 b800 0 0 1 700 16 2
+					 b800 0 0 2 700 17 2
+					 b800 0 0 3 700 14 2
+					 b800 0 0 4 700 15 2
 
 					/* IDSEL 0x18 */
-					 b000 0 0 1 700 15 0
-					 b000 0 0 2 700 16 0
-					 b000 0 0 3 700 17 0
-					 b000 0 0 4 700 14 0>;
+					 b000 0 0 1 700 15 2
+					 b000 0 0 2 700 16 2
+					 b000 0 0 3 700 17 2
+					 b000 0 0 4 700 14 2>;
 			interrupt-parent = <700>;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-- 
1.4.1
