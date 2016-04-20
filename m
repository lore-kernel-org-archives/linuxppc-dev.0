Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be [195.130.137.77])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmJx70f0zDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:39:29 +1000 (AEST)
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by leibniz.telenet-ops.be (Postfix) with ESMTP id 3qqm8k1kCNzMrQWR
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
Subject: [PATCH 06/14] dmaengine: bcm2835: DT spelling
 s/interrupts-names/interrupt-names/
Date: Wed, 20 Apr 2016 17:32:11 +0200
Message-Id: <1461166339-11109-7-git-send-email-geert+renesas@glider.be>
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
 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 drivers/dma/bcm2835-dma.c                                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
index 55b53e1fd72c9d6e..e0b6165c9cfcec19 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
@@ -43,7 +43,7 @@ mcbsp0: mcbsp@1d10000 {
 		<0x00310000 0x1000>;
 	reg-names = "mpu", "dat";
 	interrupts = <97 98>;
-	interrupts-names = "rx", "tx";
+	interrupt-names = "rx", "tx";
 	dmas = <&edma0 3 1
 		&edma0 2 1>;
 	dma-names = "tx", "rx";
diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 974015193b93cdb3..d724393e904e9a41 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -974,7 +974,7 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 
 		/* legacy device tree case handling */
 		dev_warn_once(&pdev->dev,
-			      "missing interrupts-names property in device tree - legacy interpretation is used");
+			      "missing interrupt-names property in device tree - legacy interpretation is used");
 		/*
 		 * in case of channel >= 11
 		 * use the 11th interrupt and that is shared
-- 
1.9.1
