Return-Path: <B36685@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C6D8F2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2012 21:15:37 +1000 (EST)
From: Shengzhou Liu <Shengzhou.Liu@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH 1/2] powerpc/p4080ds: dts - add usb controller version info
 and port0
Date: Fri, 10 Aug 2012 18:48:31 +0800
Message-ID: <1344595712-12804-1-git-send-email-Shengzhou.Liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add the missing usb controller version info and port0, which is
required during setup usb phy.

Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 8d35d2c..4f9c9f6 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -345,6 +345,13 @@
 /include/ "qoriq-duart-1.dtsi"
 /include/ "qoriq-gpio-0.dtsi"
 /include/ "qoriq-usb2-mph-0.dtsi"
+	usb@210000 {
+		compatible = "fsl-usb2-mph-v1.6", "fsl,mpc85xx-usb2-mph", "fsl-usb2-mph";
+		port0;
+	};
 /include/ "qoriq-usb2-dr-0.dtsi"
+	usb@211000 {
+		compatible = "fsl-usb2-dr-v1.6", "fsl,mpc85xx-usb2-dr", "fsl-usb2-dr";
+	};
 /include/ "qoriq-sec4.0-0.dtsi"
 };
-- 
1.6.4
