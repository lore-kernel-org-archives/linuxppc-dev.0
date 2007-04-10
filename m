Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 90853DDFDA
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 07:56:52 +1000 (EST)
Date: Tue, 10 Apr 2007 16:56:45 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] powerpc: replace undocumented interface properties with
	max-speed and interface-type equivalents
Message-Id: <20070410165645.3ece46f9.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
please consider for 2.6.22

 arch/powerpc/boot/dts/mpc832x_mds.dts |    6 ++++--
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    6 ++++--
 arch/powerpc/boot/dts/mpc836x_mds.dts |    6 ++++--
 arch/powerpc/boot/dts/mpc8568mds.dts  |    8 ++++----
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index c798491..a75a35a 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -273,6 +273,8 @@
 			interrupts = <22>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 04 9f 00 23 23 ];
+			interface-type = "mii";
+			max-speed = <d#100>;
 			rx-clock = <19>;
 			tx-clock = <1a>;
 			phy-handle = < &phy3 >;
@@ -288,6 +290,8 @@
 			interrupts = <23>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 11 22 33 44 55 ];
+			interface-type = "mii";
+			max-speed = <d#100>;
 			rx-clock = <17>;
 			tx-clock = <18>;
 			phy-handle = < &phy4 >;
@@ -306,14 +310,12 @@
 				interrupts = <11 8>;
 				reg = <3>;
 				device_type = "ethernet-phy";
-				interface = <3>; //ENET_100_MII
 			};
 			phy4: ethernet-phy@04 {
 				interrupt-parent = < &ipic >;
 				interrupts = <12 8>;
 				reg = <4>;
 				device_type = "ethernet-phy";
-				interface = <3>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b55bced..e0aebd9 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -232,6 +232,8 @@
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 04 9f ef 03 02 ];
+			interface-type = "mii";
+			max-speed = <d#100>;
 			rx-clock = <20>;
 			tx-clock = <13>;
 			phy-handle = <&phy00>;
@@ -247,6 +249,8 @@
 			interrupts = <22>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 04 9f ef 03 01 ];
+			interface-type = "mii";
+			max-speed = <d#100>;
 			rx-clock = <19>;
 			tx-clock = <1a>;
 			phy-handle = <&phy04>;
@@ -265,14 +269,12 @@
 				interrupts = <0>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <3>; //ENET_100_MII
 			};
 			phy04:ethernet-phy@04 {
 				interrupt-parent = <&pic>;
 				interrupts = <0>;
 				reg = <4>;
 				device_type = "ethernet-phy";
-				interface = <3>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 7f578eb..0f9a3af 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -302,6 +302,8 @@
 			interrupts = <20>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 04 9f 00 23 23 ];
+			interface-type = "rgmii";
+			max-speed = <d#1000>;
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = < &phy0 >;
@@ -317,6 +319,8 @@
 			interrupts = <21>;
 			interrupt-parent = < &qeic >;
 			mac-address = [ 00 11 22 33 44 55 ];
+			interface-type = "rgmii";
+			max-speed = <d#1000>;
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = < &phy1 >;
@@ -335,14 +339,12 @@
 				interrupts = <11 8>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			phy1: ethernet-phy@01 {
 				interrupt-parent = < &ipic >;
 				interrupts = <12 8>;
 				reg = <1>;
 				device_type = "ethernet-phy";
-				interface = <6>;
 			};
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 7361b36..9421423 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -285,6 +285,8 @@
 			interrupts = <20>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 04 9f 00 23 23 ];
+			interface-type = "gmii";
+			max-speed = <d#1000>;
 			rx-clock = <0>;
 			tx-clock = <19>;
 			phy-handle = <&qe_phy0>;
@@ -300,6 +302,8 @@
 			interrupts = <21>;
 			interrupt-parent = <&qeic>;
 			mac-address = [ 00 11 22 33 44 55 ];
+			interface-type = "gmii";
+			max-speed = <d#1000>;
 			rx-clock = <0>;
 			tx-clock = <14>;
 			phy-handle = <&qe_phy1>;
@@ -320,28 +324,24 @@
 				interrupts = <31 1>;
 				reg = <0>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			qe_phy1: ethernet-phy@01 {
 				interrupt-parent = <&mpic>;
 				interrupts = <32 1>;
 				reg = <1>;
 				device_type = "ethernet-phy";
-				interface = <6>;
 			};
 			qe_phy2: ethernet-phy@02 {
 				interrupt-parent = <&mpic>;
 				interrupts = <31 1>;
 				reg = <2>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 			qe_phy3: ethernet-phy@03 {
 				interrupt-parent = <&mpic>;
 				interrupts = <32 1>;
 				reg = <3>;
 				device_type = "ethernet-phy";
-				interface = <6>; //ENET_1000_GMII
 			};
 		};
 
-- 
1.5.0.1
