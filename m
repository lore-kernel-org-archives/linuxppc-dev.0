Return-Path: <Wei.Zhang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0F5D0DDEFA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 20:44:56 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l87AiqKI010114
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 03:44:52 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l87AilIN017097
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 05:44:51 -0500 (CDT)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org
Subject: [PATCH 3/5] Add DMA of-node to mpc8641hpcn board dts
Date: Fri,  7 Sep 2007 18:53:54 +0800
Message-Id: <11891624391565-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11891624382764-git-send-email-wei.zhang@freescale.com>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<11891624382764-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds DMA of-node to MPC8641HPCN board dts.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   40 ++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 5d82709..e0175a4 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -433,5 +433,45 @@
 			device_type = "open-pic";
 			big-endian;
 		};
+
+		dma@21000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,dma";
+			reg = <21300 4>;
+			ranges = <0 21100 200>;
+			dma-channel@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <0 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+			};
+			dma-channel@80 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <80 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+			};
+			dma-channel@100 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <100 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+			};
+			dma-channel@180 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "fsl,mpc8540-dma-channel";
+				reg = <180 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 2>;
+			};
+		};
 	};
 };
-- 
1.5.2
