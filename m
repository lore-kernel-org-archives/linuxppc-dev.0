Return-Path: <afleming@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 056A867BF8
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 05:29:49 +1000 (EST)
Date: Mon, 21 Aug 2006 14:29:28 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
	galak@kernel.crashing.org
Subject: [PATCH] Fix FEC node in 8540 ADS dts
Message-ID: <Pine.LNX.4.61.0608211427330.12614@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Fixed the FEC node, and its accompanying PHY
* Fixed a spacing issue in the PIC node
---
 arch/powerpc/boot/dts/mpc8540ads.dts |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 93d2c2d..5f41c1f 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -83,11 +83,11 @@
 				reg = <1>;
 				device_type = "ethernet-phy";
 			};
-			ethernet-phy@2 {
-				linux,phandle = <2452002>;
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
 				interrupt-parent = <40000>;
 				interrupts = <37 1>;
-				reg = <2>;
+				reg = <3>;
 				device_type = "ethernet-phy";
 			};
 		};
@@ -124,14 +124,14 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			device_type = "network";
-			model = "TSEC";
+			model = "FEC";
 			compatible = "gianfar";
 			reg = <26000 1000>;
 			address = [ 00 E0 0C 00 73 02 ];
 			local-mac-address = [ 00 E0 0C 00 73 02 ];
 			interrupts = <19 2>;
 			interrupt-parent = <40000>;
-			phy-handle = <2452002>;
+			phy-handle = <2452003>;
 		};
 
 		serial@4500 {
@@ -251,7 +251,7 @@
 			built-in;
 			compatible = "chrp,open-pic";
 			device_type = "open-pic";
-                        big-endian;
+			big-endian;
 		};
 	};
 };
-- 
2006_06_07.01.gittree_pull-dirty
