Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqmK16KVSzDqZc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 01:39:33 +1000 (AEST)
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:13])
 by leibniz.telenet-ops.be (Postfix) with ESMTP id 3qqm8j1G1tzMrP6N
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
Subject: [PATCH 08/14] powerpc: dts: acadia: DT spelling
 s/#interrupts-parent/#interrupt-parent/
Date: Wed, 20 Apr 2016 17:32:13 +0200
Message-Id: <1461166339-11109-9-git-send-email-geert+renesas@glider.be>
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
 arch/powerpc/boot/dts/acadia.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/acadia.dts b/arch/powerpc/boot/dts/acadia.dts
index 57291f61ffe7021a..86266159521edac2 100644
--- a/arch/powerpc/boot/dts/acadia.dts
+++ b/arch/powerpc/boot/dts/acadia.dts
@@ -183,7 +183,7 @@
 			usb@ef603000 {
 				compatible = "ohci-be";
 				reg = <0xef603000 0x80>;
-				interrupts-parent = <&UIC0>;
+				interrupt-parent = <&UIC0>;
 				interrupts = <0xd 0x4 0xe 0x4>;
 			};
 
-- 
1.9.1
