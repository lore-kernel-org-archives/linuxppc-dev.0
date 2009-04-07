Return-Path: <wg@denx.de>
Message-Id: <20090407082231.803193635@denx.de>
Date: Tue, 07 Apr 2009 10:20:57 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-i2c@vger.kernel.org
Subject: [PATCH v3 5/5] powerpc/85xx: i2c-mpc: use new I2C bindings for the
	Socates board
References: <20090407082052.477328750@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Preserve I2C clock settings for the Socrates MPC8544 board.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/socrates.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6-galak/arch/powerpc/boot/dts/socrates.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/socrates.dts	2009-04-07 10:09:07.161718915 +0200
+++ linux-2.6-galak/arch/powerpc/boot/dts/socrates.dts	2009-04-07 10:09:16.207719258 +0200
@@ -79,11 +79,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <0>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3000 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
-			dfsrr;
+			fsl,preserve-clocking;
 
 			dtt@28 {
 				compatible = "winbond,w83782d";
@@ -111,11 +111,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			cell-index = <1>;
-			compatible = "fsl-i2c";
+			compatible = "fsl,mpc8544-i2c", "fsl-i2c";
 			reg = <0x3100 0x100>;
 			interrupts = <43 2>;
 			interrupt-parent = <&mpic>;
-			dfsrr;
+			fsl,preserve-clocking;
 		};
 
 		enet0: ethernet@24000 {
