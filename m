Return-Path: <philippe.reynes@isismpp.fr>
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr
	(neuf-infra-smtp-out-sp604003av.neufgp.fr [84.96.92.124])
	by ozlabs.org (Postfix) with ESMTP id 95A97DDF21
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 02:59:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [PATCH] add lm75 to mpc 837x rdb dts
Date: Mon, 2 Feb 2009 16:59:01 +0100
Message-ID: <761F451C5F17F74DAEE4661DA5ABBC1616C466@factorix.ISISTHIBAUD.local>
References: <761F451C5F17F74DAEE4661DA5ABBC1616C452@factorix.ISISTHIBAUD.local>
	<408550B3-4109-4164-BE42-15D6B6A96871@freescale.com>
From: "Reynes Philippe" <philippe.reynes@isismpp.fr>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

You're right, there no space in "national,lm75".

Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
---
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts =
b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index e747486..54b4520 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -137,6 +137,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national,lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts =
b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index f4c8682..7243374 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -137,6 +137,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national,lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts =
b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 1985cef..6dac476 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -135,6 +135,11 @@
 			interrupt-parent =3D <&ipic>;
 			dfsrr;
=20
+			dtt@48 {
+				compatible =3D "national,lm75";
+				reg =3D <0x48>;
+			};
+
 			at24@50 {
 				compatible =3D "at24,24c256";
 				reg =3D <0x50>;
