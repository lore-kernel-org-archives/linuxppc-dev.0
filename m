Return-Path: <B22826@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6121EB7B83
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 19:20:24 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n8N9KLhS023833
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 02:20:21 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id n8N9KCYr019466
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Sep 2009 04:20:21 -0500 (CDT)
From: Gao Guanhua <B22826@freescale.com>
To: sdhci-devel@lists.ossman.eu
Subject: [PATCH 6/6] P2020DS: Remove sdhci-dma-broken and
	sdhci-ahb2mag-irq-bypass properties
Date: Wed, 23 Sep 2009 17:08:12 +0800
Message-Id: <1253696892-15262-6-git-send-email-B22826@freescale.com>
In-Reply-To: <1253696892-15262-5-git-send-email-B22826@freescale.com>
References: <1253696892-15262-1-git-send-email-B22826@freescale.com>
	<1253696892-15262-2-git-send-email-B22826@freescale.com>
	<1253696892-15262-3-git-send-email-B22826@freescale.com>
	<1253696892-15262-4-git-send-email-B22826@freescale.com>
	<1253696892-15262-5-git-send-email-B22826@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gao Guanhua <B22826@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SDHC on P2020DS board use DMA mode by default.
This patch remove the properties used in PIO mode.
---
 arch/powerpc/boot/dts/p2020ds.dts |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/dts/p2020ds.dts b/arch/powerpc/boot/dts/p2020ds.dts
index 29989fb..3263397 100644
--- a/arch/powerpc/boot/dts/p2020ds.dts
+++ b/arch/powerpc/boot/dts/p2020ds.dts
@@ -459,8 +459,6 @@
 			reg = <0x2e000 0x1000>;
 			interrupts = <72 0x2>;
 			interrupt-parent = <&mpic>;
-			fsl,sdhci-dma-broken;
-			fsl,sdhci-ahb2mag-irq-bypass;
 			fsl,sdhci-adjust-timeout;
 			clock-frequency = <0>;
 		};
-- 
1.6.4
