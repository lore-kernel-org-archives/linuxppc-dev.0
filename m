Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 50267DDDFB
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 10:21:33 +1100 (EST)
Date: Sun, 3 Feb 2008 23:21:29 +0000
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: linuxppc-dev@ozlabs.org, scottwood@freescale.com
Subject: PATCH[1/1] 8xx: resubmit Add clock-frequency parameter to adder875
	and mpc885ads dts configurations
Message-ID: <20080203232129.36186b0a@neuromancer.mindspace>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previous patch submission contained tabs munged into whitespace.

This patch adds the clock-frequency parameter in decimal instead of hex.

Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
---

diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
index 930bfb3..28e9cd3 100644
--- a/arch/powerpc/boot/dts/adder875-redboot.dts
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -151,6 +151,7 @@
 				compatible = "fsl,mpc875-brg",
 				             "fsl,cpm1-brg",
 				             "fsl,cpm-brg";
+				clock-frequency = <50000000>;
 				reg = <0x9f0 0x10>;
 			};
 
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
index 0197242..54fb60e 100644
--- a/arch/powerpc/boot/dts/adder875-uboot.dts
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -150,6 +150,7 @@
 				compatible = "fsl,mpc875-brg",
 				             "fsl,cpm1-brg",
 				             "fsl,cpm-brg";
+				clock-frequency = <50000000>;
 				reg = <0x9f0 0x10>;
 			};
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index 8848e63..d84a012 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -166,6 +166,7 @@
 				compatible = "fsl,mpc885-brg",
 				             "fsl,cpm1-brg",
 				             "fsl,cpm-brg";
+				clock-frequency = <0>;
 				reg = <9f0 10>;
 			};
