Return-Path: <Jason.Jin@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 89AFADDF4E
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 17:09:05 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3I78xdC012634
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 00:08:59 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3I78vbS023919
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 02:08:58 -0500 (CDT)
From: Jason Jin <Jason.jin@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Fix the wrong serial1 interrupt for 8610 board
Date: Sat, 19 Apr 2008 15:07:56 +0800
Message-Id: <1208588876-23103-1-git-send-email-Jason.jin@freescale.com>
Cc: kumar.gala@freescale.com, Jason Jin <Jason.jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Jason Jin <Jason.jin@freescale.com>
---
 arch/powerpc/boot/dts/mpc8610_hpcd.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 16c947b..97fdb01 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -100,7 +100,7 @@
 			compatible = "ns16550";
 			reg = <0x4600 0x100>;
 			clock-frequency = <0>;
-			interrupts = <28 2>;
+			interrupts = <42 2>;
 			interrupt-parent = <&mpic>;
 		};
 
-- 
1.5.4
