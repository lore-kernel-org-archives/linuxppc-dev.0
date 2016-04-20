Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmK15VMwzDqZb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:39:33 +1000 (AEST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by leibniz.telenet-ops.be (Postfix) with ESMTP id 3qqm8j1Bv6zMrP5t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:32:21 +0200 (CEST)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>,
 Mark Brown <broonie@kernel.org>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Joe Perches <joe@perches.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 14/14] regulator: ti-abb: DT spelling s/#{address,
 size}-cell/#{address, size}-cells/
Date: Wed, 20 Apr 2016 17:32:19 +0200
Message-Id: <1461166339-11109-15-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/regulator/ti-abb-regulator.txt         | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
index c58db75f959e601f..c3f6546ebac77742 100644
--- a/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/ti-abb-regulator.txt
@@ -14,8 +14,8 @@ Required Properties:
   - "setup-address"	- contains setup register address of ABB module (ti,abb-v3)
   - "int-address"	- contains address of interrupt register for ABB module
   (also see Optional properties)
-- #address-cell: should be 0
-- #size-cell: should be 0
+- #address-cells: should be 0
+- #size-cells: should be 0
 - clocks: should point to the clock node used by ABB module
 - ti,settling-time: Settling time in uSecs from SoC documentation for ABB module
 	to settle down(target time for SR2_WTCNT_VALUE).
@@ -69,7 +69,7 @@ Example #1: Simplest configuration (no efuse data, hard coded ABB table):
 abb_x: regulator-abb-x {
 	compatible = "ti,abb-v1";
 	regulator-name = "abb_x";
-	#address-cell = <0>;
+	#address-cells = <0>;
 	#size-cells = <0>;
 	reg = <0x483072f0 0x8>, <0x48306818 0x4>;
 	reg-names = "base-address", "int-address";
@@ -89,7 +89,7 @@ Example #2: Efuse bits contain ABB mode setting (no LDO override capability)
 abb_y: regulator-abb-y {
 	compatible = "ti,abb-v2";
 	regulator-name = "abb_y";
-	#address-cell = <0>;
+	#address-cells = <0>;
 	#size-cells = <0>;
 	reg = <0x4a307bd0 0x8>, <0x4a306014 0x4>, <0x4A002268 0x8>;
 	reg-names = "base-address", "int-address", "efuse-address";
@@ -110,7 +110,7 @@ Example #3: Efuse bits contain ABB mode setting and LDO override capability
 abb_z: regulator-abb-z {
 	compatible = "ti,abb-v2";
 	regulator-name = "abb_z";
-	#address-cell = <0>;
+	#address-cells = <0>;
 	#size-cells = <0>;
 	reg = <0x4ae07ce4 0x8>, <0x4ae06010 0x4>,
 	      <0x4a002194 0x8>, <0x4ae0C314 0x4>;
-- 
1.9.1
