Return-Path: <hongtao.jia@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0123.outbound.protection.outlook.com [207.46.100.123])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BE9FD1A042E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Nov 2014 18:32:35 +1100 (AEDT)
From: Jia Hongtao <hongtao.jia@freescale.com>
To: <galak@codeaurora.org>, <scottwood@freescale.com>
Subject: [PATCH 1/2] powerpc: Add ADT7461 to device tree for supported boards
Date: Wed, 5 Nov 2014 14:59:52 +0800
Message-ID: <1415170793-13196-1-git-send-email-hongtao.jia@freescale.com>
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

Including: T104xRDB T208xQDS B4QDS

Signed-off-by: Jia Hongtao <hongtao.jia@freescale.com>
---
 arch/powerpc/boot/dts/b4qds.dtsi    | 11 +++++++++++
 arch/powerpc/boot/dts/t104xrdb.dtsi |  7 +++++++
 arch/powerpc/boot/dts/t208xqds.dtsi | 11 +++++++++++
 3 files changed, 29 insertions(+)

diff --git a/arch/powerpc/boot/dts/b4qds.dtsi b/arch/powerpc/boot/dts/b4qds.dtsi
index 8b47edc..bccc986 100644
--- a/arch/powerpc/boot/dts/b4qds.dtsi
+++ b/arch/powerpc/boot/dts/b4qds.dtsi
@@ -152,6 +152,17 @@
 						reg = <0x68>;
 					};
 				};
+
+				i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x3>;
+
+					adt7461@4c {
+						compatible = "adi,adt7461";
+						reg = <0x4c>;
+					};
+				};
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/t104xrdb.dtsi b/arch/powerpc/boot/dts/t104xrdb.dtsi
index 1cf0f3c..187add8 100644
--- a/arch/powerpc/boot/dts/t104xrdb.dtsi
+++ b/arch/powerpc/boot/dts/t104xrdb.dtsi
@@ -83,6 +83,13 @@
 			};
 		};
 
+		i2c@118000 {
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
+		};
+
 		i2c@118100 {
 			pca9546@77 {
 				compatible = "nxp,pca9546";
diff --git a/arch/powerpc/boot/dts/t208xqds.dtsi b/arch/powerpc/boot/dts/t208xqds.dtsi
index 555dc6e..5906183 100644
--- a/arch/powerpc/boot/dts/t208xqds.dtsi
+++ b/arch/powerpc/boot/dts/t208xqds.dtsi
@@ -169,6 +169,17 @@
 						shunt-resistor = <1000>;
 					};
 				};
+
+				i2c@3 {
+					#address-cells = <1>;
+					#size-cells = <0>;
+					reg = <0x3>;
+
+					adt7461@4c {
+						compatible = "adi,adt7461";
+						reg = <0x4c>;
+					};
+				};
 			};
 		};
 
-- 
2.1.0.27.g96db324
