Return-Path: <Yuantian.Tang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BDE482C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 14:29:38 +1100 (EST)
From: Tang Yuantian <Yuantian.Tang@freescale.com>
To: <b07421@freescale.com>
Subject: [PATCH] powerpc: T4240: Add ina220 node in dts
Date: Tue, 21 Jan 2014 10:31:13 +0800
Message-ID: <1390271473-23661-1-git-send-email-Yuantian.Tang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <yuantian.tang@freescale.com>

Add power sensor chip ina220 node in dts to support
power monitor

Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/boot/dts/t4240qds.dts | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 63e81b0..97683f6 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -159,6 +159,48 @@
 						interrupts = <0x1 0x1 0 0>;
 					};
 				};
+
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
+
+					ina220@41 {
+						compatible = "ti,ina220";
+						reg = <0x41>;
+						shunt-resistor = <1000>;
+					};
+
+					ina220@44 {
+						compatible = "ti,ina220";
+						reg = <0x44>;
+						shunt-resistor = <1000>;
+					};
+
+					ina220@45 {
+						compatible = "ti,ina220";
+						reg = <0x45>;
+						shunt-resistor = <1000>;
+					};
+
+					ina220@46 {
+						compatible = "ti,ina220";
+						reg = <0x46>;
+						shunt-resistor = <1000>;
+					};
+
+					ina220@47 {
+						compatible = "ti,ina220";
+						reg = <0x47>;
+						shunt-resistor = <1000>;
+					};
+				};
 			};
 		};
 
-- 
1.8.0
