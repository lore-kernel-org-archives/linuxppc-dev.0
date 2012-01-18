Return-Path: <B31383@freescale.com>
From: Ramneek Mehresh <ramneek.mehresh@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/85xx:Add usb controller version info
Date: Wed, 18 Jan 2012 11:10:48 +0530
Message-ID: <1326865248-3333-1-git-send-email-ramneek.mehresh@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: devicetree-discuss@lists.ozlabs.org,
 Ramneek Mehresh <ramneek.mehresh@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add usb controller version info for the following:
MPC8536, P1010, P1020, P1021, P1022, P1023, P2020, P2041,
P3041, P3060, P5020

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
---
Applies on git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
(branch next)

 arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi |    4 ++--
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi   |    3 +++
 arch/powerpc/boot/dts/fsl/p1020si-post.dtsi   |    6 ++++++
 arch/powerpc/boot/dts/fsl/p1021si-post.dtsi   |    3 +++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi   |    6 ++++++
 arch/powerpc/boot/dts/fsl/p1023si-post.dtsi   |    3 +++
 arch/powerpc/boot/dts/fsl/p2020si-post.dtsi   |    3 +++
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi   |    2 ++
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi   |    2 ++
 arch/powerpc/boot/dts/fsl/p3060si-post.dtsi   |    6 ++++++
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi   |    2 ++
 11 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
index 89af626..88026e5 100644
--- a/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/mpc8536si-post.dtsi
@@ -202,7 +202,7 @@
 /include/ "pq3-etsec1-timer-0.dtsi"
 
 	usb@22000 {
-		compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+		compatible = "fsl-usb2-mph-v1.2", "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
 		reg = <0x22000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -210,7 +210,7 @@
 	};
 
 	usb@23000 {
-		compatible = "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
+		compatible = "fsl-usb2-mph-v1.2", "fsl,mpc8536-usb2-mph", "fsl-usb2-mph";
 		reg = <0x23000 0x1000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
index bd9e163..8245931 100644
--- a/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1010si-post.dtsi
@@ -156,6 +156,9 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
 		fsl,sdhci-auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
index fc924c5..10c75ca 100644
--- a/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1020si-post.dtsi
@@ -142,7 +142,13 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 /include/ "pq3-usb2-dr-1.dtsi"
+	usb@23000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 
 /include/ "pq3-esdhc-0.dtsi"
 /include/ "pq3-sec3.3-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
index 38ba54d..f157ffd 100644
--- a/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1021si-post.dtsi
@@ -142,6 +142,9 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 
 /include/ "pq3-esdhc-0.dtsi"
 /include/ "pq3-sec3.3-0.dtsi"
diff --git a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
index 16239b1..acb933e 100644
--- a/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1022si-post.dtsi
@@ -199,7 +199,13 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 /include/ "pq3-usb2-dr-1.dtsi"
+	usb@23000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 
 /include/ "pq3-esdhc-0.dtsi"
 	sdhc@2e000 {
diff --git a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
index b06bb4c..941fa15 100644
--- a/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p1023si-post.dtsi
@@ -142,6 +142,9 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 
 	crypto: crypto@300000 {
 		compatible = "fsl,sec-v4.2", "fsl,sec-v4.0";
diff --git a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
index c041050..6772299 100644
--- a/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2020si-post.dtsi
@@ -171,6 +171,9 @@
 
 /include/ "pq3-dma-0.dtsi"
 /include/ "pq3-usb2-dr-0.dtsi"
+	usb@22000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl-usb2-dr";
+	};
 /include/ "pq3-etsec1-0.dtsi"
 /include/ "pq3-etsec1-timer-0.dtsi"
 
diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index 234a399..531eab8 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -309,12 +309,14 @@
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
 		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
 			phy_type = "utmi";
 			port0;
 		};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
 		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
 			dr_mode = "host";
 			phy_type = "utmi";
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index d41d08d..af4ebc8 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -336,12 +336,14 @@
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
 		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v1.6", "fsl-usb2-mph";
 			phy_type = "utmi";
 			port0;
 		};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
 		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
 			dr_mode = "host";
 			phy_type = "utmi";
 		};
diff --git a/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
index a63edd1..b3e5692 100644
--- a/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3060si-post.dtsi
@@ -291,6 +291,12 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
+	usb@210000 {
+		compatible = "fsl-usb2-mph-v2.2", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+	};
 /include/ "qoriq-usb2-dr-0.dtsi"
+	usb@211000 {
+		compatible = "fsl-usb2-dr-v2.2", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+	};
 /include/ "qoriq-sec4.1-0.dtsi"
 };
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 914074b..64b6abe 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -339,12 +339,14 @@
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
 		usb0: usb@210000 {
+			compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
 			phy_type = "utmi";
 			port0;
 		};
 
 /include/ "qoriq-usb2-dr-0.dtsi"
 		usb1: usb@211000 {
+			compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
 			dr_mode = "host";
 			phy_type = "utmi";
 		};
-- 
1.7.1
