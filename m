Return-Path: <philippe.reynes@isismpp.fr>
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr
	(neuf-infra-smtp-out-sp604003av.neufgp.fr [84.96.92.124])
	by ozlabs.org (Postfix) with ESMTP id 634DBDE199
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 01:34:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] add lm75 to mpc 837x rdb dts
Date: Fri, 30 Jan 2009 15:34:10 +0100
Message-ID: <761F451C5F17F74DAEE4661DA5ABBC1616C452@factorix.ISISTHIBAUD.local>
From: "Reynes Philippe" <philippe.reynes@isismpp.fr>
To: <linuxppc-dev@ozlabs.org>
Cc: Kumar Gala <kumar.gala@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
---
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index e747486..38507ee 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -137,6 +137,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national, lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts
b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index f4c8682..d731780 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -137,6 +137,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national, lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts
b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 1985cef..d3b78b2 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -135,6 +135,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national, lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
