Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.172])
	by ozlabs.org (Postfix) with ESMTP id 83B35DDE1B
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 20:43:16 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so411518uge
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 03:43:14 -0700 (PDT)
Message-Id: <20070920104313.217207466@sunsite.dk>
References: <20070920104211.896143373@sunsite.dk>
Date: Thu, 20 Sep 2007 12:42:14 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-dev@ozlabs.org,
 galak@kernel.crashing.org
Subject: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add ds1339 I2C RTC chip as child of 2nd I2C controller.

Cc: Timur Tabi <timur@freescale.com>
Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |    7 +++++++
 1 file changed, 7 insertions(+)

Index: linux/arch/powerpc/boot/dts/mpc8349emitx.dts
===================================================================
--- linux.orig/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ linux/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -68,6 +68,13 @@
 			interrupts = <f 8>;
 			interrupt-parent = < &ipic >;
 			dfsrr;
+
+			rtc@68 {
+				device_type = "rtc";
+				compatible = "dallas,ds1339";
+				reg = <68 4>;
+			};
+
 		};
 
 		spi@7000 {

-- 
Bye, Peter Korsgaard
