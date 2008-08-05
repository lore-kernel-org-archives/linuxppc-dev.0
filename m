Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3BC46DE167
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 06:13:48 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m75KDgu3008470
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 13:13:43 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-194.am.freescale.net
	[10.214.72.194])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m75KDeNB025312
	for <linuxppc-dev@ozlabs.org>; Tue, 5 Aug 2008 15:13:42 -0500 (CDT)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH add immr alias 3/4] powerpc: 83xx: Add immr aliases to 83xx
	device trees.
Date: Tue,  5 Aug 2008 14:13:39 -0600
Message-Id: <1217967220-30557-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1217967220-30557-2-git-send-email-jrigby@freescale.com>
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>
	<1217967220-30557-2-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that get_immrbase knows about immr aliases.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8315erdb.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    3 ++-
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    3 ++-
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc836x_rdk.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8377_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8377_rdb.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8378_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8378_rdb.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8379_mds.dts    |    3 ++-
 arch/powerpc/boot/dts/mpc8379_rdb.dts    |    3 ++-
 arch/powerpc/boot/dts/sbc8349.dts        |    3 ++-
 16 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index 2a94ae0..3c04cd2 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -94,7 +95,7 @@
 		};
 	};
 
-	soc8313@e0000000 {
+	immr: soc8313@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index f704513..3327670 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -22,6 +22,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -92,7 +93,7 @@
 		};
 	};
 
-	immr@e0000000 {
+	immr: immr@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index fbc9304..a2757b3 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -35,6 +35,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -64,7 +65,7 @@
 		reg = <0xf8000000 0x8000>;
 	};
 
-	soc8323@e0000000 {
+	immr: soc8323@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index b157d18..50e0539 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -47,7 +48,7 @@
 		reg = <0x00000000 0x04000000>;
 	};
 
-	soc8323@e0000000 {
+	immr: soc8323@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 700e076..ed24c85 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -24,6 +24,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -48,7 +49,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc8349@e0000000 {
+	immr: soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index cdd3063..24a696d 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -22,6 +22,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -46,7 +47,7 @@
 		reg = <0x00000000 0x10000000>;
 	};
 
-	soc8349@e0000000 {
+	immr: soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 783241c..aad88e1 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -24,6 +24,7 @@
 		serial1 = &serial1;
 		pci0 = &pci0;
 		pci1 = &pci1;
+		immr = &immr;
 	};
 
 	cpus {
@@ -53,7 +54,7 @@
 		reg = <0xe2400000 0x8000>;
 	};
 
-	soc8349@e0000000 {
+	immr: soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index a3b76a7..664c371 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -28,6 +28,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -57,7 +58,7 @@
 		reg = <0xf8000000 0x8000>;
 	};
 
-	soc8360@e0000000 {
+	immr: soc8360@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 89c9202..af22122 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -29,6 +29,7 @@
 		ethernet2 = &enet2;
 		ethernet3 = &enet3;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -55,7 +56,7 @@
 		reg = <0 0>;
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 432782b..36c5ded 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -113,7 +114,7 @@
 		};
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index ed137aa..49465da 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -22,6 +22,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -92,7 +93,7 @@
 		};
 	};
 
-	immr@e0000000 {
+	immr: immr@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index ed32c8d..368cad1 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -113,7 +114,7 @@
 		};
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 34a7f2f..b6fa64e 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -22,6 +22,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -92,7 +93,7 @@
 		};
 	};
 
-	immr@e0000000 {
+	immr: immr@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index f4db9ed..e79d8e5 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -23,6 +23,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -113,7 +114,7 @@
 		};
 	};
 
-	soc@e0000000 {
+	immr: soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index e4d7030..830a254 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -22,6 +22,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -92,7 +93,7 @@
 		};
 	};
 
-	immr@e0000000 {
+	immr: immr@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/sbc8349.dts b/arch/powerpc/boot/dts/sbc8349.dts
index 45f789b..efbdd21 100644
--- a/arch/powerpc/boot/dts/sbc8349.dts
+++ b/arch/powerpc/boot/dts/sbc8349.dts
@@ -27,6 +27,7 @@
 		serial0 = &serial0;
 		serial1 = &serial1;
 		pci0 = &pci0;
+		immr = &immr;
 	};
 
 	cpus {
@@ -51,7 +52,7 @@
 		reg = <0x00000000 0x10000000>;	// 256MB at 0
 	};
 
-	soc8349@e0000000 {
+	immr: soc8349@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-- 
