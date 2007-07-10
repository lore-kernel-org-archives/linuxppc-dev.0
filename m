Return-Path: <tie-fei.zang@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7C708DDFF9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 01:53:21 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6AFrGTs003303
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 08:53:16 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6AFrFXZ020133
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 10:53:15 -0500 (CDT)
Subject: [patch 5/6] Update the 83xx/85xx/86xx boards device tree
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>, Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184082783.20129.193.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 10 Jul 2007 23:53:03 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Update the 83xx/85xx/86xx boards device tree.

Indentify pci, pcie host by compatible property
"fsl,mpc83xx-pci","83xx"
"fsl,mpc85xx-pci","85xx"
"fsl,mpc86xx-pci","86xx"
and
"fsl, mpc85xx-pciex","85xx"
"fsl, mpc86xx-pciex","86xx"

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/mpc8313erdb.dts    |    2 +-
 arch/powerpc/boot/dts/mpc832x_mds.dts    |    2 +-
 arch/powerpc/boot/dts/mpc832x_rdb.dts    |    2 +-
 arch/powerpc/boot/dts/mpc8349emitx.dts   |    4 ++--
 arch/powerpc/boot/dts/mpc8349emitxgp.dts |    2 +-
 arch/powerpc/boot/dts/mpc834x_mds.dts    |    4 ++--
 arch/powerpc/boot/dts/mpc836x_mds.dts    |    2 +-
 arch/powerpc/boot/dts/mpc8540ads.dts     |    2 +-
 arch/powerpc/boot/dts/mpc8541cds.dts     |    4 ++--
 arch/powerpc/boot/dts/mpc8555cds.dts     |    4 ++--
 arch/powerpc/boot/dts/mpc8560ads.dts     |    2 +-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts   |    4 ++--
 12 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a1533cc..5276843 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -178,7 +178,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 4fc0c4d..ee8897b 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -154,7 +154,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 447c03f..d83469b 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -123,7 +123,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index ae9bca5..911984b 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -197,7 +197,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
@@ -222,7 +222,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index f636528..8790349 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -154,7 +154,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 310e877..dc4d97d 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -241,7 +241,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
@@ -301,7 +301,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 1e914f3..2750eb1 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -169,7 +169,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc83xx-pci","83xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 364a969..8efea9b 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -258,7 +258,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 070206f..be89d46 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -193,7 +193,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 
 			i8259@19000 {
@@ -230,7 +230,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 17e45d9..0bee322 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -193,7 +193,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 
 			i8259@19000 {
@@ -230,7 +230,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 21ccaaa..d0627bd 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -136,7 +136,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "85xx";
+			compatible = "fsl,mpc85xx-pci","85xx";
 			device_type = "pci";
 			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index db56a02..2b36ae3 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -208,7 +208,7 @@
 		};
 
 		pci@8000 {
-			compatible = "86xx";
+			compatible = "fsl,mpc86xx-pciex","86xx";
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
@@ -396,7 +396,7 @@
 		};
 
 		pci@9000 {
-			compatible = "86xx";
+			compatible = "fsl,mpc86xx-pciex","86xx";
 			device_type = "pci";
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
-- 
1.5.1
