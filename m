Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 4B1D1DE337
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 07:36:06 +1100 (EST)
Date: Wed, 19 Dec 2007 23:38:17 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] [POWERPC] fsl_spi_init and users: stop using device_type
	= "spi"
Message-ID: <20071219203817.GD20861@localhost.localdomain>
References: <20071219203447.GA18285@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071219203447.GA18285@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Also rename "fsl_spi" to "fsl,spi".

Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    3 +--
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    6 ++----
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    6 ++----
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    3 +--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    3 +--
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    3 +--
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    6 ++----
 arch/powerpc/boot/dts/mpc8568mds.dts     |    6 ++----
 arch/powerpc/sysdev/fsl_soc.c            |    2 +-
 9 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index c5b6665..127cf57 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -82,8 +82,7 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 97757ed..517e433 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -192,8 +192,7 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = < &qeic >;
@@ -201,8 +200,7 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = < &qeic >;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b1c73f1..a229fab 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -182,8 +182,7 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
@@ -191,8 +190,7 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index e354f26..b89dbbf 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -82,8 +82,7 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index ebdf0b7..123c34e 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -80,8 +80,7 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 0ba13eb..eb532f3 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -93,8 +93,7 @@
 		};
 
 		spi@7000 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <7000 1000>;
 			interrupts = <10 8>;
 			interrupt-parent = < &ipic >;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 330212d..decbafe 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -223,8 +223,7 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = < &qeic >;
@@ -232,8 +231,7 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = < &qeic >;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index c00aec9..2b79f8b 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -300,8 +300,7 @@
 		};
 
 		spi@4c0 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <4c0 40>;
 			interrupts = <2>;
 			interrupt-parent = <&qeic>;
@@ -309,8 +308,7 @@
 		};
 
 		spi@500 {
-			device_type = "spi";
-			compatible = "fsl_spi";
+			compatible = "fsl,spi";
 			reg = <500 40>;
 			interrupts = <1>;
 			interrupt-parent = <&qeic>;
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3cf84d0..91bac51 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -1242,7 +1242,7 @@ int __init fsl_spi_init(struct spi_board_info *board_infos,
 	}
 
 	for (np = NULL, i = 1;
-	     (np = of_find_compatible_node(np, "spi", "fsl_spi")) != NULL;
+	     (np = of_find_compatible_node(np, NULL, "fsl,spi")) != NULL;
 	     i++) {
 		int ret = 0;
 		unsigned int j;
-- 
1.5.2.2
