Return-Path: <Diana.Craciun@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DFE5E1400FB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Apr 2014 01:21:41 +1000 (EST)
Received: from mail44-am1 (localhost [127.0.0.1])	by mail44-am1-R.bigfish.com
 (Postfix) with ESMTP id 5D6423602FA	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 18 Apr 2014 15:20:48 +0000 (UTC)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/fsl: Updated device trees for platforms with corenet
 version 2
Date: Fri, 18 Apr 2014 18:21:10 +0300
Message-ID: <1397834470-12844-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Diana Craciun <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana Craciun <Diana.Craciun@freescale.com>

Updated the device trees according to the corenet-cf
binding definition.

Signed-off-by: Diana Craciun <Diana.Craciun@freescale.com>
---
 arch/powerpc/boot/dts/b4860emu.dts          | 2 +-
 arch/powerpc/boot/dts/fsl/b4420si-post.dtsi | 4 ----
 arch/powerpc/boot/dts/fsl/b4860si-post.dtsi | 4 ----
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 2 +-
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 2 +-
 arch/powerpc/boot/dts/t4240emu.dts          | 2 +-
 6 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/b4860emu.dts b/arch/powerpc/boot/dts/b4860emu.dts
index 7290021..e41e2a2 100644
--- a/arch/powerpc/boot/dts/b4860emu.dts
+++ b/arch/powerpc/boot/dts/b4860emu.dts
@@ -157,7 +157,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,b4-corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 0>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
index 60566f99..d678944 100644
--- a/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4420si-post.dtsi
@@ -76,10 +76,6 @@
 		compatible = "fsl,b4420-l3-cache-controller", "cache";
 	};
 
-	corenet-cf@18000 {
-		compatible = "fsl,b4420-corenet-cf";
-	};
-
 	guts: global-utilities@e0000 {
 		compatible = "fsl,b4420-device-config", "fsl,qoriq-device-config-2.0";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
index cbc354b..582381d 100644
--- a/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4860si-post.dtsi
@@ -120,10 +120,6 @@
 		compatible = "fsl,b4860-l3-cache-controller", "cache";
 	};
 
-	corenet-cf@18000 {
-		compatible = "fsl,b4860-corenet-cf";
-	};
-
 	guts: global-utilities@e0000 {
 		compatible = "fsl,b4860-device-config", "fsl,qoriq-device-config-2.0";
 	};
diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index 4f6e482..376988c 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -158,7 +158,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,b4-corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 0>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index f99d74f..c13ce99 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -343,7 +343,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl,corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
diff --git a/arch/powerpc/boot/dts/t4240emu.dts b/arch/powerpc/boot/dts/t4240emu.dts
index ee24ab3..c719dcc 100644
--- a/arch/powerpc/boot/dts/t4240emu.dts
+++ b/arch/powerpc/boot/dts/t4240emu.dts
@@ -213,7 +213,7 @@
 	};
 
 	corenet-cf@18000 {
-		compatible = "fsl,corenet-cf";
+		compatible = "fsl,corenet2-cf", "fsl, corenet-cf";
 		reg = <0x18000 0x1000>;
 		interrupts = <16 2 1 31>;
 		fsl,ccf-num-csdids = <32>;
-- 
1.7.11.7
