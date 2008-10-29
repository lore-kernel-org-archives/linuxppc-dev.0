Return-Path: <mike.dyer@provision-comm.com>
Received: from smtp1.betherenow.co.uk (smtp1.betherenow.co.uk [87.194.0.68])
	by ozlabs.org (Postfix) with SMTP id 11683DDDD8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Oct 2008 21:10:26 +1100 (EST)
Subject: [PATCH] [MPC8313ERDB] Remove duplicate DMA entry from device tree
From: Mike Dyer <mike.dyer@provision-comm.com>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 29 Oct 2008 10:10:06 +0000
Message-Id: <1225275006.8152.16.camel@mike-linux.provision-comm.com>
Mime-Version: 1.0
Cc: scottwood@freescale.com, Joaquin.Luna@jdsu.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Signed-off-by: Mike Dyer <mike.dyer@provision-comm.com>
---
arch/powerpc/boot/dts/mpc8313erdb.dts |   39 ---------------------------------
 1 files changed, 0 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 747f276..5030317 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -164,45 +164,6 @@
 			mode = "cpu";
 		};
 
-		dma@82a8 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,mpc8313-dma", "fsl,elo-dma";
-			reg = <0x82a8 4>;
-			ranges = <0 0x8100 0x1a8>;
-			interrupt-parent = <&ipic>;
-			interrupts = <71 8>;
-			cell-index = <0>;
-			dma-channel@0 {
-				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
-				reg = <0 0x80>;
-				cell-index = <0>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@80 {
-				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x80 0x80>;
-				cell-index = <1>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@100 {
-				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x100 0x80>;
-				cell-index = <2>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-			dma-channel@180 {
-				compatible = "fsl,mpc8313-dma-channel", "fsl,elo-dma-channel";
-				reg = <0x180 0x28>;
-				cell-index = <3>;
-				interrupt-parent = <&ipic>;
-				interrupts = <71 8>;
-			};
-		};
-
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
 		usb@23000 {
 			compatible = "fsl-usb2-dr";
