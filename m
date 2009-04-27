Return-Path: <galak@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/85xx: Add new LAW & MCM device tree nodes for all
	85xx systems
Date: Mon, 27 Apr 2009 15:38:45 -0500
Message-Id: <1240864725-29003-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1240864725-29003-1-git-send-email-galak@kernel.crashing.org>
References: <1240864725-29003-1-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/ksi8560.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8536ds.dts            |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8540ads.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8541cds.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8544ds.dts            |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8548cds.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8555cds.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8560ads.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8568mds.dts           |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8572ds.dts            |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8572ds_36b.dts        |   13 +++++++++++++
 arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts |   13 +++++++++++++
 arch/powerpc/boot/dts/sbc8548.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/sbc8560.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/socrates.dts             |   13 +++++++++++++
 arch/powerpc/boot/dts/stx_gp3_8560.dts         |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8540.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8541.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8548-bigflash.dts     |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8548.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8555.dts              |   13 +++++++++++++
 arch/powerpc/boot/dts/tqm8560.dts              |   13 +++++++++++++
 22 files changed, 286 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/ksi8560.dts b/arch/powerpc/boot/dts/ksi8560.dts
index c9cfd37..bdb7fc0 100644
--- a/arch/powerpc/boot/dts/ksi8560.dts
+++ b/arch/powerpc/boot/dts/ksi8560.dts
@@ -56,6 +56,19 @@
 		ranges = <0x00000000 0xfdf00000 0x00100000>;
 		bus-frequency = <0>;				/* Fixed by bootwrapper */
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index af8c64c..b6fd856 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -54,6 +54,19 @@
 		reg = <0xffe00000 0x1000>;
 		bus-frequency = <0>;		// Filled out by uboot.
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8536-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8536-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index de5535c..7c8b109 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -58,6 +58,19 @@
 		reg = <0xe0000000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8540-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index d10f5d6..de9d8b5 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -58,6 +58,19 @@
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8541-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8541-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 3ae31d7..9819d6c 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -60,6 +60,19 @@
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;		// Filled out by uboot.
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8544-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8544-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 732c111..6e40db7 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -63,6 +63,19 @@
 		reg = <0xe0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8548-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 7f9e535..6291497 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -58,6 +58,19 @@
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8555-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8555-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 190d46b..a2347b5 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -58,6 +58,19 @@
 		reg = <0xe0000000 0x200>;
 		bus-frequency = <330000000>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 3330356..d2fb639 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -65,6 +65,19 @@
 		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8568-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,8568-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 75fc30b..3f9a623 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -185,6 +185,19 @@
 		reg = <0 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8572-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds_36b.dts b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
index e2a1f75..fee17f3 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_36b.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_36b.dts
@@ -185,6 +185,19 @@
 		reg = <0xf 0xffe00000 0 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8572-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
index 45ca89e..abb1730 100644
--- a/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds_camp_core0.dts
@@ -62,6 +62,19 @@
 		reg = <0xffe00000 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <12>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8572-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8572-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/sbc8548.dts b/arch/powerpc/boot/dts/sbc8548.dts
index 196fcc1..66c9165 100644
--- a/arch/powerpc/boot/dts/sbc8548.dts
+++ b/arch/powerpc/boot/dts/sbc8548.dts
@@ -155,6 +155,19 @@
 		bus-frequency = <0>;
 		compatible = "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8548-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/sbc8560.dts b/arch/powerpc/boot/dts/sbc8560.dts
index 813d731..ff6a522 100644
--- a/arch/powerpc/boot/dts/sbc8560.dts
+++ b/arch/powerpc/boot/dts/sbc8560.dts
@@ -60,6 +60,19 @@
 		reg = <0xff700000 0x00100000>;
 		clock-frequency = <0>;
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8560-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/socrates.dts b/arch/powerpc/boot/dts/socrates.dts
index e8f4e46..779876a 100644
--- a/arch/powerpc/boot/dts/socrates.dts
+++ b/arch/powerpc/boot/dts/socrates.dts
@@ -59,6 +59,19 @@
 		bus-frequency = <0>;		// Filled in by U-Boot
 		compatible = "fsl,mpc8544-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8544-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8544-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index 8691dd3..ce35e89 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -56,6 +56,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index c8265b6..5e9eecc 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -58,6 +58,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8540-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8540-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 9080546..3c8d5c1 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -57,6 +57,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8541-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8541-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8548-bigflash.dts b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
index 1139eb5..435d2b2 100644
--- a/arch/powerpc/boot/dts/tqm8548-bigflash.dts
+++ b/arch/powerpc/boot/dts/tqm8548-bigflash.dts
@@ -59,6 +59,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8548-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8548-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8548.dts b/arch/powerpc/boot/dts/tqm8548.dts
index d337d83..3b8af5b 100644
--- a/arch/powerpc/boot/dts/tqm8548.dts
+++ b/arch/powerpc/boot/dts/tqm8548.dts
@@ -59,6 +59,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8548-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <10>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8548-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8548-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index 021039b..a820bbe 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -57,6 +57,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8555-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8555-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index cec84c2..fa73550 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -59,6 +59,19 @@
 		bus-frequency = <0>;
 		compatible = "fsl,mpc8560-immr", "simple-bus";
 
+		ecm-law@0 {
+			compatible = "fsl,ecm-law";
+			reg = <0x0 0x1000>;
+			fsl,num-laws = <8>;
+		};
+
+		ecm@1000 {
+			compatible = "fsl,mpc8560-ecm", "fsl,ecm";
+			reg = <0x1000 0x1000>;
+			interrupts = <17 2>;
+			interrupt-parent = <&mpic>;
+		};
+
 		memory-controller@2000 {
 			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
-- 
1.6.0.6
