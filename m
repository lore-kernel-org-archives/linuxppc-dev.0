Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 9D3A8DDF7C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 01:38:21 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 4xx: Change dts files to support jumbo frames
Date: Thu,  3 Apr 2008 16:38:11 +0200
Message-Id: <1207233491-22371-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes the "max-frame-size" property to 9000 for all gbit
enabled 4xx boards. All those ports generally support jumbo frames, so
let's give the user a chance to enable it.

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/haleakala.dts |    2 +-
 arch/powerpc/boot/dts/katmai.dts    |    2 +-
 arch/powerpc/boot/dts/kilauea.dts   |    4 ++--
 arch/powerpc/boot/dts/makalu.dts    |    4 ++--
 arch/powerpc/boot/dts/rainier.dts   |    4 ++--
 arch/powerpc/boot/dts/sequoia.dts   |    4 ++--
 arch/powerpc/boot/dts/taishan.dts   |    4 ++--
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/haleakala.dts b/arch/powerpc/boot/dts/haleakala.dts
index 02e4ba3..b5d95ac 100644
--- a/arch/powerpc/boot/dts/haleakala.dts
+++ b/arch/powerpc/boot/dts/haleakala.dts
@@ -218,7 +218,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
diff --git a/arch/powerpc/boot/dts/katmai.dts b/arch/powerpc/boot/dts/katmai.dts
index fc86e5a..cc2873a 100644
--- a/arch/powerpc/boot/dts/katmai.dts
+++ b/arch/powerpc/boot/dts/katmai.dts
@@ -212,7 +212,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "gmii";
diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 8baef61..48c9a6e 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -219,7 +219,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
@@ -247,7 +247,7 @@
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
diff --git a/arch/powerpc/boot/dts/makalu.dts b/arch/powerpc/boot/dts/makalu.dts
index 710c011..84cc5e7 100644
--- a/arch/powerpc/boot/dts/makalu.dts
+++ b/arch/powerpc/boot/dts/makalu.dts
@@ -219,7 +219,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
@@ -247,7 +247,7 @@
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
diff --git a/arch/powerpc/boot/dts/rainier.dts b/arch/powerpc/boot/dts/rainier.dts
index 9f6f58b..6a8fa70 100644
--- a/arch/powerpc/boot/dts/rainier.dts
+++ b/arch/powerpc/boot/dts/rainier.dts
@@ -269,7 +269,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
@@ -298,7 +298,7 @@
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
diff --git a/arch/powerpc/boot/dts/sequoia.dts b/arch/powerpc/boot/dts/sequoia.dts
index 675026b..a1ae4d6 100644
--- a/arch/powerpc/boot/dts/sequoia.dts
+++ b/arch/powerpc/boot/dts/sequoia.dts
@@ -284,7 +284,7 @@
 				mal-tx-channel = <0>;
 				mal-rx-channel = <0>;
 				cell-index = <0>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
@@ -313,7 +313,7 @@
 				mal-tx-channel = <1>;
 				mal-rx-channel = <1>;
 				cell-index = <1>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
diff --git a/arch/powerpc/boot/dts/taishan.dts b/arch/powerpc/boot/dts/taishan.dts
index 96d033d..e808e1c 100644
--- a/arch/powerpc/boot/dts/taishan.dts
+++ b/arch/powerpc/boot/dts/taishan.dts
@@ -304,7 +304,7 @@
 				mal-tx-channel = <2>;
 				mal-rx-channel = <2>;
 				cell-index = <2>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
@@ -328,7 +328,7 @@
 				mal-tx-channel = <3>;
 				mal-rx-channel = <3>;
 				cell-index = <3>;
-				max-frame-size = <5dc>;
+				max-frame-size = <2328>;
 				rx-fifo-size = <1000>;
 				tx-fifo-size = <800>;
 				phy-mode = "rgmii";
-- 
1.5.4.5
