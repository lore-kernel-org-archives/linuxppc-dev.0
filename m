Return-Path: <philippe.reynes@isismpp.fr>
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr (sp604003av.neufgp.fr
	[84.96.92.124]) by ozlabs.org (Postfix) with ESMTP id 1D39EDE06B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 08:29:51 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] add i2c eeprom to dts for mpc 837x rdb
Date: Tue, 27 Jan 2009 18:55:21 +0100
Message-ID: <761F451C5F17F74DAEE4661DA5ABBC1616C446@factorix.ISISTHIBAUD.local>
References: <761F451C5F17F74DAEE4661DA5ABBC160181BE95@factorix.ISISTHIBAUD.local>
	<761F451C5F17F74DAEE4661DA5ABBC16215158@factorix.ISISTHIBAUD.local>
	<761F451C5F17F74DAEE4661DA5ABBC1621515A@factorix.ISISTHIBAUD.local>
	<7FAC732F-383E-4228-9770-3F791EA215FC@freescale.com>
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

Signed-off-by: Philippe Reynes <philippe.reynes@isismpp.fr>
---
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts
b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 9413af3..a8276d4 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -116,6 +116,12 @@
                        interrupts =3D <14 0x8>;
                        interrupt-parent =3D <&ipic>;
                        dfsrr;
+
+                       at24@50 {
+                               compatible =3D "at24,24c256";
+                               reg =3D <0x50>;
+                       };
+
                        rtc@68 {
                                compatible =3D "dallas,ds1339";
                                reg =3D <0x68>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts
b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 23c10ce..4ee2639 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -116,6 +116,12 @@
                        interrupts =3D <14 0x8>;
                        interrupt-parent =3D <&ipic>;
                        dfsrr;
+
+                       at24@50 {
+                               compatible =3D "at24,24c256";
+                               reg =3D <0x50>;
+                       };
+
                        rtc@68 {
                                compatible =3D "dallas,ds1339";
                                reg =3D <0x68>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts
b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 72cdc3c..2c06d39 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -116,6 +116,12 @@
                        interrupts =3D <14 0x8>;
                        interrupt-parent =3D <&ipic>;
                        dfsrr;
+
+                       at24@50 {
+                               compatible =3D "at24,24c256";
+                               reg =3D <0x50>;
+                       };
+
                        rtc@68 {
                                compatible =3D "dallas,ds1339";
                                reg =3D <0x68>;
