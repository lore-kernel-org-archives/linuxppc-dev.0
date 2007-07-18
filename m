Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B4A4FDDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 11:33:04 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6I1WwQN018432
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 18:32:58 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.83.16.18])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6I1Wv6A001127
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:32:57 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l6I18Gl2007814
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:08:16 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id D061CAEFC9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 20:32:56 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l6I1WulW015247
	for linuxppc-dev@ozlabs.org; Tue, 17 Jul 2007 20:32:56 -0500
Date: Tue, 17 Jul 2007 20:32:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 02/61] mpc8272ads.dts: Whitespace cleanup
Message-ID: <20070718013256.GA15238@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Convert spaces to tabs, and add a few newlines where appropriate.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8272ads.dts |  376 +++++++++++++++++-----------------
 1 files changed, 189 insertions(+), 187 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 1934b80..4d09dca 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -10,207 +10,209 @@
  */
 
 / {
-       model = "MPC8272ADS";
-       compatible = "MPC8260ADS";
-       #address-cells = <1>;
-       #size-cells = <1>;
-
-       cpus {
-               #address-cells = <1>;
-               #size-cells = <0>;
-
-               PowerPC,8272@0 {
-                       device_type = "cpu";
-                       reg = <0>;
-                       d-cache-line-size = <20>;       // 32 bytes
-                       i-cache-line-size = <20>;       // 32 bytes
-                       d-cache-size = <4000>;          // L1, 16K
-                       i-cache-size = <4000>;          // L1, 16K
-                       timebase-frequency = <0>;
-                       bus-frequency = <0>;
-                       clock-frequency = <0>;
-                       32-bit;
-               };
-       };
-
-		pci_pic: interrupt-controller@f8200000 {
-               #address-cells = <0>;
-               #interrupt-cells = <2>;
-               interrupt-controller;
-               reg = <f8200000 f8200004>;
-               built-in;
-               device_type = "pci-pic";
-       };
-       memory {
-               device_type = "memory";
-               reg = <00000000 4000000 f4500000 00000020>;
-       };
-
-       chosen {
-               name = "chosen";
-               linux,platform = <0>;
+	model = "MPC8272ADS";
+	compatible = "MPC8260ADS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8272@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;       // 32 bytes
+			i-cache-line-size = <20>;       // 32 bytes
+			d-cache-size = <4000>;          // L1, 16K
+			i-cache-size = <4000>;          // L1, 16K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+		};
+	};
+
+	pci_pic: interrupt-controller@f8200000 {
+		#address-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <f8200000 f8200004>;
+		built-in;
+		device_type = "pci-pic";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 4000000 f4500000 00000020>;
+	};
+
+	chosen {
+		name = "chosen";
+		linux,platform = <0>;
 		interrupt-controller = <&Cpm_pic>;
-       };
-
-       soc8272@f0000000 {
-               #address-cells = <1>;
-               #size-cells = <1>;
-               #interrupt-cells = <2>;
-               device_type = "soc";
-               ranges = <00000000 f0000000 00053000>;
-               reg = <f0000000 10000>;
-
-               mdio@0 {
-                       device_type = "mdio";
-                       compatible = "fs_enet";
-                       reg = <0 0>;
-                       #address-cells = <1>;
-                       #size-cells = <0>;
+	};
+
+	soc8272@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <00000000 f0000000 00053000>;
+		reg = <f0000000 10000>;
+
+		mdio@0 {
+			device_type = "mdio";
+			compatible = "fs_enet";
+			reg = <0 0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
 			phy0:ethernet-phy@0 {
 				interrupt-parent = <&Cpm_pic>;
-                               interrupts = <17 4>;
-                               reg = <0>;
-                               bitbang = [ 12 12 13 02 02 01 ];
-                               device_type = "ethernet-phy";
-                       };
+				interrupts = <17 4>;
+				reg = <0>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				device_type = "ethernet-phy";
+			};
+
 			phy1:ethernet-phy@1 {
 				interrupt-parent = <&Cpm_pic>;
-                               interrupts = <17 4>;
-                               bitbang = [ 12 12 13 02 02 01 ];
-                               reg = <3>;
-                               device_type = "ethernet-phy";
-                       };
-               };
-
-               ethernet@24000 {
-                       #address-cells = <1>;
-                       #size-cells = <0>;
-                       device_type = "network";
-                       device-id = <1>;
-                       compatible = "fs_enet";
-                       model = "FCC";
-                       reg = <11300 20 8400 100 11380 30>;
-                       mac-address = [ 00 11 2F 99 43 54 ];
-                       interrupts = <20 2>;
+				interrupts = <17 4>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			device-id = <1>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11300 20 8400 100 11380 30>;
+			mac-address = [ 00 11 2F 99 43 54 ];
+			interrupts = <20 2>;
 			interrupt-parent = <&Cpm_pic>;
 			phy-handle = <&Phy0>;
-                       rx-clock = <13>;
-                       tx-clock = <12>;
-               };
-
-               ethernet@25000 {
-                       device_type = "network";
-                       device-id = <2>;
-                       compatible = "fs_enet";
-                       model = "FCC";
-                       reg = <11320 20 8500 100 113b0 30>;
-                       mac-address = [ 00 11 2F 99 44 54 ];
-                       interrupts = <21 2>;
+			rx-clock = <13>;
+			tx-clock = <12>;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			device-id = <2>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11320 20 8500 100 113b0 30>;
+			mac-address = [ 00 11 2F 99 44 54 ];
+			interrupts = <21 2>;
 			interrupt-parent = <&Cpm_pic>;
 			phy-handle = <&Phy1>;
-                       rx-clock = <17>;
-                       tx-clock = <18>;
-               };
-
-               cpm@f0000000 {
-                       #address-cells = <1>;
-                       #size-cells = <1>;
-                       #interrupt-cells = <2>;
-                       device_type = "cpm";
-                       model = "CPM2";
-                       ranges = <00000000 00000000 20000>;
-                       reg = <0 20000>;
-                       command-proc = <119c0>;
-                       brg-frequency = <17D7840>;
-                       cpm_clk = <BEBC200>;
-
-                       scc@11a00 {
-                               device_type = "serial";
-                               compatible = "cpm_uart";
-                               model = "SCC";
-                               device-id = <1>;
-                               reg = <11a00 20 8000 100>;
-                               current-speed = <1c200>;
-                               interrupts = <28 2>;
+			rx-clock = <17>;
+			tx-clock = <18>;
+		};
+
+		cpm@f0000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM2";
+			ranges = <00000000 00000000 20000>;
+			reg = <0 20000>;
+			command-proc = <119c0>;
+			brg-frequency = <17D7840>;
+			cpm_clk = <BEBC200>;
+
+			scc@11a00 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <1>;
+				reg = <11a00 20 8000 100>;
+				current-speed = <1c200>;
+				interrupts = <28 2>;
 				interrupt-parent = <&Cpm_pic>;
-                               clock-setup = <0 00ffffff>;
-                               rx-clock = <1>;
-                               tx-clock = <1>;
-                       };
-
-                       scc@11a60 {
-                               device_type = "serial";
-                               compatible = "cpm_uart";
-                               model = "SCC";
-                               device-id = <4>;
-                               reg = <11a60 20 8300 100>;
-                               current-speed = <1c200>;
-                               interrupts = <2b 2>;
+				clock-setup = <0 00ffffff>;
+				rx-clock = <1>;
+				tx-clock = <1>;
+			};
+
+			scc@11a60 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <4>;
+				reg = <11a60 20 8300 100>;
+				current-speed = <1c200>;
+				interrupts = <2b 2>;
 				interrupt-parent = <&Cpm_pic>;
-                               clock-setup = <1b ffffff00>;
-                               rx-clock = <4>;
-                               tx-clock = <4>;
-                       };
-
-               };
-			cpm_pic:interrupt-controller@10c00 {
-                       #address-cells = <0>;
-                       #interrupt-cells = <2>;
-                       interrupt-controller;
-                       reg = <10c00 80>;
-                       built-in;
-                       device_type = "cpm-pic";
-		       compatible = "CPM2";
-               };
-               pci@0500 {
-                       #interrupt-cells = <1>;
-                       #size-cells = <2>;
-                       #address-cells = <3>;
-                       compatible = "8272";
-                       device_type = "pci";
-                       reg = <10430 4dc>;
-                       clock-frequency = <3f940aa>;
-                       interrupt-map-mask = <f800 0 0 7>;
-                       interrupt-map = <
-
-                                       /* IDSEL 0x16 */
-                                        b000 0 0 1 f8200000 40 8
-                                        b000 0 0 2 f8200000 41 8
-                                        b000 0 0 3 f8200000 42 8
-                                        b000 0 0 4 f8200000 43 8
-
-                                       /* IDSEL 0x17 */
-                                        b800 0 0 1 f8200000 43 8
-                                        b800 0 0 2 f8200000 40 8
-                                        b800 0 0 3 f8200000 41 8
-                                        b800 0 0 4 f8200000 42 8
-
-                                       /* IDSEL 0x18 */
-                                        c000 0 0 1 f8200000 42 8
-                                        c000 0 0 2 f8200000 43 8
-                                        c000 0 0 3 f8200000 40 8
-                                        c000 0 0 4 f8200000 41 8>;
+				clock-setup = <1b ffffff00>;
+				rx-clock = <4>;
+				tx-clock = <4>;
+			};
+		};
+
+		cpm_pic:interrupt-controller@10c00 {
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <10c00 80>;
+			built-in;
+			device_type = "cpm-pic";
+			compatible = "CPM2";
+		};
+
+		pci@0500 {
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "8272";
+			device_type = "pci";
+			reg = <10430 4dc>;
+			clock-frequency = <3f940aa>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+			                /* IDSEL 0x16 */
+			                 b000 0 0 1 f8200000 40 8
+			                 b000 0 0 2 f8200000 41 8
+			                 b000 0 0 3 f8200000 42 8
+			                 b000 0 0 4 f8200000 43 8
+
+			                /* IDSEL 0x17 */
+			                 b800 0 0 1 f8200000 43 8
+			                 b800 0 0 2 f8200000 40 8
+			                 b800 0 0 3 f8200000 41 8
+			                 b800 0 0 4 f8200000 42 8
+
+			                /* IDSEL 0x18 */
+			                 c000 0 0 1 f8200000 42 8
+			                 c000 0 0 2 f8200000 43 8
+			                 c000 0 0 3 f8200000 40 8
+			                 c000 0 0 4 f8200000 41 8>;
 			interrupt-parent = <&Cpm_pic>;
-                       interrupts = <14 8>;
-                       bus-range = <0 0>;
-                       ranges = <02000000 0 80000000 80000000 0 40000000
-                                 01000000 0 00000000 f6000000 0 02000000>;
-               };
+			interrupts = <14 8>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 40000000
+			          01000000 0 00000000 f6000000 0 02000000>;
+		};
 
 /* May need to remove if on a part without crypto engine */
-               crypto@30000 {
-                       device_type = "crypto";
-                       model = "SEC2";
-                       compatible = "talitos";
-                       reg = <30000 10000>;
-                       interrupts = <b 2>;
+		crypto@30000 {
+			device_type = "crypto";
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 2>;
 			interrupt-parent = <&Cpm_pic>;
-                       num-channels = <4>;
-                       channel-fifo-len = <18>;
-                       exec-units-mask = <0000007e>;
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <0000007e>;
 /* desc mask is for rev1.x, we need runtime fixup for >=2.x */
-                       descriptor-types-mask = <01010ebf>;
-               };
-
-       };
+			descriptor-types-mask = <01010ebf>;
+		};
+	};
 };
-- 
1.5.0.3
