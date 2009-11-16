Return-Path: <dbaryshkov@gmail.com>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 2263E1008F5
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:59:08 +1100 (EST)
Received: by gxk28 with SMTP id 28so3150662gxk.9
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 05:59:07 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 4/4] mpc8349emitx: add leds-gpio binding
Date: Mon, 16 Nov 2009 16:58:54 +0300
Message-Id: <1258379934-32352-5-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
References: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/boot/dts/mpc8349emitx.dts |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 097950c..fb58a7c 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -318,6 +318,24 @@
 			reg = <0x700 0x100>;
 			device_type = "ipic";
 		};
+
+		gpio-leds {
+			compatible = "gpio-leds";
+
+			green {
+				label = "Green";
+				gpios = <&pcf1 0 1>;
+				linux,default-trigger = "heartbeat";
+			};
+
+			yellow {
+				label = "Yellow";
+				gpios = <&pcf1 1 1>;
+				/* linux,default-trigger = "heartbeat"; */
+				default-state = "on";
+			};
+		};
+
 	};
 
 	pci0: pci@e0008500 {
-- 
1.6.5
