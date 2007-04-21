Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 5ECB5DDE45
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 07:24:30 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, G. Liakhovetski <g.liakhovetski@gmx.de>,
	paulus@samba.org
Subject: [POWERPC] Fix comment typo in Kurobox device tree
Date: Sat, 21 Apr 2007 15:24:04 -0600
Message-Id: <1177190644776-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/boot/dts/kuroboxHD.dts |    6 +++---
 arch/powerpc/boot/dts/kuroboxHG.dts |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index 373110d..157dc98 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -125,17 +125,17 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHD.dtb -V 16 kuroboxHD.dts"
 			interrupt-parent = <4400>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
-				/* IDSEL 0x11 - IRQ0 ETH */
+				/* IDSEL 11 - IRQ0 ETH */
 				5800 0 0 1 4400 0 1
 				5800 0 0 2 4400 1 1
 				5800 0 0 3 4400 2 1
 				5800 0 0 4 4400 3 1
-				/* IDSEL 0x12 - IRQ1 IDE0 */
+				/* IDSEL 12 - IRQ1 IDE0 */
 				6000 0 0 1 4400 1 1
 				6000 0 0 2 4400 2 1
 				6000 0 0 3 4400 3 1
 				6000 0 0 4 4400 0 1
-				/* IDSEL 0x14 - IRQ3 USB2.0 */
+				/* IDSEL 14 - IRQ3 USB2.0 */
 				7000 0 0 1 4400 3 1
 				7000 0 0 2 4400 3 1
 				7000 0 0 3 4400 3 1
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index f3542dc..919eb29 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -125,17 +125,17 @@ build with: "dtc -f -I dts -O dtb -o kuroboxHG.dtb -V 16 kuroboxHG.dts"
 			interrupt-parent = <4400>;
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
-				/* IDSEL 0x11 - IRQ0 ETH */
+				/* IDSEL 11 - IRQ0 ETH */
 				5800 0 0 1 4400 0 1
 				5800 0 0 2 4400 1 1
 				5800 0 0 3 4400 2 1
 				5800 0 0 4 4400 3 1
-				/* IDSEL 0x12 - IRQ1 IDE0 */
+				/* IDSEL 12 - IRQ1 IDE0 */
 				6000 0 0 1 4400 1 1
 				6000 0 0 2 4400 2 1
 				6000 0 0 3 4400 3 1
 				6000 0 0 4 4400 0 1
-				/* IDSEL 0x14 - IRQ3 USB2.0 */
+				/* IDSEL 14 - IRQ3 USB2.0 */
 				7000 0 0 1 4400 3 1
 				7000 0 0 2 4400 3 1
 				7000 0 0 3 4400 3 1
-- 
1.5.1
