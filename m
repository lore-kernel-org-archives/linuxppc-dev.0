Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B4A21DDDD4
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Sep 2008 13:06:16 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8O36B3U024103
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 22:06:12 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/83xx: Add missing cell-index to dma-channel device
	nodes
Date: Tue, 23 Sep 2008 22:06:11 -0500
Message-Id: <1222225571-3104-1-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/boot/dts/asp834x-redboot.dts |    4 ++++
 arch/powerpc/boot/dts/mpc8313erdb.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8315erdb.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc832x_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    4 ++++
 arch/powerpc/boot/dts/mpc8349emitxgp.dts  |    4 ++++
 arch/powerpc/boot/dts/mpc834x_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc836x_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc836x_rdk.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8377_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8377_rdb.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8378_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8378_rdb.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8379_mds.dts     |    4 ++++
 arch/powerpc/boot/dts/mpc8379_rdb.dts     |    4 ++++
 arch/powerpc/boot/dts/sbc8349.dts         |    4 ++++
 17 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/asp834x-redboot.dts b/arch/powerpc/boot/dts/asp834x-redboot.dts
index 8b1bb0e..6235fca 100644
--- a/arch/powerpc/boot/dts/asp834x-redboot.dts
+++ b/arch/powerpc/boot/dts/asp834x-redboot.dts
@@ -130,24 +130,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8347-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 2a94ae0..5390855 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -176,24 +176,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index f704513..94c9b41 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -144,24 +144,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8315-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index fbc9304..015808a 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -127,24 +127,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b157d18..b5b0ec2 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -105,24 +105,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8323-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 700e076..1327a61 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -106,24 +106,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index cdd3063..f70d3a0 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -104,24 +104,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 783241c..e29739e 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -116,24 +116,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index ada8446..49aec71 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -148,24 +148,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 89c9202..69c9bd2 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -125,24 +125,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8360-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 432782b..78f0f11 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -246,24 +246,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <0x47 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <0x47 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <0x47 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <0x47 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index ed137aa..d46327e 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -155,24 +155,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index ed32c8d..c44f30f 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -170,24 +170,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 34a7f2f..b3e3bd7 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -155,24 +155,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8378-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index f4db9ed..653ed47 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -170,24 +170,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index e4d7030..123c8df 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -155,24 +155,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8379-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 45f789b..c7f411f 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -107,24 +107,28 @@
 			dma-channel@0 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				cell-index = <0>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@80 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				cell-index = <1>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@100 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				cell-index = <2>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
 			dma-channel@180 {
 				compatible = "fsl,mpc8349-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				cell-index = <3>;
 				interrupt-parent = <&ipic>;
 				interrupts = <71 8>;
 			};
-- 
1.5.5.1
