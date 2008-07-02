Return-Path: <wg@grandegger.com>
Message-ID: <486B50D8.5000009@grandegger.com>
Date: Wed, 02 Jul 2008 11:56:40 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 52xx: add missing MSCAN FDT nodes for TQM52xx 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the still missing FDT nodes for the MSCAN devices for
the TQM52xx modules.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm5200.dts |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm5200.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm5200.dts
@@ -70,6 +70,22 @@
 			fsl,has-wdt;
 		};
 
+		can@900 {
+			compatible = "fsl,mpc5200-mscan";
+			cell-index = <0>;
+			interrupts = <2 17 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x900 0x80>;
+		};
+
+		can@980 {
+			compatible = "fsl,mpc5200-mscan";
+			cell-index = <1>;
+			interrupts = <2 18 0>;
+			interrupt-parent = <&mpc5200_pic>;
+			reg = <0x980 0x80>;
+		};
+
 		gpio@b00 {
 			compatible = "fsl,mpc5200-gpio";
 			reg = <0xb00 0x40>;
