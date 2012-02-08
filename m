Return-Path: <B38951@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 64A56B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 20:30:25 +1100 (EST)
Received: from mail187-tx2 (localhost [127.0.0.1])	by
 mail187-tx2-R.bigfish.com (Postfix) with ESMTP id 776431001D9	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 09:30:11 +0000 (UTC)
Received: from TX2EHSMHS015.bigfish.com (unknown [10.9.14.248])	by
 mail187-tx2.bigfish.com (Postfix) with ESMTP id AC61C380049	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2012 09:30:09 +0000 (UTC)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/85xx: Change style of partition nodes in dts for
 MPC8572DS
Date: Wed, 8 Feb 2012 17:27:55 +0800
Message-ID: <1328693276-12057-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8572ds.dtsi |   44 ++++++++++++++++++++--------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8572ds.dtsi b/arch/powerpc/boot/dts/mpc8572ds.dtsi
index c3d4fac..e10fa61 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8572ds.dtsi
@@ -41,37 +41,41 @@
 		bank-width = <2>;
 		device-width = <1>;
 
-		ramdisk@0 {
+		partition@0 {
 			reg = <0x0 0x03000000>;
-			read-only;
+			label = "ramdisk-nor";
 		};
 
-		diagnostic@3000000 {
+		partition@3000000 {
 			reg = <0x03000000 0x00e00000>;
+			label = "diagnostic-nor";
 			read-only;
 		};
 
-		dink@3e00000 {
+		partition@3e00000 {
 			reg = <0x03e00000 0x00200000>;
+			label = "dink-nor";
 			read-only;
 		};
 
-		kernel@4000000 {
+		partition@4000000 {
 			reg = <0x04000000 0x00400000>;
-			read-only;
+			label = "kernel-nor";
 		};
 
-		jffs2@4400000 {
+		partition@4400000 {
 			reg = <0x04400000 0x03b00000>;
+			label = "fs-nor";
 		};
 
-		dtb@7f00000 {
+		partition@7f00000 {
 			reg = <0x07f00000 0x00080000>;
-			read-only;
+			label = "dtb-nor";
 		};
 
-		u-boot@7f80000 {
+		partition@7f80000 {
 			reg = <0x07f80000 0x00080000>;
+			label = "u-boot-nor";
 			read-only;
 		};
 	};
@@ -83,31 +87,35 @@
 			     "fsl,elbc-fcm-nand";
 		reg = <0x2 0x0 0x40000>;
 
-		u-boot@0 {
+		partition@0 {
 			reg = <0x0 0x02000000>;
+			label = "u-boot-nand";
 			read-only;
 		};
 
-		jffs2@2000000 {
+		partition@2000000 {
 			reg = <0x02000000 0x10000000>;
+			label = "fs-nand";
 		};
 
-		ramdisk@12000000 {
+		partition@12000000 {
 			reg = <0x12000000 0x08000000>;
-			read-only;
+			label = "ramdisk-nand";
 		};
 
-		kernel@1a000000 {
+		partition@1a000000 {
 			reg = <0x1a000000 0x04000000>;
+			label = "kernel-nand";
 		};
 
-		dtb@1e000000 {
+		partition@1e000000 {
 			reg = <0x1e000000 0x01000000>;
-			read-only;
+			label = "dtb-nand";
 		};
 
-		empty@1f000000 {
+		partition@1f000000 {
 			reg = <0x1f000000 0x21000000>;
+			label = "empty-nand";
 		};
 	};
 
-- 
1.7.5.1
