Return-Path: <STFD002@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3DDA0B6EEE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 00:41:20 +1100 (EST)
Received: from mail90-ch1 (localhost [127.0.0.1])	by mail90-ch1-R.bigfish.com
 (Postfix) with ESMTP id 6FA131E016C	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Feb 2012 13:41:14 +0000 (UTC)
Received: from CH1EHSMHS015.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.243])	by mail90-ch1.bigfish.com (Postfix) with ESMTP id
 825142E0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2012 13:41:12 +0000 (UTC)
From: Diana Craciun <diana.craciun@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/dts: Removed fsl,msi property from dts.
Date: Thu, 9 Feb 2012 15:41:00 +0200
Message-ID: <1328794860-12592-1-git-send-email-diana.craciun@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Diana CRACIUN <Diana.Craciun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Diana CRACIUN <Diana.Craciun@freescale.com>

The association in the decice tree between PCI and MSI
using fsl,msi property was an artificial one and it does
not reflect the actual hardware.

Signed-off-by: Diana CRACIUN <Diana.Craciun@freescale.com>
---
 arch/powerpc/boot/dts/p2041rdb.dts |    3 ---
 arch/powerpc/boot/dts/p3041ds.dts  |    4 ----
 arch/powerpc/boot/dts/p3060qds.dts |    2 --
 arch/powerpc/boot/dts/p4080ds.dts  |    3 ---
 arch/powerpc/boot/dts/p5020ds.dts  |    4 ----
 5 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index 4f957db..2852139 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -135,7 +135,6 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -151,7 +150,6 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -167,7 +165,6 @@
 		reg = <0xf 0xfe202000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index f469145..22a215e 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -173,7 +173,6 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -189,7 +188,6 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -205,7 +203,6 @@
 		reg = <0xf 0xfe202000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -221,7 +218,6 @@
 		reg = <0xf 0xfe203000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p3060qds.dts b/arch/powerpc/boot/dts/p3060qds.dts
index 529042e..9ae875c 100644
--- a/arch/powerpc/boot/dts/p3060qds.dts
+++ b/arch/powerpc/boot/dts/p3060qds.dts
@@ -212,7 +212,6 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -228,7 +227,6 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6d60e54..3e20460 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -141,7 +141,6 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -157,7 +156,6 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -173,7 +171,6 @@
 		reg = <0xf 0xfe202000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 1c25068..27c07ed 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -173,7 +173,6 @@
 		reg = <0xf 0xfe200000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
-		fsl,msi = <&msi0>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -189,7 +188,6 @@
 		reg = <0xf 0xfe201000 0 0x1000>;
 		ranges = <0x02000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
 			  0x01000000 0x0 0x00000000 0xf 0xf8010000 0x0 0x00010000>;
-		fsl,msi = <&msi1>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -205,7 +203,6 @@
 		reg = <0xf 0xfe202000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x40000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8020000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
@@ -221,7 +218,6 @@
 		reg = <0xf 0xfe203000 0 0x1000>;
 		ranges = <0x02000000 0 0xe0000000 0xc 0x60000000 0 0x20000000
 			  0x01000000 0 0x00000000 0xf 0xf8030000 0 0x00010000>;
-		fsl,msi = <&msi2>;
 		pcie@0 {
 			ranges = <0x02000000 0 0xe0000000
 				  0x02000000 0 0xe0000000
-- 
1.7.3.4
