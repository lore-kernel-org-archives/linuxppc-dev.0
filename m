Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C75BDE10C
	for <linuxppc-dev@ozlabs.org>; Tue, 20 May 2008 15:43:47 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: paulus@samba.org
Subject: [PATCH 4/4] [POWERPC] Fix mpc8377_mds.dts DMA nodes to match spec
Date: Tue, 20 May 2008 00:43:38 -0500
Message-Id: <1211262218-13949-5-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1211262218-13949-4-git-send-email-galak@kernel.crashing.org>
References: <1211262218-13949-1-git-send-email-galak@kernel.crashing.org>
	<1211262218-13949-2-git-send-email-galak@kernel.crashing.org>
	<1211262218-13949-3-git-send-email-galak@kernel.crashing.org>
	<1211262218-13949-4-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
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
 arch/powerpc/boot/dts/mpc8377_mds.dts |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 1e7802c..fea5925 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -271,27 +271,35 @@
 		dma@82a8 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-			compatible = "fsl,mpc8349-dma";
+			compatible = "fsl,mpc8377-dma", "fsl,elo-dma";
 			reg = <0x82a8 4>;
 			ranges = <0 0x8100 0x1a8>;
 			interrupt-parent = <&ipic>;
 			interrupts = <0x47 8>;
 			cell-index = <0>;
 			dma-channel@0 {
-				compatible = "fsl,mpc8349-dma-channel";
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <0x47 8>;
 			};
 			dma-channel@80 {
-				compatible = "fsl,mpc8349-dma-channel";
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x80 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <0x47 8>;
 			};
 			dma-channel@100 {
-				compatible = "fsl,mpc8349-dma-channel";
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x100 0x80>;
+				interrupt-parent = <&ipic>;
+				interrupts = <0x47 8>;
 			};
 			dma-channel@180 {
-				compatible = "fsl,mpc8349-dma-channel";
+				compatible = "fsl,mpc8377-dma-channel", "fsl,elo-dma-channel";
 				reg = <0x180 0x28>;
+				interrupt-parent = <&ipic>;
+				interrupts = <0x47 8>;
 			};
 		};
 
-- 
1.5.4.5
