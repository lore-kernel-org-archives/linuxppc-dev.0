Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CF8C5DDECA
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 05:40:49 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, galak@kernel.crashing.org
Subject: [PATCH] powerpc/85xx: add new qe properties for QE based chips
Date: Fri,  1 May 2009 15:40:51 -0400
Message-Id: <1241206851-27749-5-git-send-email-Haiying.Wang@freescale.com>
In-Reply-To: <1241206851-27749-4-git-send-email-Haiying.Wang@freescale.com>
References: <1241206851-27749-1-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-2-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-3-git-send-email-Haiying.Wang@freescale.com>
	<1241206851-27749-4-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add fsl,qe-num-riscs and fsl,qe-num-snums to all the devices trees which have qe
node.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts |    2 ++
 arch/powerpc/boot/dts/mpc832x_rdb.dts |    2 ++
 arch/powerpc/boot/dts/mpc836x_mds.dts |    2 ++
 arch/powerpc/boot/dts/mpc836x_rdk.dts |    2 ++
 arch/powerpc/boot/dts/mpc8568mds.dts  |    2 ++
 5 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 6b319f5..436c9c6 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -249,6 +249,8 @@
 		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
 		bus-frequency = <198000000>;
+		fsl,qe-num-riscs = <1>;
+		fsl,qe-num-snums = <28>;
 
 		muram@10000 {
 			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index 4c0c249..9a0952f 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -221,6 +221,8 @@
 		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
 		bus-frequency = <198000000>;
+		fsl,qe-num-riscs = <1>;
+		fsl,qe-num-snums = <28>;
 
 		muram@10000 {
  			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 1207ec8..39ff4c8 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -289,6 +289,8 @@
 		reg = <0xe0100000 0x480>;
 		brg-frequency = <0>;
 		bus-frequency = <396000000>;
+		fsl,qe-num-riscs = <2>;
+		fsl,qe-num-snums = <28>;
 
 		muram@10000 {
  			#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 37b7895..6315d6f 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -198,6 +198,8 @@
 			clock-frequency = <0>;
 			bus-frequency = <0>;
 			brg-frequency = <0>;
+			fsl,qe-num-riscs = <2>;
+			fsl,qe-num-snums = <28>;
 
 			muram@10000 {
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index d2fb639..fcab168 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -362,6 +362,8 @@
 		reg = <0xe0080000 0x480>;
 		brg-frequency = <0>;
 		bus-frequency = <396000000>;
+		fsl,qe-num-riscs = <2>;
+		fsl,qe-num-snums = <28>;
 
 		muram@10000 {
  			#address-cells = <1>;
-- 
1.6.0.2
