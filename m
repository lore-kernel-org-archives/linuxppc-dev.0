Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DEDE2DDD0B
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 03:13:20 +1100 (EST)
From: Grzegorz Bernacki <gjb@semihalf.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] Configure PSC4 and PSC5 as UART.
Date: Fri, 13 Feb 2009 17:13:13 +0100
Message-Id: <12345415932889-git-send-email-gjb@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On digsy MTC PSC4 and PSC5 should be configured as UART, not PSC3 and PSC4.

Signed-off-by: Grzegorz Bernacki <gjb@semihalf.com>
---
Version 2:
 - rebased to Ben Herrenschmidt's -next

 arch/powerpc/boot/dts/digsy_mtc.dts |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 0e85ebf..4c36186 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -155,18 +155,18 @@
 			reg = <0x1f00 0x100>;
 		};
 
-		serial@2400 {		// PSC3
-			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			reg = <0x2400 0x100>;
-			interrupts = <2 3 0>;
-		};
-
 		serial@2600 {		// PSC4
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
 			reg = <0x2600 0x100>;
 			interrupts = <2 11 0>;
 		};
 
+		serial@2800 {		// PSC5
+			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
+			reg = <0x2800 0x100>;
+			interrupts = <2 12 0>;
+		};
+
 		ethernet@3000 {
 			compatible = "fsl,mpc5200b-fec","fsl,mpc5200-fec";
 			reg = <0x3000 0x400>;
-- 
1.5.2.2
