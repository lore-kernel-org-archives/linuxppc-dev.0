Return-Path: <haokexin@gmail.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail1.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A00902C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2013 15:40:22 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/fsl-booke: add the reg property for pci bridge device
 node for t4/b4xx boards
Date: Sun, 14 Apr 2013 13:40:13 +0800
Message-ID: <1365918013-12190-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The reg property in the pci bridge device node is used to bind this
device node to the pci bridge device. Then all the pci devices under
this bridge could use the interrupt maps defined in this device node
to do the irq translation. So if this property is missed, the pci
traditional irq mechanism will not work.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/boot/dts/fsl/b4si-post.dtsi    | 1 +
 arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
index c3e553a..7399154 100644
--- a/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/b4si-post.dtsi
@@ -53,6 +53,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		reg = <0 0 0 0 0>;
 		interrupts = <20 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
index e77e6ad..bd611a9 100644
--- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
@@ -52,6 +52,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		reg = <0 0 0 0 0>;
 		interrupts = <20 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -77,6 +78,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		reg = <0 0 0 0 0>;
 		interrupts = <21 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -102,6 +104,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		reg = <0 0 0 0 0>;
 		interrupts = <22 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
@@ -127,6 +130,7 @@
 		#size-cells = <2>;
 		#address-cells = <3>;
 		device_type = "pci";
+		reg = <0 0 0 0 0>;
 		interrupts = <23 2 0 0>;
 		interrupt-map-mask = <0xf800 0 0 7>;
 		interrupt-map = <
-- 
1.8.1.4
