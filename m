Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 24B391A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 19:19:45 +1000 (EST)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: devicetree@vger.kernel.org
Subject: [PATCH v2 0/5] Change vendor prefix for Intersil Corporation
Date: Mon,  8 Sep 2014 11:19:15 +0200
Message-Id: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
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

Hi,

currently there is a wild mixture of isl, isil, and intersil
compatibles in the kernel. I figure at this point it is still
possible to change this to use "isil" everywhere without too
much pain, but it might be preferred to keep the already
documented "isl" prefix, even though it doesn't follow the
convention to use the NASDAQ symbol where available.

This is an updated version of the RFC I've sent previously:
https://www.mail-archive.com/devicetree@vger.kernel.org/msg38505.html

Changes since RFC:
 - Drop powerpc/85xx patch, that device tree set in stone.
 - Added commit summaries where referencing commit ids
 - Added deprecated names to the documentation

regards
Philipp

Philipp Zabel (5):
  of: Change vendor prefix for Intersil Corporation to isil
  Documentation: Add isl1208 and isl12022 to trivial-devices list
  ARM: mvebu: Change vendor prefix for Intersil Corporation to isil
  rtc: rtc-isl12022: Change vendor prefix for Intersil Corporation to
    isil
  rtc: rtc-isl12057: Change vendor prefix for Intersil Corporation to
    isil

 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 6 +++++-
 Documentation/devicetree/bindings/vendor-prefixes.txt     | 4 +++-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts            | 2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts            | 2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts            | 2 +-
 drivers/rtc/rtc-isl12022.c                                | 3 ++-
 drivers/rtc/rtc-isl12057.c                                | 3 ++-
 7 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.1.0.rc1
