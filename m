Return-Path: <alexandre.belloni@free-electrons.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zjqTg6zgxzF1YT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 10:43:28 +1100 (AEDT)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH RESEND] powerpc/5200: dts: digsy_mtc.dts: fix rv3029 compatible
Date: Sat, 17 Feb 2018 00:43:23 +0100
Message-Id: <20180216234323.27601-1-alexandre.belloni@bootlin.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The proper compatible for rv3029 is microcrystal,rv3029.

Acked-by: Anatolij Gustschin <agust@denx.de>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

Hi,

I'm resending that one because I prefer not taking DT patches through the RTC
tree.

 arch/powerpc/boot/dts/digsy_mtc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index c280e75c86bf..c3922fc03e0b 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -78,7 +78,7 @@
 			};
 
 			rtc@56 {
-				compatible = "mc,rv3029c2";
+				compatible = "microcrystal,rv3029";
 				reg = <0x56>;
 			};
 
-- 
2.16.1
