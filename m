Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0464DDECA
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 06:50:55 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 07/25] [POWERPC] Update PCI nodes in the 83xx/85xx boards
	device tree
Date: Mon, 23 Jul 2007 15:49:54 -0500
Message-Id: <11852238233066-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1185223821183-git-send-email-galak@kernel.crashing.org>
References: <11852238122538-git-send-email-galak@kernel.crashing.org>
	<1185223813693-git-send-email-galak@kernel.crashing.org>
	<11852238151983-git-send-email-galak@kernel.crashing.org>
	<11852238161546-git-send-email-galak@kernel.crashing.org>
	<1185223818821-git-send-email-galak@kernel.crashing.org>
	<11852238193371-git-send-email-galak@kernel.crashing.org>
	<1185223821183-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Roy Zang <tie-fei.zang@freescale.com>

Updated the 83xx & 85xx device tree PCI related compartible property.

Used the following compatible properties:
	PCI     "fsl,mpc8349-pci"
	PCI     "fsl,mpc8540-pci"
	PCI-X:  "fsl,mpc8540-pcix"
	PCIe:   "fsl,mpc8548-pcie"

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
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
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts b/arch/powerpc/boot/dts/mpc8313erdb.dts
index a1533cc..c5adbe4 100644
--- a/arch/powerpc/boot/dts/mpc8313erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
@@ -178,7 +178,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 4fc0c4d..f158ed7 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -154,7 +154,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 447c03f..7c4beff 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -123,7 +123,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index ae9bca5..502f47c 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -197,7 +197,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
@@ -222,7 +222,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index f636528..0b83871 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -154,7 +154,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 310e877..4810997 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -241,7 +241,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
@@ -301,7 +301,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8600 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 1e914f3..e3f7c12 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -169,7 +169,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8500 100>;
-			compatible = "83xx";
+			compatible = "fsl,mpc8349-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index 364a969..fc8dff9 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -258,7 +258,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index 070206f..fb0b647 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -193,7 +193,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pci";
 			device_type = "pci";
 
 			i8259@19000 {
@@ -230,7 +230,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index 17e45d9..c3c8882 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -193,7 +193,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <8000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pci";
 			device_type = "pci";
 
 			i8259@19000 {
@@ -230,7 +230,7 @@
 			#size-cells = <2>;
 			#address-cells = <3>;
 			reg = <9000 1000>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pci";
 			device_type = "pci";
 		};
 
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index 21ccaaa..16dbe84 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -136,7 +136,7 @@
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
 			#address-cells = <3>;
-			compatible = "85xx";
+			compatible = "fsl,mpc8540-pcix", "fsl,mpc8540-pci";
 			device_type = "pci";
 			reg = <8000 1000>;
 			clock-frequency = <3f940aa>;
-- 
1.5.2.2
