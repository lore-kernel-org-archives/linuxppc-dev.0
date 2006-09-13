Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4EE1E67A2E
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Sep 2006 08:42:08 +1000 (EST)
Date: Wed, 13 Sep 2006 17:41:55 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] fix MPC8349EMDS dts PCI interrupt-map values for IDSEL 0x18
Message-Id: <20060913174155.32ebf89a.kim.phillips@freescale.com>
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

Fix MPC8349EMDS dts PCI interrupt-map values for IDSEL 0x18 per Tanya's catch.

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
Signed-off-by: Tanya Jiang <tanya.jiang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8349emds.dts |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index 12f5dbf..efceb34 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -214,10 +214,10 @@
 					 b800 0 0 4 700 15 8
 
 					/* IDSEL 0x18 */
-					 b000 0 0 1 700 15 8
-					 b000 0 0 2 700 16 8
-					 b000 0 0 3 700 17 8
-					 b000 0 0 4 700 14 8>;
+					 c000 0 0 1 700 15 8
+					 c000 0 0 2 700 16 8
+					 c000 0 0 3 700 17 8
+					 c000 0 0 4 700 14 8>;
 			interrupt-parent = <700>;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
@@ -274,10 +274,10 @@
 					 b800 0 0 4 700 15 8
 
 					/* IDSEL 0x18 */
-					 b000 0 0 1 700 15 8
-					 b000 0 0 2 700 16 8
-					 b000 0 0 3 700 17 8
-					 b000 0 0 4 700 14 8>;
+					 c000 0 0 1 700 15 8
+					 c000 0 0 2 700 16 8
+					 c000 0 0 3 700 17 8
+					 c000 0 0 4 700 14 8>;
 			interrupt-parent = <700>;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-- 
1.4.2
