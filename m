Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E3DD1A0A70
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 19:04:41 +1000 (EST)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: devicetree@vger.kernel.org
Subject: [RFC PATCH 4/6] powerpc/85xx: Change vendor prefix for Intersil
 Corporation to isil
Date: Wed, 20 Aug 2014 10:43:02 +0200
Message-Id: <1408524184-31928-5-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. At this point, changing the vendor
symbol to the most often used variant, which is equal to the
NASDAQ symbol, isil, should not hurt, since the isl1208 driver
doesn't care either way.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 arch/powerpc/boot/dts/ppa8548.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/ppa8548.dts b/arch/powerpc/boot/dts/ppa8548.dts
index 27b0699..000262b 100644
--- a/arch/powerpc/boot/dts/ppa8548.dts
+++ b/arch/powerpc/boot/dts/ppa8548.dts
@@ -89,7 +89,7 @@
 &soc {
 	i2c@3000 {
 		rtc@6f {
-			compatible = "intersil,isl1208";
+			compatible = "isil,isl1208";
 			reg = <0x6f>;
 		};
 	};
-- 
2.1.0.rc1
