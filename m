Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DA15DDDDFF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 13:30:53 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6H3UlQq004753
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:30:48 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6H3UkXX005182
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 22:30:47 -0500 (CDT)
Subject: [PATCH] Change the pci express controller node name from pci to pcie
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Message-Id: <1184643035.23157.3.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 17 Jul 2007 11:30:36 +0800
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

Change the pci express controller node name from pci
to pcie in device tree.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Based on Kumar tree and my previous patch for 8544DS
board.

 arch/powerpc/boot/dts/mpc8544ds.dts    |    6 +++---
 arch/powerpc/boot/dts/mpc8548cds.dts   |    2 +-
 arch/powerpc/boot/dts/mpc8641_hpcn.dts |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index aab0bc6..3f33af6 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -174,7 +174,7 @@
 			reg = <8000 1000>;
 		};
 
-		pci@a000 {
+		pcie@a000 {
 			compatible = "fsl,mpc8548-pcie";
 			device_type = "pci";
 			#interrupt-cells = <1>;
@@ -197,7 +197,7 @@
 				>;
 		};
 
-		pci@9000 {
+		pcie@9000 {
 			compatible = "fsl,mpc8548-pcie";
 			device_type = "pci";
 			#interrupt-cells = <1>;
@@ -220,7 +220,7 @@
 				>;
 		};
 
-		pci@b000 {
+		pcie@b000 {
 			compatible = "fsl,mpc8548-pcie";
 			device_type = "pci";
 			#interrupt-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index c241e4f..4770a5b 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -310,7 +310,7 @@
 			device_type = "pci";
 		};
 		/* PCI Express */
-		pci@a000 {
+		pcie@a000 {
 			interrupt-map-mask = <f800 0 0 7>;
 			interrupt-map = <
 
diff --git a/arch/powerpc/boot/dts/mpc8641_hpcn.dts b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
index e3cc97a..d1a8e0b 100644
--- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
+++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
@@ -207,7 +207,7 @@
 			interrupt-parent = <&mpic>;
 		};
 
-		pci@8000 {
+		pcie@8000 {
 			compatible = "fsl,mpc8641-pcie";
 			device_type = "pci";
 			#interrupt-cells = <1>;
@@ -395,7 +395,7 @@
 
 		};
 
-		pci@9000 {
+		pcie@9000 {
 			compatible = "fsl,mpc8641-pcie";
 			device_type = "pci";
 			#interrupt-cells = <1>;
-- 
1.5.1
