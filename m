Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 43F742C00C0
 for <linuxppc-dev@ozlabs.org>; Wed, 10 Apr 2013 00:53:49 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r39Erhfe017777
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Apr 2013 09:53:44 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl-booke: Minor fixes to T4240 Si device tree
Date: Tue,  9 Apr 2013 09:53:43 -0500
Message-Id: <1365519223-2450-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Fix cpu unit address to match reg
* Update compatible for rcpm & clockgen to be 2.0 instead of 2

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi |    4 ++--
 arch/powerpc/boot/dts/fsl/t4240si-pre.dtsi  |   22 +++++++++++-----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index 1d72926..e77e6ad 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -364,12 +364,12 @@
 	};
 
 	clockgen: global-utilities@e1000 {
-		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2";
+		compatible = "fsl,t4240-clockgen", "fsl,qoriq-clockgen-2.0";
 		reg = <0xe1000 0x1000>;
 	};
 
 	rcpm: global-utilities@e2000 {
-		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2";
+		compatible = "fsl,t4240-rcpm", "fsl,qoriq-rcpm-2.0";
 		reg = <0xe2000 0x1000>;
 	};
 
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
