Return-Path: <B38951@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6F3CA2C0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Aug 2012 12:31:25 +1000 (EST)
From: Jia Hongtao <B38951@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: add adt7461 thermal monitor support to applicable
 boards
Date: Tue, 28 Aug 2012 10:00:55 +0800
Message-ID: <1346119255-19031-1-git-send-email-B38951@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: b38951@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add thermal monitor support to following boards:
P1022DS, MPC8536DS, P2041RDB, P3041DS, P4080DS, P5020DS, P5040DS

Signed-off-by: Jia Hongtao <B38951@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/boot/dts/mpc8536ds.dtsi |    4 ++++
 arch/powerpc/boot/dts/p1022ds.dtsi   |    4 ++++
 arch/powerpc/boot/dts/p2041rdb.dts   |    4 ++++
 arch/powerpc/boot/dts/p3041ds.dts    |    4 ++++
 arch/powerpc/boot/dts/p4080ds.dts    |    4 ++++
 arch/powerpc/boot/dts/p5020ds.dts    |    4 ++++
 arch/powerpc/boot/dts/p5040ds.dts    |    4 ++++
 7 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8536ds.dtsi b/arch/powerpc/boot/dts/mpc8536ds.dtsi
index d304a2d..7c3dde8 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dtsi
+++ b/arch/powerpc/boot/dts/mpc8536ds.dtsi
@@ -132,6 +132,10 @@
 			reg = <0x68>;
 			interrupts = <0 0x1 0 0>;
 		};
+		adt7461@4c {
+			compatible = "adi,adt7461";
+			reg = <0x4c>;
+		};
 	};
 
 	spi@7000 {
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
index c3344b0..873da35 100644
--- a/arch/powerpc/boot/dts/p1022ds.dtsi
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -149,6 +149,10 @@
 			compatible = "dallas,ds1339";
 			reg = <0x68>;
 		};
+		adt7461@4c {
+			compatible = "adi,adt7461";
+			reg = <0x4c>;
+		};
 	};
 
 	spi@7000 {
diff --git a/arch/powerpc/boot/dts/p2041rdb.dts b/arch/powerpc/boot/dts/p2041rdb.dts
index baab034..d97ad74 100644
--- a/arch/powerpc/boot/dts/p2041rdb.dts
+++ b/arch/powerpc/boot/dts/p2041rdb.dts
@@ -94,6 +94,10 @@
 				compatible = "pericom,pt7c4338";
 				reg = <0x68>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 
 		i2c@118100 {
diff --git a/arch/powerpc/boot/dts/p3041ds.dts b/arch/powerpc/boot/dts/p3041ds.dts
index 6cdcadc..2fed3bc 100644
--- a/arch/powerpc/boot/dts/p3041ds.dts
+++ b/arch/powerpc/boot/dts/p3041ds.dts
@@ -98,6 +98,10 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 3e20460..1cf6148 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -96,6 +96,10 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 
 		usb0: usb@210000 {
diff --git a/arch/powerpc/boot/dts/p5020ds.dts b/arch/powerpc/boot/dts/p5020ds.dts
index 27c07ed..2869fea 100644
--- a/arch/powerpc/boot/dts/p5020ds.dts
+++ b/arch/powerpc/boot/dts/p5020ds.dts
@@ -98,6 +98,10 @@
 				reg = <0x68>;
 				interrupts = <0x1 0x1 0 0>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 	};
 
diff --git a/arch/powerpc/boot/dts/p5040ds.dts b/arch/powerpc/boot/dts/p5040ds.dts
index d86bf2e..8165c93 100644
--- a/arch/powerpc/boot/dts/p5040ds.dts
+++ b/arch/powerpc/boot/dts/p5040ds.dts
@@ -146,6 +146,10 @@
 				label = "NAND Writable User area";
 				reg = <0x1f000000 0x01000000>;
 			};
+			adt7461@4c {
+				compatible = "adi,adt7461";
+				reg = <0x4c>;
+			};
 		};
 
 		board-control@3,0 {
-- 
1.7.5.1
