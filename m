Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id 3AAE1DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 01:45:07 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so3555523nfd
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 08:45:06 -0700 (PDT)
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] SPI: Use fsl_spi instead of mpc83xx_spi
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 03 Oct 2007 17:44:58 +0200
Message-ID: <87hcl8xkw5.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

According to booting-without-of.txt, compatible should be "fsl_spi" and
mode "cpu" or "qe" for the fsl SPI controllers.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    4 ++--
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a8eadc8..9e7eba9 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -71,11 +71,11 @@
 
 		spi@7000 {
 			device_type = "spi";
-			compatible = "mpc83xx_spi";
+			compatible = "fsl_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
-			mode = <0>;
+			mode = "cpu";
 		};
 
 		/* phy type (ULPI, UTMI, UTMI_WIDE, SERIAL) */
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index e0cb2a7..b2b3995 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -70,11 +70,11 @@
 
 		spi@7000 {
 			device_type = "spi";
-			compatible = "mpc83xx_spi";
+			compatible = "fsl_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
-			mode = <0>;
+			mode = "cpu";
 		};
 
 		usb@22000 {
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index fa852ba..cf8c72a 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -70,11 +70,11 @@
 
 		spi@7000 {
 			device_type = "spi";
-			compatible = "mpc83xx_spi";
+			compatible = "fsl_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
-			mode = <0>;
+			mode = "cpu";
 		};
 
 		usb@23000 {
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 1b8882e..cf7b84f 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -76,11 +76,11 @@
 
 		spi@7000 {
 			device_type = "spi";
-			compatible = "mpc83xx_spi";
+			compatible = "fsl_spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
-			mode = <0>;
+			mode = "cpu";
 		};
 
 		/* phy type (ULPI or SERIAL) are only types supportted for MPH */
-- 
1.5.3.2


-- 
Bye, Peter Korsgaard
