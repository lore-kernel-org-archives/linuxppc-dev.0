Return-Path: <tinamdar@amcc.com>
From: Tanmay Inamdar <tinamdar@apm.com>
To: benh@kernel.crashing.org, jwboyer@gmail.com, grant.likely@secretlab.ca,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org
Subject: [V2 3/5] powerpc: dts: klondike: Add UART nodes
Date: Mon,  9 Apr 2012 12:50:50 +0530
Message-Id: <1333956052-25319-3-git-send-email-tinamdar@apm.com>
In-Reply-To: <1333956052-25319-2-git-send-email-tinamdar@apm.com>
References: <1333956052-25319-1-git-send-email-tinamdar@apm.com>
 <1333956052-25319-2-git-send-email-tinamdar@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding UART nodes in Klondike device tree file.

Version 2:
Removed unnecessary 'virtual-reg' property from UART node.

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
:100644 100644 4ff2852... b1e516e... M	arch/powerpc/boot/dts/klondike.dts
 arch/powerpc/boot/dts/klondike.dts |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/klondike.dts b/arch/powerpc/boot/dts/klondike.dts
index 4ff2852..b1e516e 100644
--- a/arch/powerpc/boot/dts/klondike.dts
+++ b/arch/powerpc/boot/dts/klondike.dts
@@ -222,6 +222,28 @@
 				#size-cells = <1>;
 				ranges;
 				clock-frequency = <0>;
+
+				UART0: serial@50001000 {
+				       device_type = "serial";
+				       compatible = "ns16550";
+				       reg = <0x50001000 0x00000100>;
+				       clock-frequency = <0>; /* Filled in by U-Boot */
+				       current-speed = <115200>;
+				       interrupt-parent = <&UIC0>;
+				       interrupts = <0x0 0x4>;
+				       reg-shift = <2>;
+				};
+
+				UART1: serial@50002000 {
+				       device_type = "serial";
+				       compatible = "ns16550";
+				       reg = <0x50002000 0x00000100>;
+				       clock-frequency = <0>; /* Filled in by U-Boot */
+				       current-speed = <115200>;
+				       interrupt-parent = <&UIC0>;
+				       interrupts = <0x1 0x4>;
+				       reg-shift = <2>;
+			       };
 			};
 		};
 	};
-- 
1.6.1.rc3
