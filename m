Return-Path: <philippe.reynes@isismpp.fr>
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr (sp604003av.neufgp.fr
	[84.96.92.124]) by ozlabs.org (Postfix) with ESMTP id D8A03DE010
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jan 2009 04:37:21 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] add gpio to mpc837X rdb
Date: Thu, 29 Jan 2009 18:37:15 +0100
Message-ID: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
From: "Reynes Philippe" <philippe.reynes@isismpp.fr>
To: "linuxppc-dev list" <linuxppc-dev@ozlabs.org>
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
index 165463f..45c9f03 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -109,6 +109,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xd00 0x100>;
+			interrupts =3D <75 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
 		i2c@3000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts
b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index f9830ae..7863d11 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -109,6 +109,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xd00 0x100>;
+			interrupts =3D <75 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
 		i2c@3000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts
b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 2c06d39..485d28b 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -107,6 +107,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8347-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xd00 0x100>;
+			interrupts =3D <75 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
 		i2c@3000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
