Return-Path: <avorontsov@ru.mvista.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D3B2FB70D9
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 01:19:35 +1000 (EST)
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 0DEC3DDEDB
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 01:19:34 +1000 (EST)
Date: Wed, 10 Jun 2009 19:19:26 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/83xx: Update sdhci nodes per new bindings
Message-ID: <20090610151926.GA32386@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As of commit 404614728f857d0ac63d29c3a29d0cf392a15598 ("Update FSL
esdhc binding"), we use "fsl,esdhc" compatible entry as a base
match. U-Boot will use the same compatible to fixup esdhc nodes.

This patch updates 83xx dts files so that they conform to the new
bindings.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/boot/dts/mpc8377_mds.dts |    2 +-
 arch/powerpc/boot/dts/mpc8377_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8378_mds.dts |    2 +-
 arch/powerpc/boot/dts/mpc8378_rdb.dts |    2 +-
 arch/powerpc/boot/dts/mpc8379_mds.dts |    2 +-
 arch/powerpc/boot/dts/mpc8379_rdb.dts |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 67bb372..f32c281 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -155,7 +155,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8377-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8377_rdb.dts b/arch/powerpc/boot/dts/mpc8377_rdb.dts
index 0533393..224b4f0 100644
--- a/arch/powerpc/boot/dts/mpc8377_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8377_rdb.dts
@@ -169,7 +169,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8377-esdhc", "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8377-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index a955a57..f720ab9 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -155,7 +155,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8378_rdb.dts b/arch/powerpc/boot/dts/mpc8378_rdb.dts
index 5d90e85..474ea2f 100644
--- a/arch/powerpc/boot/dts/mpc8378_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8378_rdb.dts
@@ -169,7 +169,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8378-esdhc", "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8378-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index d266ddb..4fa221f 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -153,7 +153,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8379-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
diff --git a/arch/powerpc/boot/dts/mpc8379_rdb.dts b/arch/powerpc/boot/dts/mpc8379_rdb.dts
index 98ae95b..d4838af 100644
--- a/arch/powerpc/boot/dts/mpc8379_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8379_rdb.dts
@@ -167,7 +167,7 @@
 			};
 
 			sdhci@2e000 {
-				compatible = "fsl,mpc8379-esdhc";
+				compatible = "fsl,mpc8379-esdhc", "fsl,esdhc";
 				reg = <0x2e000 0x1000>;
 				interrupts = <42 0x8>;
 				interrupt-parent = <&ipic>;
-- 
1.6.3.1
