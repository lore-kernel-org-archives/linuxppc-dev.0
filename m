Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97459B6F83
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 05:26:19 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p81JQFbi010083
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Sep 2011 14:26:16 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match other
	e500mc based .dts
Date: Thu,  1 Sep 2011 14:26:15 -0500
Message-Id: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The P4080 silicon device tree was using PowerPC,4080 while the other
e500mc based SoCs used PowerPC,e500mc.  Use the core name to be
consistent going forward.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/p4080si.dtsi |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080si.dtsi b/arch/powerpc/boot/dts/p4080si.dtsi
index b71051f..4984edb 100644
--- a/arch/powerpc/boot/dts/p4080si.dtsi
+++ b/arch/powerpc/boot/dts/p4080si.dtsi
@@ -77,7 +77,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu0: PowerPC,4080@0 {
+		cpu0: PowerPC,e500mc@0 {
 			device_type = "cpu";
 			reg = <0>;
 			next-level-cache = <&L2_0>;
@@ -85,7 +85,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu1: PowerPC,4080@1 {
+		cpu1: PowerPC,e500mc@1 {
 			device_type = "cpu";
 			reg = <1>;
 			next-level-cache = <&L2_1>;
@@ -93,7 +93,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu2: PowerPC,4080@2 {
+		cpu2: PowerPC,e500mc@2 {
 			device_type = "cpu";
 			reg = <2>;
 			next-level-cache = <&L2_2>;
@@ -101,7 +101,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu3: PowerPC,4080@3 {
+		cpu3: PowerPC,e500mc@3 {
 			device_type = "cpu";
 			reg = <3>;
 			next-level-cache = <&L2_3>;
@@ -109,7 +109,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu4: PowerPC,4080@4 {
+		cpu4: PowerPC,e500mc@4 {
 			device_type = "cpu";
 			reg = <4>;
 			next-level-cache = <&L2_4>;
@@ -117,7 +117,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu5: PowerPC,4080@5 {
+		cpu5: PowerPC,e500mc@5 {
 			device_type = "cpu";
 			reg = <5>;
 			next-level-cache = <&L2_5>;
@@ -125,7 +125,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu6: PowerPC,4080@6 {
+		cpu6: PowerPC,e500mc@6 {
 			device_type = "cpu";
 			reg = <6>;
 			next-level-cache = <&L2_6>;
@@ -133,7 +133,7 @@
 				next-level-cache = <&cpc>;
 			};
 		};
-		cpu7: PowerPC,4080@7 {
+		cpu7: PowerPC,e500mc@7 {
 			device_type = "cpu";
 			reg = <7>;
 			next-level-cache = <&L2_7>;
-- 
1.7.3.4
