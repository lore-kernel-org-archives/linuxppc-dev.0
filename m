Return-Path: <wg@grandegger.com>
Message-ID: <4981A5CD.1050203@grandegger.com>
Date: Thu, 29 Jan 2009 13:49:17 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH] PowerPC: MPC85xx: TQM85xx: add i2c device nodes for LM75
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Automatic I2C device probing is not done any more. Therefore we need
proper DTS device node definitions for the I2C LM75 thermal sensor on
the TQM85xx modules.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8540.dts          |    5 +++++
 arch/powerpc/boot/dts/tqm8541.dts          |    5 +++++
 arch/powerpc/boot/dts/tqm8548-bigflash.dts |    5 +++++
 arch/powerpc/boot/dts/tqm8548.dts          |    5 +++++
 arch/powerpc/boot/dts/tqm8555.dts          |    5 +++++
 arch/powerpc/boot/dts/tqm8560.dts          |    5 +++++
 6 files changed, 30 insertions(+)

Index: linux-2.6/arch/powerpc/boot/dts/tqm8548.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548.dts
@@ -85,6 +85,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
Index: linux-2.6/arch/powerpc/boot/dts/tqm8540.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8540.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8540.dts
@@ -84,6 +84,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
Index: linux-2.6/arch/powerpc/boot/dts/tqm8541.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8541.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8541.dts
@@ -83,6 +83,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
Index: linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -85,6 +85,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
Index: linux-2.6/arch/powerpc/boot/dts/tqm8555.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8555.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8555.dts
@@ -83,6 +83,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
Index: linux-2.6/arch/powerpc/boot/dts/tqm8560.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/tqm8560.dts
+++ linux-2.6/arch/powerpc/boot/dts/tqm8560.dts
@@ -85,6 +85,11 @@
 			interrupt-parent = <&mpic>;
 			dfsrr;
 
+			dtt@50 {
+				compatible = "national,lm75";
+				reg = <0x50>;
+			};
+
 			rtc@68 {
 				compatible = "dallas,ds1337";
 				reg = <0x68>;
