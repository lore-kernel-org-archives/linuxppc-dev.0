Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 25F0EDDE1D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 May 2007 16:56:05 +1000 (EST)
Date: Mon, 21 May 2007 08:56:00 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] unbreak lite5200 dts (_pic vs. -pic)
Message-ID: <20070521065600.GD20713@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Unbreak lite5200 dts, which were broken by
5c1992f83304cf2d56934dd6c06709b96e1b0c81


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/boot/dts/lite5200.dts  |    2 +-
 arch/powerpc/boot/dts/lite5200b.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200.dts
===================================================================
--- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200.dts
+++ work-powerpc.git/arch/powerpc/boot/dts/lite5200.dts
@@ -67,7 +67,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200_pic";
+			compatible = "mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
Index: work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
===================================================================
--- work-powerpc.git.orig/arch/powerpc/boot/dts/lite5200b.dts
+++ work-powerpc.git/arch/powerpc/boot/dts/lite5200b.dts
@@ -67,7 +67,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			device_type = "interrupt-controller";
-			compatible = "mpc5200b-pic\0mpc5200_pic";
+			compatible = "mpc5200b-pic\0mpc5200-pic";
 			reg = <500 80>;
 			built-in;
 		};
