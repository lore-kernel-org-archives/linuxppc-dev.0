Return-Path: <gjb@semihalf.com>
Received: from semihalf.com (semihalf.com [206.130.101.55])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B1D1DDE23
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Feb 2009 00:52:52 +1100 (EST)
From: Grzegorz Bernacki <gjb@semihalf.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Configure PSC4 and PSC5 as UART.
Date: Fri, 13 Feb 2009 14:52:43 +0100
Message-Id: <1234533163557-git-send-email-gjb@semihalf.com>
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
 arch/powerpc/boot/dts/digsy_mtc.dts |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 9c76c38..ce33c7c 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -164,21 +164,21 @@
 			reg = <0x1f00 0x100>;
 		};
 
-		serial@2400 {		// PSC3
+		serial@2600 {		// PSC4
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			cell-index = <2>;
-			reg = <0x2400 0x100>;
-			interrupts = <2 3 0>;
+			cell-index = <3>;
+			reg = <0x2600 0x100>;
+			interrupts = <2 11 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-		serial@2600 {		// PSC4
+		serial@2800 {		// PSC5
 			device_type = "serial";
 			compatible = "fsl,mpc5200b-psc-uart","fsl,mpc5200-psc-uart";
-			cell-index = <3>;
-			reg = <0x2600 0x100>;
-			interrupts = <2 11 0>;
+			cell-index = <5>;
+			reg = <0x2800 0x100>;
+			interrupts = <2 12 0>;
 			interrupt-parent = <&mpc5200_pic>;
 		};
 
-- 
1.6.0.6
