Return-Path: <wei.zhang@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 54997DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 19:36:53 +1000 (EST)
From: Zhang Wei <wei.zhang@freescale.com>
To: paulus@samba.org, galak@kernel.crashing.org
Subject: [PATCH 2/4] Add dma sector to mpc8641hpcn board dts
Date: Tue, 10 Jul 2007 17:44:22 +0800
Message-Id: <11840606621515-git-send-email-wei.zhang@freescale.com>
In-Reply-To: <11840606624025-git-send-email-wei.zhang@freescale.com>
References: <1184060662530-git-send-email-wei.zhang@freescale.com>
	<11840606624025-git-send-email-wei.zhang@freescale.com>
Sender: Zhang Wei <wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch add DMA sector to MPC8641HPCN board dts.

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Ebony Zhu <ebony.zhu@freescale.com>
---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 393cfdf..8a70736 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -405,5 +405,35 @@
 			device_type = "open-pic";
 			big-endian;
 		};
+
+		dma@21000{
+			compatible = "fsl,mpc8xxx-dma";
+			reg = <21000 100>;
+			ranges = <0 21000 1000>;
+			ch0@100{
+				reg = <100 80>;
+				extended;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+			};
+			ch1@180{
+				reg = <180 80>;
+				extended;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+			};
+			ch2@200{
+				reg = <200 80>;
+				extended;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+			};
+			ch3@280{
+				reg = <280 80>;
+				extended;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 2>;
+			};
+		};
 	};
 };
-- 
1.5.1
