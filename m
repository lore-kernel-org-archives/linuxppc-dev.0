Return-Path: <galak@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/86xx: Add new LAW & MCM device tree nodes for all
	86xx systems
Date: Mon, 27 Apr 2009 12:59:48 -0500
Message-Id: <1240855188-24879-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1240855188-24879-1-git-send-email-galak@kernel.crashing.org>
References: <1240855188-24879-1-git-send-email-galak@kernel.crashing.org>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/boot/dts/gef_ppc9a.dts        |   13 +++++++++++++
 arch/powerpc/boot/dts/gef_sbc310.dts       |   13 +++++++++++++
 arch/powerpc/boot/dts/gef_sbc610.dts       |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts     |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8641_hpcn.dts     |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts |   13 +++++++++++++
 arch/powerpc/boot/dts/sbc8641d.dts         |   13 +++++++++++++
 7 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/gef_ppc9a.dts b/arch/powerpc/boot/dts/gef_ppc9a.dts
index d47ad07..cbf135c 100644
--- a/arch/powerpc/boot/dts/gef_ppc9a.dts
+++ b/arch/powerpc/boot/dts/gef_ppc9a.dts
@@ -166,6 +166,19 @@
 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c1: i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/gef_sbc310.dts b/arch/powerpc/boot/dts/gef_sbc310.dts
index 1569117..155776c 100644
--- a/arch/powerpc/boot/dts/gef_sbc310.dts
+++ b/arch/powerpc/boot/dts/gef_sbc310.dts
@@ -166,6 +166,19 @@
 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c1: i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/gef_sbc610.dts b/arch/powerpc/boot/dts/gef_sbc610.dts
index 6582dbd..6898d7e 100644
--- a/arch/powerpc/boot/dts/gef_sbc610.dts
+++ b/arch/powerpc/boot/dts/gef_sbc610.dts
@@ -131,6 +131,19 @@
 		reg = <0xfef00000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <33333333>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c1: i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 4f081bb..252db6e 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -115,6 +115,19 @@
 		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8610-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 51852e6..8bcccd7 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -117,6 +117,19 @@
 		reg = <0xffe00000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
index b5dc942..d4c909d 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn_36b.dts
@@ -110,6 +110,19 @@
 		reg = <0x0f 0xffe00000 0x0 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/sbc8641d.dts b/arch/powerpc/boot/dts/sbc8641d.dts
index cfd5782..aa8f931 100644
--- a/arch/powerpc/boot/dts/sbc8641d.dts
+++ b/arch/powerpc/boot/dts/sbc8641d.dts
@@ -129,6 +129,19 @@
 		reg = <0xf8000000 0x00001000>;	// CCSRBAR
 		bus-frequency = <0>;
 
+		mcm-law@0 {
+			compatible = "fsl,mcm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		mcm@1000 {
+			compatible = "fsl,mpc8641-mcm", "fsl,mcm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		i2c@3000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.6.0.6
