Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:39:54 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 8/8] powerpc: prpmc2800 - Miscellaneous DTS file fixups
Message-ID: <20071211003953.GI4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Remove unnecessary device_type properties and leading zeroes in node names.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 054f028..6af5a3a 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -133,7 +133,6 @@
 		};
 
 		SDMA0: sdma@4000 {
-			device_type = "dma";
 			compatible = "marvell,mv64360-sdma";
 			reg = <0x4000 0xc18>;
 			virtual-reg = <0xf1004000>;
@@ -143,7 +142,6 @@
 		};
 
 		SDMA1: sdma@6000 {
-			device_type = "dma";
 			compatible = "marvell,mv64360-sdma";
 			reg = <0x6000 0xc18>;
 			virtual-reg = <0xf1006000>;
@@ -300,14 +298,14 @@
 			>;
 		};
 
-		cpu-error@0070 {
+		cpu-error@70 {
 			compatible = "marvell,mv64360-cpu-error";
 			reg = <0x0070 0x10 0x0128 0x28>;
 			interrupts = <3>;
 			interrupt-parent = <&PIC>;
 		};
 
-		sram-ctrl@0380 {
+		sram-ctrl@380 {
 			compatible = "marvell,mv64360-sram-ctrl";
 			reg = <0x0380 0x80>;
 			interrupts = <13>;
