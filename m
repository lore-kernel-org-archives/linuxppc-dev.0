Return-Path: <philippe.reynes@isismpp.fr>
Received: from neuf-infra-smtp-out-sp604003av.neufgp.fr
	(neuf-infra-smtp-out-sp604003av.neufgp.fr [84.96.92.124])
	by ozlabs.org (Postfix) with ESMTP id 33757DDEE9
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Feb 2009 20:14:53 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] add gpio to mpc837X rdb
Date: Mon, 2 Feb 2009 10:13:51 +0100
Message-ID: <761F451C5F17F74DAEE4661DA5ABBC1616C455@factorix.ISISTHIBAUD.local>
References: <761F451C5F17F74DAEE4661DA5ABBC1616C448@factorix.ISISTHIBAUD.local>
	<20090129192031.GA17060@oksana.dev.rtsoft.ru>
	<0819EFA5-E86A-4D7F-8C60-06721B8072D8@freescale.com>
From: "Reynes Philippe" <philippe.reynes@isismpp.fr>
To: "Kumar Gala" <kumar.gala@freescale.com>,
	<avorontsov@ru.mvista.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
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
Index: powerpc/arch/powerpc/boot/dts/mpc8377_rdb.dts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- powerpc.orig/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ powerpc/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -109,6 +109,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8377-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8377-gpio",
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
Index: powerpc/arch/powerpc/boot/dts/mpc8378_rdb.dts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- powerpc.orig/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ powerpc/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -109,6 +109,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8378-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8378-gpio",
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
Index: powerpc/arch/powerpc/boot/dts/mpc8379_rdb.dts
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- powerpc.orig/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ powerpc/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -107,6 +107,24 @@
 			reg =3D <0x200 0x100>;
 		};
=20
+		gpio1: gpio-controller@c00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8379-gpio",
"fsl,mpc8349-gpio";
+			reg =3D <0xc00 0x100>;
+			interrupts =3D <74 0x8>;
+			interrupt-parent =3D <&ipic>;
+			gpio-controller;
+		};
+
+		gpio2: gpio-controller@d00 {
+			#gpio-cells =3D <2>;
+			compatible =3D "fsl,mpc8379-gpio",
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
