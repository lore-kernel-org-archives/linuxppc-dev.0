Return-Path: <b08248@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 05BF6DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Feb 2007 03:14:21 +1100 (EST)
Date: Tue, 27 Feb 2007 10:14:14 -0600
From: Stuart Yoder <b08248@freescale.com>
Message-Id: <200702271614.l1RGEEgV027558@ld0164-tx32.am.freescale.net>
To: paulus@samba.org
Subject: [PATCH] powerpc: remove ununused,
	undocumented #cpus property from cpus node
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The #cpus property is unused and undocumented and is therefore being removed.


Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
---
 arch/powerpc/boot/dts/kuroboxHD.dts      |    1 -
 arch/powerpc/boot/dts/kuroboxHG.dts      |    1 -
 arch/powerpc/boot/dts/lite5200.dts       |    1 -
 arch/powerpc/boot/dts/lite5200b.dts      |    1 -
 arch/powerpc/boot/dts/mpc7448hpc2.dts    |    1 -
 arch/powerpc/boot/dts/mpc8272ads.dts     |    1 -
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    1 -
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    1 -
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    1 -
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    1 -
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    1 -
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    1 -
 arch/powerpc/boot/dts/mpc8540ads.dts     |    1 -
 arch/powerpc/boot/dts/mpc8541cds.dts     |    1 -
 arch/powerpc/boot/dts/mpc8548cds.dts     |    1 -
 arch/powerpc/boot/dts/mpc8555cds.dts     |    1 -
 arch/powerpc/boot/dts/mpc8560ads.dts     |    1 -
 arch/powerpc/boot/dts/mpc8568mds.dts     |    1 -
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    1 -
 arch/powerpc/boot/dts/mpc866ads.dts      |    1 -
 arch/powerpc/boot/dts/mpc885ads.dts      |    1 -
 21 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/boot/dts/kuroboxHD.dts b/arch/powerpc/boot/dts/kuroboxHD.dts
index b897918..373110d 100644
--- a/arch/powerpc/boot/dts/kuroboxHD.dts
+++ b/arch/powerpc/boot/dts/kuroboxHD.dts
@@ -29,7 +29,6 @@ build with: "dtc -f -I dts -O dtb -o kur
 
 	cpus {
 		linux,phandle = <2000>;
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/kuroboxHG.dts b/arch/powerpc/boot/dts/kuroboxHG.dts
index 7531027..f3542dc 100644
--- a/arch/powerpc/boot/dts/kuroboxHG.dts
+++ b/arch/powerpc/boot/dts/kuroboxHG.dts
@@ -29,7 +29,6 @@ build with: "dtc -f -I dts -O dtb -o kur
 
 	cpus {
 		linux,phandle = <2000>;
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index c03103c..ba54c6b 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -24,7 +24,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 3875ca9..2e00308 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -24,7 +24,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc7448hpc2.dts b/arch/powerpc/boot/dts/mpc7448hpc2.dts
index 41d0720..6fa3754 100644
--- a/arch/powerpc/boot/dts/mpc7448hpc2.dts
+++ b/arch/powerpc/boot/dts/mpc7448hpc2.dts
@@ -19,7 +19,6 @@
 	linux,phandle = <100>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells =<0>;
 		linux,phandle = <200>;
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 260b2e4..423eedc 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -17,7 +17,6 @@
        linux,phandle = <100>;
 
        cpus {
-               #cpus = <1>;
                #address-cells = <1>;
                #size-cells = <0>;
                linux,phandle = <200>;
diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 6d72190..a1533cc 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -16,7 +16,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 06b3106..c798491 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -16,7 +16,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 61b550b..db0d003 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -15,7 +15,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index b2e1a5e..f636528 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -15,7 +15,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index e4b43c2..07bcc51 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -16,7 +16,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 4fe45c0..7f578eb 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -21,7 +21,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 3c0917f..f261d64 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 2a1ae76..5fdcb69 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 7eb5d81..b2b2200 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 5f9c102..68a4795 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 1050263..1f2afe9 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index bf49d8c..7361b36 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -21,7 +21,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index 8a4995a..423b3d0 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -17,7 +17,6 @@
 	#size-cells = <1>;
 
 	cpus {
-		#cpus = <2>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
diff --git a/arch/powerpc/boot/dts/mpc866ads.dts b/arch/powerpc/boot/dts/mpc866ads.dts
index 2b56b5d..c0d06fd 100644
--- a/arch/powerpc/boot/dts/mpc866ads.dts
+++ b/arch/powerpc/boot/dts/mpc866ads.dts
@@ -18,7 +18,6 @@
 	linux,phandle = <100>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		linux,phandle = <200>;
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index faecd08..110bf61 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -18,7 +18,6 @@
 	linux,phandle = <100>;
 
 	cpus {
-		#cpus = <1>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		linux,phandle = <200>;
-- 
1.4.4
