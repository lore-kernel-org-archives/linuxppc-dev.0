Return-Path: <timur@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139]) by ozlabs.org (Postfix) with ESMTP id EF59CB70CC
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 04:40:27 +1000 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com, yorksun@freescale.com,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 1/2] powerpc/85xx: add ngPIXIS FPGA device tree node to the
	P1022DS board
Date: Thu, 9 Sep 2010 13:39:56 -0500
Message-ID: <1284057597-17126-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device tree for Freescale's P1022DS reference board is missing the node
for the ngPIXIS FPGA.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds.dts |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
index 8bcb10b..e61b42d 100644
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ b/arch/powerpc/boot/dts/p1022ds.dts
@@ -148,6 +148,15 @@
 				label = "reserved-nand";
 			};
 		};
+
+		board-control@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,fpga-pixis";
+			reg = <3 0 0x30>;
+			interrupt-parent = <&mpic>;
+			interrupts = <8 8>;
+		};
 	};
 
 	soc@fffe00000 {
-- 
1.7.2.2
