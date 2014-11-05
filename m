Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0124.outbound.protection.outlook.com [207.46.100.124])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3E6081A0198
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 18:15:34 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <galak@codeaurora.org>, <scottwood@freescale.com>
Subject: [PATCH 2/2] powerpc: Add INA220 to device tree for supported boards
Date: Wed, 5 Nov 2014 14:59:53 +0800
Message-ID: <1415170793-13196-2-git-send-email-hongtao.jia@freescale.com>
In-Reply-To: <1415170793-13196-1-git-send-email-hongtao.jia@freescale.com>
References: <1415170793-13196-1-git-send-email-hongtao.jia@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: hongtao.jia@freescale.com, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Including: P3041DS P5020DS P5040DS B4QDS

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/boot/dts/b4qds.dtsi  | 12 ++++++++++++
 arch/powerpc/boot/dts/p3041ds.dts | 20 ++++++++++++++++++++
 arch/powerpc/boot/dts/p5020ds.dts | 20 ++++++++++++++++++++
 arch/powerpc/boot/dts/p5040ds.dts | 20 ++++++++++++++++++++
 4 files changed, 72 insertions(+)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index bccc986..e5bde0b 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -153,6 +153,18 @@
 					};
 				};
 
+				i2c@2 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x2>;
+
+					ina220@40 {
+						compatible = "ti,ina220";
+						reg = <0x40>;
+						shunt-resistor = <1000>;
+					};
+				};
+
 				i2c@3 {
 					#address-cells = <1>;
 					#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 2fed3bc..394ea9c 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -98,6 +98,26 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+			ina220@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+			ina220@44 {
+				compatible = "ti,ina220";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+			ina220@45 {
+				compatible = "ti,ina220";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 			adt7461@4c {
 				compatible = "adi,adt7461";
 				reg = <0x4c>;
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 2869fea..b7f3057 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -98,6 +98,26 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+			ina220@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+			ina220@44 {
+				compatible = "ti,ina220";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+			ina220@45 {
+				compatible = "ti,ina220";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 			adt7461@4c {
 				compatible = "adi,adt7461";
 				reg = <0x4c>;
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index 860b5cc..7e04bf4 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -95,6 +95,26 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			ina220@40 {
+				compatible = "ti,ina220";
+				reg = <0x40>;
+				shunt-resistor = <1000>;
+			};
+			ina220@41 {
+				compatible = "ti,ina220";
+				reg = <0x41>;
+				shunt-resistor = <1000>;
+			};
+			ina220@44 {
+				compatible = "ti,ina220";
+				reg = <0x44>;
+				shunt-resistor = <1000>;
+			};
+			ina220@45 {
+				compatible = "ti,ina220";
+				reg = <0x45>;
+				shunt-resistor = <1000>;
+			};
 			adt7461@4c {
 				compatible = "adi,adt7461";
 				reg = <0x4c>;
-- 
2.1.0.27.g96db324
