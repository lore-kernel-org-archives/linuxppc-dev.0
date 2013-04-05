Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BF7C2C00C4
 for <linuxppc-dev@ozlabs.org>; Sat,  6 Apr 2013 01:21:04 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r35EKx1q007294
 for <linuxppc-dev@ozlabs.org>; Fri, 5 Apr 2013 09:21:00 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Fix cpu unit address to match reg on
Date: Fri,  5 Apr 2013 09:20:59 -0500
Message-Id: <1365171659-15376-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
index 9b39a43..a93c55a 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi
@@ -69,57 +69,57 @@
 			reg = <0 1>;
 			next-level-cache = <&L2_1>;
 		};
-		cpu1: PowerPC,e6500@1 {
+		cpu1: PowerPC,e6500@2 {
 			device_type = "cpu";
 			reg = <2 3>;
 			next-level-cache = <&L2_1>;
 		};
-		cpu2: PowerPC,e6500@2 {
+		cpu2: PowerPC,e6500@4 {
 			device_type = "cpu";
 			reg = <4 5>;
 			next-level-cache = <&L2_1>;
 		};
-		cpu3: PowerPC,e6500@3 {
+		cpu3: PowerPC,e6500@6 {
 			device_type = "cpu";
 			reg = <6 7>;
 			next-level-cache = <&L2_1>;
 		};
-		cpu4: PowerPC,e6500@4 {
+		cpu4: PowerPC,e6500@8 {
 			device_type = "cpu";
 			reg = <8 9>;
 			next-level-cache = <&L2_2>;
 		};
-		cpu5: PowerPC,e6500@5 {
+		cpu5: PowerPC,e6500@10 {
 			device_type = "cpu";
 			reg = <10 11>;
 			next-level-cache = <&L2_2>;
 		};
-		cpu6: PowerPC,e6500@6 {
+		cpu6: PowerPC,e6500@12 {
 			device_type = "cpu";
 			reg = <12 13>;
 			next-level-cache = <&L2_2>;
 		};
-		cpu7: PowerPC,e6500@7 {
+		cpu7: PowerPC,e6500@14 {
 			device_type = "cpu";
 			reg = <14 15>;
 			next-level-cache = <&L2_2>;
 		};
-		cpu8: PowerPC,e6500@8 {
+		cpu8: PowerPC,e6500@16 {
 			device_type = "cpu";
 			reg = <16 17>;
 			next-level-cache = <&L2_3>;
 		};
-		cpu9: PowerPC,e6500@9 {
+		cpu9: PowerPC,e6500@18 {
 			device_type = "cpu";
 			reg = <18 19>;
 			next-level-cache = <&L2_3>;
 		};
-		cpu10: PowerPC,e6500@10 {
+		cpu10: PowerPC,e6500@20 {
 			device_type = "cpu";
 			reg = <20 21>;
 			next-level-cache = <&L2_3>;
 		};
-		cpu11: PowerPC,e6500@11 {
+		cpu11: PowerPC,e6500@22 {
 			device_type = "cpu";
 			reg = <22 23>;
 			next-level-cache = <&L2_3>;
-- 
1.7.9.7
