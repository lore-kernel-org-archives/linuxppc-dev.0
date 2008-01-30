Return-Path: <bodonoghue@codehermit.ie>
Received: from lugano.hostireland.com (lugano.hostireland.com [67.192.77.34])
	by ozlabs.org (Postfix) with ESMTP id 502A8DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 10:38:01 +1100 (EST)
Subject: PATCH[1/1] 8xx: Add clock-frequency to Adder875 and mpc885ads
	board ports
From: Bryan O'Donoghue <bodonoghue@codehermit.ie>
To: linuxppc-dev@ozlabs.org, scottwood@freescale.com
Content-Type: text/plain
Date: Wed, 30 Jan 2008 23:34:48 +0000
Message-Id: <1201736088.3466.3.camel@neuromancer.mindspace>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Redo the addition of the clock-frequency parameter to the Adder875 .dts
so that the values are decimal rather then hex.


Signed-off-by: Bryan O'Donoghue <bodonoghue@codehermit.ie>
---

diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts
b/arch/powerpc/boot/dts/adder875-redboot.dts
index 7c25d96..c508f3c 100644
--- a/arch/powerpc/boot/dts/adder875-redboot.dts
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -149,6 +149,7 @@
                                compatible = "fsl,mpc875-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <50000000>;
                                reg = <0x9f0 0x10>;
                        };
 
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts
b/arch/powerpc/boot/dts/adder875-uboot.dts
index 605202f..d7ac416 100644
--- a/arch/powerpc/boot/dts/adder875-uboot.dts
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -148,6 +148,7 @@
                                compatible = "fsl,mpc875-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <50000000>;
                               reg = <0x9f0 0x10>;
                        };
 
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts
b/arch/powerpc/boot/dts/mpc885ads.dts
index 8848e63..f2a437b 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -166,6 +166,7 @@
                                compatible = "fsl,mpc885-brg",
                                             "fsl,cpm1-brg",
                                             "fsl,cpm-brg";
+                               clock-frequency = <0>;
                                reg = <9f0 10>;
                        };
