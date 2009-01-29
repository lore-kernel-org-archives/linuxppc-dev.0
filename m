Return-Path: <wg@grandegger.com>
Message-ID: <4981ADC9.3000009@grandegger.com>
Date: Thu, 29 Jan 2009 14:23:21 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH] PowerPC: MPC85xx: TQM85xx: fix sensitivity of CAN interrupts
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    4 ++--
 arch/powerpc/boot/dts/tqm8548.dts          |    4 ++--
 arch/powerpc/boot/dts/tqm8560.dts          |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -370,14 +370,14 @@
 		can0@2,0 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x0 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 
 		can1@2,100 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x100 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 
Index: linux-2.6/arch/powerpc/boot/dts/tqm8548.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548.dts
@@ -370,14 +370,14 @@
 		can0@2,0 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x0 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 
 		can1@2,100 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x100 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 
Index: linux-2.6/arch/powerpc/boot/dts/tqm8560.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8560.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8560.dts
@@ -340,14 +340,14 @@
 		can0@2,0 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x0 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 
 		can1@2,100 {
 			compatible = "intel,82527"; // Bosch CC770
 			reg = <2 0x100 0x100>;
-			interrupts = <4 0>;
+			interrupts = <4 1>;
 			interrupt-parent = <&mpic>;
 		};
 	};
