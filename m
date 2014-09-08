Return-Path: <p.zabel@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A92E1A071E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Sep 2014 19:19:46 +1000 (EST)
From: Philipp Zabel <p.zabel@pengutronix.de>
To: devicetree@vger.kernel.org
Subject: [PATCH v2 2/5] Documentation: Add isl1208 and isl12022 to
 trivial-devices list
Date: Mon,  8 Sep 2014 11:19:17 +0200
Message-Id: <1410167960-554-3-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
References: <1410167960-554-1-git-send-email-p.zabel@pengutronix.de>
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

This patch adds the Intersil ISL1208 and ISL12022 I2C RTCs to the
trivial-devices list. For ISL1208 a deprecated intersil,isl1208
entry is added since that is used in ppa8548.dts.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
Changes since v1:
 - Added deprecated entries that are still in use
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index 72e399c..60ecea5 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -56,6 +56,9 @@ fsl,sgtl5000		SGTL5000: Ultra Low-Power Audio Codec
 gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire Interface
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
+intersil,isl1208	Intersil ISL1208 I2C RTC Chip (deprecated, use isil,isl1208)
+isil,isl1208		Intersil ISL1208 I2C RTC Chip
+isil,isl12022		Intersil ISL12022 I2C RTC Chip
 isil,isl12057		Intersil ISL12057 I2C RTC Chip
 isl,isl12057		Intersil ISL12057 I2C RTC Chip (deprecated, use isil,isl12057)
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
-- 
2.1.0.rc1
