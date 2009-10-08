Return-Path: <dmitch71@gmail.com>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.146])
	by ozlabs.org (Postfix) with ESMTP id D8843B7B85
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  8 Oct 2009 23:50:42 +1100 (EST)
Received: by ey-out-1920.google.com with SMTP id 3so1082491eyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 08 Oct 2009 05:50:39 -0700 (PDT)
Sender: David Mitchell <dmitch71@gmail.com>
From: Dave Mitchell <dmitchell@appliedmicro.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/4xx: Add 16K FIFO size DTS entries on supported
	platforms
Message-Id: <1253079117-833-2-git-send-email-dmitchell@appliedmicro.com>
In-Reply-To: <1253079117-833-1-git-send-email-dmitchell@appliedmicro.com>
References: <1253079117-833-1-git-send-email-dmitchell@appliedmicro.com>
Cc: Dave Mitchell <dmitchell@appliedmicro.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Date: Thu, 08 Oct 2009 12:50:44 -0000

Adding tx/rx-fifo-size-gige to EMAC fields for evaluation kit DTS
files where appropriate.

Signed-off-by: Dave Mitchell <dmitchell@appliedmicro.com>
Acked-by: Prodyut Hazarika <phazarika@appliedmicro.com>
Acked-by: Victor Gallardo <vgallardo@appliedmicro.com>
Acked-by: Loc Ho <lho@appliedmicro.com>
---
 arch/powerpc/boot/dts/canyonlands.dts |    2 ++
 arch/powerpc/boot/dts/eiger.dts       |    6 ++++++
 arch/powerpc/boot/dts/glacier.dts     |    6 ++++++
 arch/powerpc/boot/dts/haleakala.dts   |    2 ++
 arch/powerpc/boot/dts/kilauea.dts     |    4 ++++
 arch/powerpc/boot/dts/makalu.dts      |    4 ++++
 arch/powerpc/boot/dts/redwood.dts     |    1 +
 7 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index c920170..cd56bb5 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -352,6 +352,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -381,6 +382,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
diff --git a/arch/powerpc/boot/dts/eiger.dts b/arch/powerpc/boot/dts/eiger.dts
index c4a934f..48bcf71 100644
--- a/arch/powerpc/boot/dts/eiger.dts
+++ b/arch/powerpc/boot/dts/eiger.dts
@@ -316,6 +316,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -345,6 +346,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -375,6 +377,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>; /* emac2&3 only */
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
@@ -403,6 +407,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>; /* emac2&3 only */
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
diff --git a/arch/powerpc/boot/dts/glacier.dts b/arch/powerpc/boot/dts/glacier.dts
index f3787a2..f6f6189 100644
--- a/arch/powerpc/boot/dts/glacier.dts
+++ b/arch/powerpc/boot/dts/glacier.dts
@@ -292,6 +292,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -321,6 +322,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -351,6 +353,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>; /* emac2&3 only */
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
@@ -379,6 +383,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>; /* emac2&3 only */
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII1>;
diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 5b2a494..2b25669 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -226,6 +226,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index c465614..083e68e 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -272,6 +272,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
@@ -300,6 +302,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index ffc246e..63d48b6 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -227,6 +227,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
+				tx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x0000003f>;	/* Start at 6 */
 				rgmii-device = <&RGMII0>;
@@ -255,6 +257,8 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+                                rx-fifo-size-gige = <16384>;
+                                tx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
diff --git a/arch/powerpc/boot/dts/redwood.dts b/arch/powerpc/boot/dts/redwood.dts
index ad402c4..d2af32e 100644
--- a/arch/powerpc/boot/dts/redwood.dts
+++ b/arch/powerpc/boot/dts/redwood.dts
@@ -226,6 +226,7 @@
 				max-frame-size = <9000>;
 				rx-fifo-size = <4096>;
 				tx-fifo-size = <2048>;
+				rx-fifo-size-gige = <16384>;
 				phy-mode = "rgmii";
 				phy-map = <0x00000000>;
 				rgmii-device = <&RGMII0>;
-- 
1.6.3.2
