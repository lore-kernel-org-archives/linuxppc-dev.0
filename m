Return-Path: <brgl@bgdev.pl>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zRdmD6CgFzDqpb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jan 2018 08:37:00 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id f71so11035911wmf.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jan 2018 13:37:00 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] powerpc: dts: use a correct at24 compatible fallback in ac14xx
Date: Wed, 24 Jan 2018 22:36:53 +0100
Message-Id: <20180124213653.4778-1-brgl@bgdev.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using 'at24' as fallback is now deprecated - use the full
'atmel,<model>' string.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/powerpc/boot/dts/ac14xx.dts | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/ac14xx.dts b/arch/powerpc/boot/dts/ac14xx.dts
index 83bcfd865167..0be5c4f3265d 100644
--- a/arch/powerpc/boot/dts/ac14xx.dts
+++ b/arch/powerpc/boot/dts/ac14xx.dts
@@ -176,12 +176,12 @@
 			clock-frequency = <400000>;
 
 			at24@30 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x30>;
 			};
 
 			at24@31 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x31>;
 			};
 
@@ -191,42 +191,42 @@
 			};
 
 			at24@50 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x50>;
 			};
 
 			at24@51 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x51>;
 			};
 
 			at24@52 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x52>;
 			};
 
 			at24@53 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x53>;
 			};
 
 			at24@54 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x54>;
 			};
 
 			at24@55 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x55>;
 			};
 
 			at24@56 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x56>;
 			};
 
 			at24@57 {
-				compatible = "at24,24c01";
+				compatible = "atmel,24c01";
 				reg = <0x57>;
 			};
 
-- 
2.16.1
