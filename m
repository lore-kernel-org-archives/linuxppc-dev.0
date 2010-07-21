Return-Path: <brad@bradleyehughes.com>
Received: from mail-qy0-f177.google.com (mail-qy0-f177.google.com
	[209.85.216.177]) by ozlabs.org (Postfix) with ESMTP id 64EDC10098A
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 08:04:32 +1000 (EST)
Received: by qyk1 with SMTP id 1so3512140qyk.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 15:04:30 -0700 (PDT)
MIME-Version: 1.0
Sender: brad@bradleyehughes.com
From: Bradley Hughes <bhughes@silicontkx.com>
Date: Wed, 21 Jul 2010 18:04:06 -0400
Message-ID: <AANLkTinaSEyVowG4103g5q-FmFMMMHuXJUeCV2oiSu5-@mail.gmail.com>
Subject: [PATCH v2 1/2] DTS: Change deprecated binding for 85xx-based boards
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The "fsl,85..." style compatible binding was to be deprecated
some time ago.  This patch corrects existing occurrences of
the incorrect binding.  The memory-controller and
l2-cache-controller are the only affected nodes.

Signed-off-by: Bradley Hughes <bhughes@silicontkx.com>
---
 arch/powerpc/boot/dts/mpc8540ads.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8541cds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8544ds.dts  |    4 ++--
 arch/powerpc/boot/dts/mpc8548cds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8555cds.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8560ads.dts |    4 ++--
 arch/powerpc/boot/dts/mpc8568mds.dts |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts
b/arch/powerpc/boot/dts/mpc8540ads.dts
index 9dc2929..8d1bf0f 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -71,14 +71,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts
b/arch/powerpc/boot/dts/mpc8541cds.dts
index 9a3ad31..87ff965 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -71,14 +71,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8541-memory-controller";
+			compatible = "fsl,mpc8541-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8541-l2-cache-controller";
+			compatible = "fsl,mpc8541-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts
b/arch/powerpc/boot/dts/mpc8544ds.dts
index 98e94b4..d793968 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -73,14 +73,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8544-memory-controller";
+			compatible = "fsl,mpc8544-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8544-l2-cache-controller";
+			compatible = "fsl,mpc8544-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts
b/arch/powerpc/boot/dts/mpc8548cds.dts
index 0f52624..a17a557 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -74,14 +74,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8548-memory-controller";
+			compatible = "fsl,mpc8548-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8548-l2-cache-controller";
+			compatible = "fsl,mpc8548-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x80000>;	// L2, 512K
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts
b/arch/powerpc/boot/dts/mpc8555cds.dts
index 065b2f0..5c5614f 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -71,14 +71,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8555-memory-controller";
+			compatible = "fsl,mpc8555-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8555-l2-cache-controller";
+			compatible = "fsl,mpc8555-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts
b/arch/powerpc/boot/dts/mpc8560ads.dts
index a5bb1ec..6e85e1b 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -71,14 +71,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8540-memory-controller";
+			compatible = "fsl,mpc8540-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8540-l2-cache-controller";
+			compatible = "fsl,mpc8540-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x40000>;	// L2, 256K
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts
b/arch/powerpc/boot/dts/mpc8568mds.dts
index 92fb178..30cf0e0 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -124,14 +124,14 @@
 		};

 		memory-controller@2000 {
-			compatible = "fsl,8568-memory-controller";
+			compatible = "fsl,mpc8568-memory-controller";
 			reg = <0x2000 0x1000>;
 			interrupt-parent = <&mpic>;
 			interrupts = <18 2>;
 		};

 		L2: l2-cache-controller@20000 {
-			compatible = "fsl,8568-l2-cache-controller";
+			compatible = "fsl,mpc8568-l2-cache-controller";
 			reg = <0x20000 0x1000>;
 			cache-line-size = <32>;	// 32 bytes
 			cache-size = <0x80000>;	// L2, 512K
-- 
1.7.0.4
