Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmJy14b1zDqb6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:39:30 +1000 (AEST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by leibniz.telenet-ops.be (Postfix) with ESMTP id 3qqm8k1QZszMrP6G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 17:32:22 +0200 (CEST)
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
Subject: [PATCH 11/14] PCI: hisi: DT spelling s/interrupts-*/interrupt-*/
Date: Wed, 20 Apr 2016 17:32:16 +0200
Message-Id: <1461166339-11109-12-git-send-email-geert+renesas@glider.be>
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
 Documentation/devicetree/bindings/pci/hisilicon-pcie.txt | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
index b721beacfe4dae6c..59c2f47aa303ae24 100644
--- a/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/hisilicon-pcie.txt
@@ -34,11 +34,11 @@ Hip05 Example (note that Hip06 is the same except compatible):
 		ranges = <0x82000000 0 0x00000000 0x220 0x00000000 0 0x10000000>;
 		num-lanes = <8>;
 		port-id = <1>;
-		#interrupts-cells = <1>;
-		interrupts-map-mask = <0xf800 0 0 7>;
-		interrupts-map = <0x0 0 0 1 &mbigen_pcie 1 10
-				  0x0 0 0 2 &mbigen_pcie 2 11
-				  0x0 0 0 3 &mbigen_pcie 3 12
-				  0x0 0 0 4 &mbigen_pcie 4 13>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0xf800 0 0 7>;
+		interrupt-map = <0x0 0 0 1 &mbigen_pcie 1 10
+				 0x0 0 0 2 &mbigen_pcie 2 11
+				 0x0 0 0 3 &mbigen_pcie 3 12
+				 0x0 0 0 4 &mbigen_pcie 4 13>;
 		status = "ok";
 	};
-- 
1.9.1
