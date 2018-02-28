Return-Path: <marcus.folkesson@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com
 [IPv6:2a00:1450:4010:c07::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrzMM35RtzF1Zy
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 02:02:55 +1100 (AEDT)
Received: by mail-lf0-x244.google.com with SMTP id y19so3975479lfd.4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 07:02:55 -0800 (PST)
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Support Opensource <support.opensource@diasemi.com>,
 Baruch Siach <baruch@tkos.co.il>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Jimmy Vance <jimmy.vance@hpe.com>, Keguang Zhang <keguang.zhang@gmail.com>,
 Joachim Eastwood <manabian@gmail.com>,
 Tomas Winkler <tomas.winkler@intel.com>,
 Johannes Thumshirn <morbidrsa@gmail.com>,
 Andreas Werner <andreas.werner@men.de>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Wan ZongShun <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>, Zwane Mwaikambo <zwanem@gmail.com>,
 Jim Cromie <jim.cromie@gmail.com>, Barry Song <baohua@kernel.org>,
 Patrice Chotard <patrice.chotard@st.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 Marc Gonzalez <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
Date: Wed, 28 Feb 2018 16:01:58 +0100
Message-Id: <20180228150209.2525-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

- Add SPDX identifier
- Remove boiler plate license text
- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
  license

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Baruch Siach <baruch@tkos.co.il>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
Acked-by: Johannes Thumshirn <jth@kernel.org>
Acked-by: Mans Rullgard <mans@mansr.com>
Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Reviewed-by: Eric Anholt <eric@anholt.net>
---

Notes:
    v4:
    	- Drop coh901327_wdt since it allready is a pending patch
    v3:
    	- Keep license text for ebc-c384_wdt
    v2:
    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
    	- Change to BSD-3-Clause for meson_gxbb_wdt
    v1: Please have an extra look at meson_gxbb_wdt.c

 drivers/watchdog/acquirewdt.c          |  6 +---
 drivers/watchdog/advantechwdt.c        |  6 +---
 drivers/watchdog/alim1535_wdt.c        |  6 +---
 drivers/watchdog/alim7101_wdt.c        |  1 +
 drivers/watchdog/ar7_wdt.c             | 14 +---------
 drivers/watchdog/asm9260_wdt.c         |  2 +-
 drivers/watchdog/aspeed_wdt.c          |  5 +---
 drivers/watchdog/at91rm9200_wdt.c      |  5 +---
 drivers/watchdog/at91sam9_wdt.c        |  5 +---
 drivers/watchdog/at91sam9_wdt.h        |  5 +---
 drivers/watchdog/ath79_wdt.c           |  4 +--
 drivers/watchdog/atlas7_wdt.c          |  2 +-
 drivers/watchdog/bcm2835_wdt.c         |  5 +---
 drivers/watchdog/bcm47xx_wdt.c         |  5 +---
 drivers/watchdog/bcm63xx_wdt.c         |  5 +---
 drivers/watchdog/bcm7038_wdt.c         | 12 ++------
 drivers/watchdog/bcm_kona_wdt.c        |  9 +-----
 drivers/watchdog/bfin_wdt.c            |  2 +-
 drivers/watchdog/booke_wdt.c           |  5 +---
 drivers/watchdog/cadence_wdt.c         |  5 +---
 drivers/watchdog/cpu5wdt.c             | 15 +---------
 drivers/watchdog/cpwd.c                |  1 +
 drivers/watchdog/da9052_wdt.c          |  6 +---
 drivers/watchdog/da9055_wdt.c          |  6 +---
 drivers/watchdog/da9062_wdt.c          | 10 +------
 drivers/watchdog/da9063_wdt.c          |  5 +---
 drivers/watchdog/davinci_wdt.c         |  7 ++---
 drivers/watchdog/diag288_wdt.c         |  1 +
 drivers/watchdog/digicolor_wdt.c       |  5 +---
 drivers/watchdog/dw_wdt.c              |  6 +---
 drivers/watchdog/ebc-c384_wdt.c        |  1 +
 drivers/watchdog/ep93xx_wdt.c          |  7 ++---
 drivers/watchdog/eurotechwdt.c         |  6 +---
 drivers/watchdog/f71808e_wdt.c         | 16 +----------
 drivers/watchdog/ftwdt010_wdt.c        |  6 ++--
 drivers/watchdog/gef_wdt.c             |  6 +---
 drivers/watchdog/geodewdt.c            |  5 +---
 drivers/watchdog/gpio_wdt.c            |  5 +---
 drivers/watchdog/hpwdt.c               |  7 ++---
 drivers/watchdog/i6300esb.c            |  6 +---
 drivers/watchdog/iTCO_vendor_support.c |  9 +-----
 drivers/watchdog/iTCO_wdt.c            | 10 +------
 drivers/watchdog/ib700wdt.c            |  6 +---
 drivers/watchdog/ibmasr.c              |  3 +-
 drivers/watchdog/ie6xx_wdt.c           | 18 ++----------
 drivers/watchdog/imgpdc_wdt.c          |  5 +---
 drivers/watchdog/imx2_wdt.c            |  5 +---
 drivers/watchdog/indydog.c             |  6 +---
 drivers/watchdog/intel-mid_wdt.c       |  6 ++--
 drivers/watchdog/intel_scu_watchdog.c  | 18 ++----------
 drivers/watchdog/intel_scu_watchdog.h  | 16 +----------
 drivers/watchdog/iop_wdt.c             | 16 ++---------
 drivers/watchdog/it8712f_wdt.c         | 10 +------
 drivers/watchdog/it87_wdt.c            | 10 +------
 drivers/watchdog/ixp4xx_wdt.c          |  6 ++--
 drivers/watchdog/jz4740_wdt.c          | 10 +------
 drivers/watchdog/kempld_wdt.c          | 12 ++------
 drivers/watchdog/ks8695_wdt.c          |  6 ++--
 drivers/watchdog/lantiq_wdt.c          |  7 ++---
 drivers/watchdog/loongson1_wdt.c       |  5 +---
 drivers/watchdog/lpc18xx_wdt.c         |  5 +---
 drivers/watchdog/m54xx_wdt.c           |  6 ++--
 drivers/watchdog/machzwd.c             | 11 +-------
 drivers/watchdog/max63xx_wdt.c         |  5 +---
 drivers/watchdog/max77620_wdt.c        |  5 +---
 drivers/watchdog/mei_wdt.c             | 12 ++------
 drivers/watchdog/mena21_wdt.c          |  4 +--
 drivers/watchdog/menf21bmc_wdt.c       |  8 ++----
 drivers/watchdog/meson_gxbb_wdt.c      | 50 +---------------------------------
 drivers/watchdog/meson_wdt.c           |  6 +---
 drivers/watchdog/mixcomwd.c            |  6 +---
 drivers/watchdog/moxart_wdt.c          |  7 ++---
 drivers/watchdog/mpc8xxx_wdt.c         |  6 +---
 drivers/watchdog/mt7621_wdt.c          |  5 +---
 drivers/watchdog/mtk_wdt.c             | 11 +-------
 drivers/watchdog/mtx-1_wdt.c           | 11 +-------
 drivers/watchdog/mv64x60_wdt.c         |  6 ++--
 drivers/watchdog/ni903x_wdt.c          | 11 +-------
 drivers/watchdog/nic7018_wdt.c         | 11 +-------
 drivers/watchdog/nuc900_wdt.c          |  7 ++---
 drivers/watchdog/nv_tco.c              |  6 +---
 drivers/watchdog/nv_tco.h              | 10 +------
 drivers/watchdog/octeon-wdt-main.c     | 11 +-------
 drivers/watchdog/octeon-wdt-nmi.S      |  5 +---
 drivers/watchdog/of_xilinx_wdt.c       |  8 ++----
 drivers/watchdog/omap_wdt.c            |  1 +
 drivers/watchdog/omap_wdt.h            | 21 +-------------
 drivers/watchdog/orion_wdt.c           |  5 +---
 drivers/watchdog/pc87413_wdt.c         | 10 +------
 drivers/watchdog/pcwd.c                |  1 +
 drivers/watchdog/pcwd_pci.c            | 10 +------
 drivers/watchdog/pcwd_usb.c            | 10 +------
 drivers/watchdog/pic32-dmt.c           |  5 +---
 drivers/watchdog/pic32-wdt.c           |  6 +---
 drivers/watchdog/pika_wdt.c            |  1 +
 drivers/watchdog/pnx4008_wdt.c         |  7 ++---
 drivers/watchdog/pnx833x_wdt.c         |  6 +---
 drivers/watchdog/pretimeout_noop.c     |  7 +----
 drivers/watchdog/pretimeout_panic.c    |  7 +----
 drivers/watchdog/qcom-wdt.c            | 14 ++--------
 drivers/watchdog/renesas_wdt.c         |  4 +--
 drivers/watchdog/retu_wdt.c            | 10 +------
 drivers/watchdog/riowd.c               |  1 +
 drivers/watchdog/rn5t618_wdt.c         |  8 +-----
 drivers/watchdog/rt2880_wdt.c          |  5 +---
 drivers/watchdog/rtd119x_wdt.c         |  2 +-
 drivers/watchdog/rza_wdt.c             |  5 +---
 drivers/watchdog/s3c2410_wdt.c         | 11 +-------
 drivers/watchdog/sa1100_wdt.c          | 11 +-------
 drivers/watchdog/sama5d4_wdt.c         |  3 +-
 drivers/watchdog/sb_wdog.c             |  5 +---
 drivers/watchdog/sbc60xxwdt.c          | 10 +------
 drivers/watchdog/sbc7240_wdt.c         | 12 ++------
 drivers/watchdog/sbc8360.c             | 10 +------
 drivers/watchdog/sbc_epx_c3.c          |  6 +---
 drivers/watchdog/sbc_fitpc2_wdt.c      |  7 ++---
 drivers/watchdog/sbsa_gwdt.c           | 10 +------
 drivers/watchdog/sc1200wdt.c           | 10 +------
 drivers/watchdog/sc520_wdt.c           | 10 +------
 drivers/watchdog/sch311x_wdt.c         | 10 +------
 drivers/watchdog/scx200_wdt.c          | 10 ++-----
 drivers/watchdog/shwdt.c               |  6 +---
 drivers/watchdog/sirfsoc_wdt.c         |  5 ++--
 drivers/watchdog/smsc37b787_wdt.c      | 10 +------
 drivers/watchdog/softdog.c             | 10 +------
 drivers/watchdog/sp5100_tco.c          |  6 +---
 drivers/watchdog/sp805_wdt.c           |  5 +---
 drivers/watchdog/sprd_wdt.c            | 10 +------
 drivers/watchdog/st_lpc_wdt.c          |  6 +---
 drivers/watchdog/stmp3xxx_rtc_wdt.c    |  5 +---
 drivers/watchdog/sun4v_wdt.c           |  6 +---
 drivers/watchdog/sunxi_wdt.c           |  6 +---
 drivers/watchdog/tangox_wdt.c          |  6 +---
 drivers/watchdog/tegra_wdt.c           | 10 +------
 drivers/watchdog/ts4800_wdt.c          |  5 +---
 drivers/watchdog/ts72xx_wdt.c          |  7 ++---
 drivers/watchdog/twl4030_wdt.c         | 15 +---------
 drivers/watchdog/txx9wdt.c             |  9 ++----
 drivers/watchdog/uniphier_wdt.c        | 10 +------
 drivers/watchdog/ux500_wdt.c           |  5 ++--
 drivers/watchdog/via_wdt.c             |  4 +--
 drivers/watchdog/w83627hf_wdt.c        | 10 +------
 drivers/watchdog/w83877f_wdt.c         | 10 +------
 drivers/watchdog/w83977f_wdt.c         |  9 +-----
 drivers/watchdog/wafer5823wdt.c        | 11 +-------
 drivers/watchdog/watchdog_core.c       | 10 +------
 drivers/watchdog/watchdog_core.h       | 10 +------
 drivers/watchdog/watchdog_dev.c        | 10 +------
 drivers/watchdog/watchdog_pretimeout.c |  6 +---
 drivers/watchdog/wd501p.h              |  1 +
 drivers/watchdog/wdat_wdt.c            |  5 +---
 drivers/watchdog/wdrtas.c              | 15 +---------
 drivers/watchdog/wdt.c                 | 11 +-------
 drivers/watchdog/wdt285.c              |  7 +----
 drivers/watchdog/wdt977.c              |  8 +-----
 drivers/watchdog/wdt_pci.c             | 11 +-------
 drivers/watchdog/wm831x_wdt.c          |  5 +---
 drivers/watchdog/wm8350_wdt.c          |  5 +---
 drivers/watchdog/xen_wdt.c             |  6 +---
 drivers/watchdog/ziirave_wdt.c         | 11 +-------
 drivers/watchdog/zx2967_wdt.c          |  3 +-
 161 files changed, 193 insertions(+), 1041 deletions(-)

diff --git a/drivers/watchdog/acquirewdt.c b/drivers/watchdog/acquirewdt.c
index d6210d946082..37fb5d85a9b9 100644
--- a/drivers/watchdog/acquirewdt.c
+++ b/drivers/watchdog/acquirewdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Acquire Single Board Computer Watchdog Timer driver
  *
@@ -6,11 +7,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
diff --git a/drivers/watchdog/advantechwdt.c b/drivers/watchdog/advantechwdt.c
index f61944369c1a..16512e3c6e00 100644
--- a/drivers/watchdog/advantechwdt.c
+++ b/drivers/watchdog/advantechwdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Advantech Single Board Computer WDT driver
  *
@@ -9,11 +10,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
diff --git a/drivers/watchdog/alim1535_wdt.c b/drivers/watchdog/alim1535_wdt.c
index 60f0c2eb8531..9b341b1ba97e 100644
--- a/drivers/watchdog/alim1535_wdt.c
+++ b/drivers/watchdog/alim1535_wdt.c
@@ -1,10 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Watchdog for the 7101 PMU version found in the ALi M1535 chipsets
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 12f7ea62dddd..b3233c1edcc5 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	ALi M7101 PMU Computer Watchdog Timer driver
  *
diff --git a/drivers/watchdog/ar7_wdt.c b/drivers/watchdog/ar7_wdt.c
index 6d5ae251e309..ee1ab12ab04f 100644
--- a/drivers/watchdog/ar7_wdt.c
+++ b/drivers/watchdog/ar7_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * drivers/watchdog/ar7_wdt.c
  *
@@ -8,19 +9,6 @@
  * National Semiconductor SCx200 Watchdog support
  * Copyright (c) 2001,2002 Christer Weinigel <wingel@nano-system.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/asm9260_wdt.c b/drivers/watchdog/asm9260_wdt.c
index 7dd0da644a7f..774d5c09d747 100644
--- a/drivers/watchdog/asm9260_wdt.c
+++ b/drivers/watchdog/asm9260_wdt.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for Alphascale ASM9260.
  *
  * Copyright (c) 2014 Oleksij Rempel <linux@rempel-privat.de>
  *
- * Licensed under GPLv2 or later.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
index ca5b91e2eb92..30476a7e7951 100644
--- a/drivers/watchdog/aspeed_wdt.c
+++ b/drivers/watchdog/aspeed_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2016 IBM Corporation
  *
  * Joel Stanley <joel@jms.id.au>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/watchdog/at91rm9200_wdt.c b/drivers/watchdog/at91rm9200_wdt.c
index e12a797cb820..b45fc0aee667 100644
--- a/drivers/watchdog/at91rm9200_wdt.c
+++ b/drivers/watchdog/at91rm9200_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for Atmel AT91RM9200 (Thunder)
  *
  *  Copyright (C) 2003 SAN People (Pty) Ltd
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
index 88c05d0448b2..f4050a229eb5 100644
--- a/drivers/watchdog/at91sam9_wdt.c
+++ b/drivers/watchdog/at91sam9_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for Atmel AT91SAM9x processors.
  *
  * Copyright (C) 2008 Renaud CERRATO r.cerrato@til-technologies.fr
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 /*
diff --git a/drivers/watchdog/at91sam9_wdt.h b/drivers/watchdog/at91sam9_wdt.h
index b79a83b467ce..390941c65eee 100644
--- a/drivers/watchdog/at91sam9_wdt.h
+++ b/drivers/watchdog/at91sam9_wdt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * drivers/watchdog/at91sam9_wdt.h
  *
@@ -7,10 +8,6 @@
  * Watchdog Timer (WDT) - System peripherals regsters.
  * Based on AT91SAM9261 datasheet revision D.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #ifndef AT91_WDT_H
diff --git a/drivers/watchdog/ath79_wdt.c b/drivers/watchdog/ath79_wdt.c
index e2209bf5fa8a..54b124c9d0fa 100644
--- a/drivers/watchdog/ath79_wdt.c
+++ b/drivers/watchdog/ath79_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Atheros AR71XX/AR724X/AR913X built-in hardware watchdog timer.
  *
@@ -11,9 +12,6 @@
  * which again was based on sa1100 driver,
  *	Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  *
  */
 
diff --git a/drivers/watchdog/atlas7_wdt.c b/drivers/watchdog/atlas7_wdt.c
index 4abdcabd8219..e4f4b873028a 100644
--- a/drivers/watchdog/atlas7_wdt.c
+++ b/drivers/watchdog/atlas7_wdt.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for CSR Atlas7
  *
  * Copyright (c) 2015 Cambridge Silicon Radio Limited, a CSR plc group company.
  *
- * Licensed under GPLv2.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/bcm2835_wdt.c b/drivers/watchdog/bcm2835_wdt.c
index b339e0e67b4c..ed05514cc2dc 100644
--- a/drivers/watchdog/bcm2835_wdt.c
+++ b/drivers/watchdog/bcm2835_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for Broadcom BCM2835
  *
@@ -7,10 +8,6 @@
  *
  * Copyright (C) 2013 Lubomir Rintel <lkundrak@v3.sk>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/watchdog/bcm47xx_wdt.c b/drivers/watchdog/bcm47xx_wdt.c
index f41b756d6dd5..05425c1dfd4c 100644
--- a/drivers/watchdog/bcm47xx_wdt.c
+++ b/drivers/watchdog/bcm47xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Watchdog driver for Broadcom BCM47XX
  *
@@ -5,10 +6,6 @@
  *  Copyright (C) 2009 Matthieu CASTET <castet.matthieu@free.fr>
  *  Copyright (C) 2012-2013 Hauke Mehrtens <hauke@hauke-m.de>
  *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 8555afc70f9b..d3c1113e774c 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Broadcom BCM63xx SoC watchdog driver
  *
  *  Copyright (C) 2007, Miguel Gaio <miguel.gaio@efixo.com>
  *  Copyright (C) 2008, Florian Fainelli <florian@openwrt.org>
  *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/bcm7038_wdt.c b/drivers/watchdog/bcm7038_wdt.c
index f88f546e8050..ce3f646e8077 100644
--- a/drivers/watchdog/bcm7038_wdt.c
+++ b/drivers/watchdog/bcm7038_wdt.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Broadcom Corporation
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/clk.h>
@@ -235,6 +227,6 @@ module_platform_driver(bcm7038_wdt_driver);
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
 	__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Driver for Broadcom 7038 SoCs Watchdog");
 MODULE_AUTHOR("Justin Chen");
diff --git a/drivers/watchdog/bcm_kona_wdt.c b/drivers/watchdog/bcm_kona_wdt.c
index a5775dfd8d5f..1462be9e6fc5 100644
--- a/drivers/watchdog/bcm_kona_wdt.c
+++ b/drivers/watchdog/bcm_kona_wdt.c
@@ -1,14 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2013 Broadcom Corporation
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/debugfs.h>
diff --git a/drivers/watchdog/bfin_wdt.c b/drivers/watchdog/bfin_wdt.c
index aa4d2e8a8ef9..5570395fc634 100644
--- a/drivers/watchdog/bfin_wdt.c
+++ b/drivers/watchdog/bfin_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Blackfin On-Chip Watchdog Driver
  *
@@ -8,7 +9,6 @@
  *
  * Enter bugs at http://blackfin.uclinux.org/
  *
- * Licensed under the GPL-2 or later.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 3ad1e44bef44..6fec159e59c4 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog timer for PowerPC Book-E systems
  *
@@ -6,10 +7,6 @@
  *
  * Copyright 2005, 2008, 2010-2011 Freescale Semiconductor Inc.
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/cadence_wdt.c b/drivers/watchdog/cadence_wdt.c
index 064cf7b6c1c5..3ec1f418837d 100644
--- a/drivers/watchdog/cadence_wdt.c
+++ b/drivers/watchdog/cadence_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Cadence WDT driver - Used by Xilinx Zynq
  *
  * Copyright (C) 2010 - 2014 Xilinx, Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/cpu5wdt.c b/drivers/watchdog/cpu5wdt.c
index 6cfb102c397c..b8f9381543ff 100644
--- a/drivers/watchdog/cpu5wdt.c
+++ b/drivers/watchdog/cpu5wdt.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * sma cpu5 watchdog driver
  *
  * Copyright (C) 2003 Heiko Ronsdorf <hero@ihg.uni-duisburg.de>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
index aee0b25cf10d..a21915f783be 100644
--- a/drivers/watchdog/cpwd.c
+++ b/drivers/watchdog/cpwd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* cpwd.c - driver implementation for hardware watchdog
  * timers found on Sun Microsystems CP1400 and CP1500 boards.
  *
diff --git a/drivers/watchdog/da9052_wdt.c b/drivers/watchdog/da9052_wdt.c
index d6d5006efa71..e263bad99574 100644
--- a/drivers/watchdog/da9052_wdt.c
+++ b/drivers/watchdog/da9052_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * System monitoring driver for DA9052 PMICs.
  *
@@ -5,11 +6,6 @@
  *
  * Author: Anthony Olech <Anthony.Olech@diasemi.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/da9055_wdt.c b/drivers/watchdog/da9055_wdt.c
index 50bdd1022186..26a5b2984094 100644
--- a/drivers/watchdog/da9055_wdt.c
+++ b/drivers/watchdog/da9055_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * System monitoring driver for DA9055 PMICs.
  *
@@ -5,11 +6,6 @@
  *
  * Author: David Dajun Chen <dchen@diasemi.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
index 814dff6045a4..a001782bbfdb 100644
--- a/drivers/watchdog/da9062_wdt.c
+++ b/drivers/watchdog/da9062_wdt.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog device driver for DA9062 and DA9061 PMICs
  * Copyright (C) 2015  Dialog Semiconductor Ltd.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/da9063_wdt.c b/drivers/watchdog/da9063_wdt.c
index 2a20fc163ed0..b17ac1bb1f28 100644
--- a/drivers/watchdog/da9063_wdt.c
+++ b/drivers/watchdog/da9063_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for DA9063 PMICs.
  *
@@ -5,10 +6,6 @@
  *
  * Author: Mariusz Wojtasik <mariusz.wojtasik@diasemi.com>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/davinci_wdt.c b/drivers/watchdog/davinci_wdt.c
index 3e4c592c239f..e470f6498ade 100644
--- a/drivers/watchdog/davinci_wdt.c
+++ b/drivers/watchdog/davinci_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/char/watchdog/davinci_wdt.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2006-2013 Texas Instruments.
  *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
  */
 
 #include <linux/module.h>
@@ -284,5 +281,5 @@ MODULE_PARM_DESC(heartbeat,
 		 __MODULE_STRING(MAX_HEARTBEAT) ", default "
 		 __MODULE_STRING(DEFAULT_HEARTBEAT));
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:davinci-wdt");
diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
index 806a04a676b7..0a674efd8d06 100644
--- a/drivers/watchdog/diag288_wdt.c
+++ b/drivers/watchdog/diag288_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for z/VM and LPAR using the diag 288 interface.
  *
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 5e4ef93caa02..a9e11df155b8 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for Conexant Digicolor
  *
  * Copyright (C) 2015 Paradox Innovation Ltd.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 
 #include <linux/types.h>
diff --git a/drivers/watchdog/dw_wdt.c b/drivers/watchdog/dw_wdt.c
index c2f4ff516230..66bd060bc297 100644
--- a/drivers/watchdog/dw_wdt.c
+++ b/drivers/watchdog/dw_wdt.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright 2010-2011 Picochip Ltd., Jamie Iles
  * http://www.picochip.com
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * This file implements a driver for the Synopsys DesignWare watchdog device
  * in the many subsystems. The watchdog has 16 different timeout periods
  * and these are a function of the input clock frequency.
diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
index 2170b275ea01..4c4c8ce78021 100644
--- a/drivers/watchdog/ebc-c384_wdt.c
+++ b/drivers/watchdog/ebc-c384_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog timer driver for the WinSystems EBC-C384
  * Copyright (C) 2016 William Breathitt Gray
diff --git a/drivers/watchdog/ep93xx_wdt.c b/drivers/watchdog/ep93xx_wdt.c
index f9b14e6efd9a..838d604bb608 100644
--- a/drivers/watchdog/ep93xx_wdt.c
+++ b/drivers/watchdog/ep93xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Cirrus Logic EP93xx family of devices.
  *
@@ -11,10 +12,6 @@
  * Copyright (c) 2012 H Hartley Sweeten <hsweeten@visionengravers.com>
  *	Convert to a platform device and use the watchdog framework API
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This watchdog fires after 250msec, which is a too short interval
  * for us to rely on the user space daemon alone. So we ping the
  * wdt each ~200msec and eventually stop doing it if the user space
@@ -144,4 +141,4 @@ MODULE_AUTHOR("Ray Lehtiniemi <rayl@mail.com>");
 MODULE_AUTHOR("Alessandro Zummo <a.zummo@towertech.it>");
 MODULE_AUTHOR("H Hartley Sweeten <hsweeten@visionengravers.com>");
 MODULE_DESCRIPTION("EP93xx Watchdog");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/eurotechwdt.c b/drivers/watchdog/eurotechwdt.c
index 47f77a6fdfd6..6b87d6e06dfc 100644
--- a/drivers/watchdog/eurotechwdt.c
+++ b/drivers/watchdog/eurotechwdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Eurotech CPU-1220/1410/1420 on board WDT driver
  *
@@ -11,11 +12,6 @@
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index e0678c14480f..86a722b38588 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -1,22 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /***************************************************************************
  *   Copyright (C) 2006 by Hans Edgington <hans@edgington.nl>              *
  *   Copyright (C) 2007-2009 Hans de Goede <hdegoede@redhat.com>           *
  *   Copyright (C) 2010 Giel van Schijndel <me@mortis.eu>                  *
- *                                                                         *
- *   This program is free software; you can redistribute it and/or modify  *
- *   it under the terms of the GNU General Public License as published by  *
- *   the Free Software Foundation; either version 2 of the License, or     *
- *   (at your option) any later version.                                   *
- *                                                                         *
- *   This program is distributed in the hope that it will be useful,       *
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of        *
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         *
- *   GNU General Public License for more details.                          *
- *                                                                         *
- *   You should have received a copy of the GNU General Public License     *
- *   along with this program; if not, write to the                         *
- *   Free Software Foundation, Inc.,                                       *
- *   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             *
  ***************************************************************************/
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/ftwdt010_wdt.c b/drivers/watchdog/ftwdt010_wdt.c
index a9c2912ee280..efe84e198e61 100644
--- a/drivers/watchdog/ftwdt010_wdt.c
+++ b/drivers/watchdog/ftwdt010_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Faraday Technology FTWDT010
  *
@@ -6,9 +7,6 @@
  * Inspired by the out-of-tree drivers from OpenWRT:
  * Copyright (C) 2009 Paulius Zaleckas <paulius.zaleckas@teltonika.lt>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/bitops.h>
@@ -233,4 +231,4 @@ static struct platform_driver ftwdt010_wdt_driver = {
 module_platform_driver(ftwdt010_wdt_driver);
 MODULE_AUTHOR("Linus Walleij");
 MODULE_DESCRIPTION("Watchdog driver for Faraday Technology FTWDT010");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/gef_wdt.c b/drivers/watchdog/gef_wdt.c
index 006e2348022c..f397e6d2c4b8 100644
--- a/drivers/watchdog/gef_wdt.c
+++ b/drivers/watchdog/gef_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * GE watchdog userspace interface
  *
@@ -5,11 +6,6 @@
  *
  * Copyright 2008 GE Intelligent Platforms Embedded Systems, Inc.
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- *
  * Based on: mv64x60_wdt.c (MV64X60 watchdog userspace interface)
  *   Author: James Chapman <jchapman@katalix.com>
  */
diff --git a/drivers/watchdog/geodewdt.c b/drivers/watchdog/geodewdt.c
index 88e01238f01b..0fa5dcdbf13b 100644
--- a/drivers/watchdog/geodewdt.c
+++ b/drivers/watchdog/geodewdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Watchdog timer for machines with the CS5535/CS5536 companion chip
  *
  * Copyright (C) 2006-2007, Advanced Micro Devices, Inc.
  * Copyright (C) 2009  Andres Salomon <dilinger@collabora.co.uk>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/gpio_wdt.c b/drivers/watchdog/gpio_wdt.c
index 3ade28190341..b6c5cceef1bc 100644
--- a/drivers/watchdog/gpio_wdt.c
+++ b/drivers/watchdog/gpio_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Driver for watchdog device controlled through GPIO-line
  *
  * Author: 2013, Alexander Shiyan <shc_work@mail.ru>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
  */
 
 #include <linux/err.h>
diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index f1f00dfc0e68..309640b42fed 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	HPE WatchDog Driver
  *	based on
@@ -7,10 +8,6 @@
  *	(c) Copyright 2015 Hewlett Packard Enterprise Development LP
  *	Thomas Mingarelli <thomas.mingarelli@hpe.com>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	version 2 as published by the Free Software Foundation
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -909,7 +906,7 @@ static struct pci_driver hpwdt_driver = {
 
 MODULE_AUTHOR("Tom Mingarelli");
 MODULE_DESCRIPTION("hp watchdog driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(HPWDT_VERSION);
 
 module_param(soft_margin, int, 0);
diff --git a/drivers/watchdog/i6300esb.c b/drivers/watchdog/i6300esb.c
index 950c71a8bb22..c254cbb301a1 100644
--- a/drivers/watchdog/i6300esb.c
+++ b/drivers/watchdog/i6300esb.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	i6300esb:	Watchdog timer driver for Intel 6300ESB chipset
  *
  *	(c) Copyright 2004 Google Inc.
  *	(c) Copyright 2005 David Härdeman <david@2gen.com>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	based on i810-tco.c which is in turn based on softdog.c
  *
  *	The timer is implemented in the following I/O controller hubs:
diff --git a/drivers/watchdog/iTCO_vendor_support.c b/drivers/watchdog/iTCO_vendor_support.c
index b6b2f90b5d44..9290f827e381 100644
--- a/drivers/watchdog/iTCO_vendor_support.c
+++ b/drivers/watchdog/iTCO_vendor_support.c
@@ -1,16 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	intel TCO vendor specific watchdog driver support
  *
  *	(c) Copyright 2006-2009 Wim Van Sebroeck <wim@iguana.be>.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
- *	provide warranty for any of this software. This material is
- *	provided "AS-IS" and at no charge.
  */
 
 /*
diff --git a/drivers/watchdog/iTCO_wdt.c b/drivers/watchdog/iTCO_wdt.c
index 347f0389b089..161a99b8f6a4 100644
--- a/drivers/watchdog/iTCO_wdt.c
+++ b/drivers/watchdog/iTCO_wdt.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	intel TCO Watchdog Driver
  *
  *	(c) Copyright 2006-2011 Wim Van Sebroeck <wim@iguana.be>.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
- *	provide warranty for any of this software. This material is
- *	provided "AS-IS" and at no charge.
- *
  *	The TCO watchdog is implemented in the following I/O controller hubs:
  *	(See the intel documentation on http://developer.intel.com.)
  *	document number 290655-003, 290677-014: 82801AA (ICH), 82801AB (ICHO)
diff --git a/drivers/watchdog/ib700wdt.c b/drivers/watchdog/ib700wdt.c
index cc262284a6aa..5ec33701c431 100644
--- a/drivers/watchdog/ib700wdt.c
+++ b/drivers/watchdog/ib700wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	IB700 Single Board Computer WDT driver
  *
@@ -14,11 +15,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
  *	warranty for any of this software. This material is provided
  *	"AS-IS" and at no charge.
diff --git a/drivers/watchdog/ibmasr.c b/drivers/watchdog/ibmasr.c
index 366b0474f278..7614a113e8d9 100644
--- a/drivers/watchdog/ibmasr.c
+++ b/drivers/watchdog/ibmasr.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * IBM Automatic Server Restart driver.
  *
@@ -6,8 +7,6 @@
  * Based on driver written by Pete Reynolds.
  * Copyright (c) IBM Corporation, 1998-2004.
  *
- * This software may be used and distributed according to the terms
- * of the GNU Public License, incorporated herein by reference.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/ie6xx_wdt.c b/drivers/watchdog/ie6xx_wdt.c
index 78c2541f5d52..d65279a1e091 100644
--- a/drivers/watchdog/ie6xx_wdt.c
+++ b/drivers/watchdog/ie6xx_wdt.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *      Intel Atom E6xx Watchdog driver
  *
  *      Copyright (C) 2011 Alexander Stein
  *                <alexander.stein@systec-electronic.com>
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of version 2 of the GNU General
- *      Public License as published by the Free Software Foundation.
- *
- *      This program is distributed in the hope that it will be
- *      useful, but WITHOUT ANY WARRANTY; without even the implied
- *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- *      PURPOSE.  See the GNU General Public License for more details.
- *      You should have received a copy of the GNU General Public
- *      License along with this program; if not, write to the Free
- *      Software Foundation, Inc., 59 Temple Place - Suite 330,
- *      Boston, MA  02111-1307, USA.
- *      The full GNU General Public License is included in this
- *      distribution in the file called COPYING.
- *
  */
 
 #include <linux/module.h>
@@ -342,5 +328,5 @@ module_exit(ie6xx_wdt_exit);
 
 MODULE_AUTHOR("Alexander Stein <alexander.stein@systec-electronic.com>");
 MODULE_DESCRIPTION("Intel Atom E6xx Watchdog Device Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRIVER_NAME);
diff --git a/drivers/watchdog/imgpdc_wdt.c b/drivers/watchdog/imgpdc_wdt.c
index 6ed39dee995f..77dbef83b960 100644
--- a/drivers/watchdog/imgpdc_wdt.c
+++ b/drivers/watchdog/imgpdc_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Imagination Technologies PowerDown Controller Watchdog Timer.
  *
  * Copyright (c) 2014 Imagination Technologies Ltd.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * Based on drivers/watchdog/sunxi_wdt.c Copyright (c) 2013 Carlo Caione
  *                                                     2012 Henrik Nordstrom
  *
diff --git a/drivers/watchdog/imx2_wdt.c b/drivers/watchdog/imx2_wdt.c
index 518dfa1047cb..63bc93f92bfa 100644
--- a/drivers/watchdog/imx2_wdt.c
+++ b/drivers/watchdog/imx2_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for IMX2 and later processors
  *
@@ -7,10 +8,6 @@
  * some parts adapted by similar drivers from Darius Augulis and Vladimir
  * Zapolskiy, additional improvements by Wim Van Sebroeck.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * NOTE: MX1 has a slightly different Watchdog than MX2 and later:
  *
  *			MX1:		MX2+:
diff --git a/drivers/watchdog/indydog.c b/drivers/watchdog/indydog.c
index 5d20cdd30efe..27fda954e8e6 100644
--- a/drivers/watchdog/indydog.c
+++ b/drivers/watchdog/indydog.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	IndyDog	0.3	A Hardware Watchdog Device for SGI IP22
  *
  *	(c) Copyright 2002 Guido Guenther <agx@sigxcpu.org>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	based on softdog.c by Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
 
diff --git a/drivers/watchdog/intel-mid_wdt.c b/drivers/watchdog/intel-mid_wdt.c
index 72c108a12c19..21f5cb0f3d81 100644
--- a/drivers/watchdog/intel-mid_wdt.c
+++ b/drivers/watchdog/intel-mid_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *      intel-mid_wdt: generic Intel MID SCU watchdog driver
  *
@@ -7,9 +8,6 @@
  *      Copyright (C) 2014 Intel Corporation. All rights reserved.
  *      Contact: David Cohen <david.a.cohen@linux.intel.com>
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of version 2 of the GNU General
- *      Public License as published by the Free Software Foundation.
  */
 
 #include <linux/interrupt.h>
@@ -185,4 +183,4 @@ module_platform_driver(mid_wdt_driver);
 
 MODULE_AUTHOR("David Cohen <david.a.cohen@linux.intel.com>");
 MODULE_DESCRIPTION("Watchdog Driver for Intel MID platform");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/intel_scu_watchdog.c b/drivers/watchdog/intel_scu_watchdog.c
index 0caab6241eb7..df4390720701 100644
--- a/drivers/watchdog/intel_scu_watchdog.c
+++ b/drivers/watchdog/intel_scu_watchdog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *      Intel_SCU 0.2:  An Intel SCU IOH Based Watchdog Device
  *			for Intel part #(s):
@@ -5,21 +6,6 @@
  *
  *      Copyright (C) 2009-2010 Intel Corporation. All rights reserved.
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of version 2 of the GNU General
- *      Public License as published by the Free Software Foundation.
- *
- *      This program is distributed in the hope that it will be
- *      useful, but WITHOUT ANY WARRANTY; without even the implied
- *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- *      PURPOSE.  See the GNU General Public License for more details.
- *      You should have received a copy of the GNU General Public
- *      License along with this program; if not, write to the Free
- *      Software Foundation, Inc., 59 Temple Place - Suite 330,
- *      Boston, MA  02111-1307, USA.
- *      The full GNU General Public License is included in this
- *      distribution in the file called COPYING.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -561,5 +547,5 @@ module_exit(intel_scu_watchdog_exit);
 
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel SCU Watchdog Device Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_VERSION(WDT_VER);
diff --git a/drivers/watchdog/intel_scu_watchdog.h b/drivers/watchdog/intel_scu_watchdog.h
index f3ac608deb6a..0efb5ba92f70 100644
--- a/drivers/watchdog/intel_scu_watchdog.h
+++ b/drivers/watchdog/intel_scu_watchdog.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *      Intel_SCU 0.2:  An Intel SCU IOH Based Watchdog Device
  *			for Intel part #(s):
@@ -5,21 +6,6 @@
  *
  *      Copyright (C) 2009-2010 Intel Corporation. All rights reserved.
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of version 2 of the GNU General
- *      Public License as published by the Free Software Foundation.
- *
- *      This program is distributed in the hope that it will be
- *      useful, but WITHOUT ANY WARRANTY; without even the implied
- *      warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
- *      PURPOSE.  See the GNU General Public License for more details.
- *      You should have received a copy of the GNU General Public
- *      License along with this program; if not, write to the Free
- *      Software Foundation, Inc., 59 Temple Place - Suite 330,
- *      Boston, MA  02111-1307, USA.
- *      The full GNU General Public License is included in this
- *      distribution in the file called COPYING.
- *
  */
 
 #ifndef __INTEL_SCU_WATCHDOG_H
diff --git a/drivers/watchdog/iop_wdt.c b/drivers/watchdog/iop_wdt.c
index b16013ffacc2..d5212ccb300b 100644
--- a/drivers/watchdog/iop_wdt.c
+++ b/drivers/watchdog/iop_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * drivers/char/watchdog/iop_wdt.c
  *
@@ -6,19 +7,6 @@
  *
  * Based on ixp4xx driver, Copyright 2004 (c) MontaVista, Software, Inc.
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
- * Place - Suite 330, Boston, MA 02111-1307 USA.
- *
  *	Curt E Bruns <curt.e.bruns@intel.com>
  *	Peter Milne <peter.milne@d-tacq.com>
  *	Dan Williams <dan.j.williams@intel.com>
@@ -258,4 +246,4 @@ MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
 MODULE_AUTHOR("Curt E Bruns <curt.e.bruns@intel.com>");
 MODULE_DESCRIPTION("iop watchdog timer driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/it8712f_wdt.c b/drivers/watchdog/it8712f_wdt.c
index 41b3979a9d87..62ec936dd775 100644
--- a/drivers/watchdog/it8712f_wdt.c
+++ b/drivers/watchdog/it8712f_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	IT8712F "Smart Guardian" Watchdog support
  *
@@ -9,15 +10,6 @@
  *	drivers/hwmon/it87.c
  *	IT8712F EC-LPC I/O Preliminary Specification 0.8.2
  *	IT8712F EC-LPC I/O Preliminary Specification 0.9.3
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License as
- *	published by the Free Software Foundation; either version 2 of the
- *	License, or (at your option) any later version.
- *
- *	The author(s) of this software shall not be held liable for damages
- *	of any nature resulting due to the use of this software. This
- *	software is provided AS-IS with no warranties.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/it87_wdt.c b/drivers/watchdog/it87_wdt.c
index e96faea24925..c426d583ea54 100644
--- a/drivers/watchdog/it87_wdt.c
+++ b/drivers/watchdog/it87_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Watchdog Timer Driver
  *	   for ITE IT87xx Environment Control - Low Pin Count Input / Output
@@ -16,15 +17,6 @@
  *	IT8702, IT8712, IT8716, IT8718, IT8720, IT8721, IT8726, IT8728,
  *	and IT8783.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	This program is distributed in the hope that it will be useful,
- *	but WITHOUT ANY WARRANTY; without even the implied warranty of
- *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *	GNU General Public License for more details.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index f20cc53ff719..0b380f751443 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/char/watchdog/ixp4xx_wdt.c
  *
@@ -8,9 +9,6 @@
  * Copyright 2004 (c) MontaVista, Software, Inc.
  * Based on sa1100 driver, Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
  *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -207,4 +205,4 @@ MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds (default 60s)");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
index aafbeb96561b..1124ffb4266b 100644
--- a/drivers/watchdog/jz4740_wdt.c
+++ b/drivers/watchdog/jz4740_wdt.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (C) 2010, Paul Cercueil <paul@crapouillou.net>
  *  JZ4740 Watchdog driver
  *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/kempld_wdt.c b/drivers/watchdog/kempld_wdt.c
index 2f3b049ea301..2c38aceb3d61 100644
--- a/drivers/watchdog/kempld_wdt.c
+++ b/drivers/watchdog/kempld_wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Kontron PLD watchdog driver
  *
  * Copyright (c) 2010-2013 Kontron Europe GmbH
  * Author: Michael Brunner <michael.brunner@kontron.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License 2 as published
- * by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Note: From the PLD watchdog point of view timeout and pretimeout are
  *       defined differently than in the kernel.
  *       First the pretimeout stage runs out before the timeout stage gets
@@ -582,4 +574,4 @@ module_platform_driver(kempld_wdt_driver);
 
 MODULE_DESCRIPTION("KEM PLD Watchdog Driver");
 MODULE_AUTHOR("Michael Brunner <michael.brunner@kontron.com>");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/ks8695_wdt.c b/drivers/watchdog/ks8695_wdt.c
index 1e41818a44bc..acf6b551f467 100644
--- a/drivers/watchdog/ks8695_wdt.c
+++ b/drivers/watchdog/ks8695_wdt.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Kendin/Micrel KS8695.
  *
  * (C) 2007 Andrew Victor
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -318,5 +316,5 @@ module_exit(ks8695_wdt_exit);
 
 MODULE_AUTHOR("Andrew Victor");
 MODULE_DESCRIPTION("Watchdog driver for KS8695");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ks8695_wdt");
diff --git a/drivers/watchdog/lantiq_wdt.c b/drivers/watchdog/lantiq_wdt.c
index 7f43cefa0eae..c052ef130382 100644
--- a/drivers/watchdog/lantiq_wdt.c
+++ b/drivers/watchdog/lantiq_wdt.c
@@ -1,8 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *  This program is free software; you can redistribute it and/or modify it
- *  under the terms of the GNU General Public License version 2 as published
- *  by the Free Software Foundation.
- *
  *  Copyright (C) 2010 John Crispin <john@phrozen.org>
  *  Copyright (C) 2017 Hauke Mehrtens <hauke@hauke-m.de>
  *  Based on EP93xx wdt driver
@@ -306,4 +303,4 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 MODULE_AUTHOR("John Crispin <john@phrozen.org>");
 MODULE_DESCRIPTION("Lantiq SoC Watchdog");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/loongson1_wdt.c b/drivers/watchdog/loongson1_wdt.c
index 3aee50c64a36..a338f30bbe7c 100644
--- a/drivers/watchdog/loongson1_wdt.c
+++ b/drivers/watchdog/loongson1_wdt.c
@@ -1,10 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2016 Yang Ling <gnaygnil@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/lpc18xx_wdt.c b/drivers/watchdog/lpc18xx_wdt.c
index b4221f43cd94..afaa167cdf6e 100644
--- a/drivers/watchdog/lpc18xx_wdt.c
+++ b/drivers/watchdog/lpc18xx_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * NXP LPC18xx Watchdog Timer (WDT)
  *
  * Copyright (c) 2015 Ariel D'Alessandro <ariel@vanguardiasur.com>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
  * Notes
  * -----
  * The Watchdog consists of a fixed divide-by-4 clock pre-scaler and a 24-bit
diff --git a/drivers/watchdog/m54xx_wdt.c b/drivers/watchdog/m54xx_wdt.c
index da6fa2b68074..0734fd0412fb 100644
--- a/drivers/watchdog/m54xx_wdt.c
+++ b/drivers/watchdog/m54xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/watchdog/m54xx_wdt.c
  *
@@ -11,9 +12,6 @@
  *  Copyright 2004 (c) MontaVista, Software, Inc.
  *  Based on sa1100 driver, Copyright (C) 2000 Oleg Drokin <green@crimea.edu>
  *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -222,4 +220,4 @@ MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds (default 30s)");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/machzwd.c b/drivers/watchdog/machzwd.c
index 88d823d87a4b..bc40a8c64b04 100644
--- a/drivers/watchdog/machzwd.c
+++ b/drivers/watchdog/machzwd.c
@@ -1,16 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  MachZ ZF-Logic Watchdog Timer driver for Linux
  *
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- *
- *  The author does NOT admit liability nor provide warranty for
- *  any of this software. This material is provided "AS-IS" in
- *  the hope that it may be useful for others.
- *
  *  Author: Fernando Fuganti <fuganti@conectiva.com.br>
  *
  *  Based on sbc60xxwdt.c by Jakob Oestergaard
diff --git a/drivers/watchdog/max63xx_wdt.c b/drivers/watchdog/max63xx_wdt.c
index ac5840d9689a..b70517a98101 100644
--- a/drivers/watchdog/max63xx_wdt.c
+++ b/drivers/watchdog/max63xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/char/watchdog/max63xx_wdt.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2009 Marc Zyngier <maz@misterjones.org>
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- *
  * This driver assumes the watchdog pins are memory mapped (as it is
  * the case for the Arcom Zeus). Should it be connected over GPIOs or
  * another interface, some abstraction will have to be introduced.
diff --git a/drivers/watchdog/max77620_wdt.c b/drivers/watchdog/max77620_wdt.c
index 2c9f53eaff4f..a65fa81ade2f 100644
--- a/drivers/watchdog/max77620_wdt.c
+++ b/drivers/watchdog/max77620_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Maxim MAX77620 Watchdog Driver
  *
  * Copyright (C) 2016 NVIDIA CORPORATION. All rights reserved.
  *
  * Author: Laxman Dewangan <ldewangan@nvidia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/err.h>
diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index b8194b02abe0..8023cf28657a 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Intel Management Engine Interface (Intel MEI) Linux driver
  * Copyright (c) 2015, Intel Corporation.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
- * more details.
  */
 
 #include <linux/module.h>
@@ -687,5 +679,5 @@ static struct mei_cl_driver mei_wdt_driver = {
 module_mei_cl_driver(mei_wdt_driver);
 
 MODULE_AUTHOR("Intel Corporation");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Device driver for Intel MEI iAMT watchdog");
diff --git a/drivers/watchdog/mena21_wdt.c b/drivers/watchdog/mena21_wdt.c
index 045201a6fdb3..25d5d2b8cfbe 100644
--- a/drivers/watchdog/mena21_wdt.c
+++ b/drivers/watchdog/mena21_wdt.c
@@ -1,11 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for the A21 VME CPU Boards
  *
  * Copyright (C) 2013 MEN Mikro Elektronik Nuernberg GmbH
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation
  */
 #include <linux/module.h>
 #include <linux/moduleparam.h>
diff --git a/drivers/watchdog/menf21bmc_wdt.c b/drivers/watchdog/menf21bmc_wdt.c
index 3aefddebb386..9f9662151d2a 100644
--- a/drivers/watchdog/menf21bmc_wdt.c
+++ b/drivers/watchdog/menf21bmc_wdt.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  MEN 14F021P00 Board Management Controller (BMC) Watchdog Driver.
  *
  *  Copyright (C) 2014 MEN Mikro Elektronik Nuernberg GmbH
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
  */
 
 #include <linux/kernel.h>
@@ -199,5 +195,5 @@ module_platform_driver(menf21bmc_wdt);
 
 MODULE_DESCRIPTION("MEN 14F021P00 BMC Watchdog driver");
 MODULE_AUTHOR("Andreas Werner <andreas.werner@men.de>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:menf21bmc_wdt");
diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/meson_gxbb_wdt.c
index 69a5a57f1446..69adeab3fde7 100644
--- a/drivers/watchdog/meson_gxbb_wdt.c
+++ b/drivers/watchdog/meson_gxbb_wdt.c
@@ -1,56 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * This file is provided under a dual BSD/GPLv2 license.  When using or
- * redistributing this file, you may do so under either license.
- *
- * GPL LICENSE SUMMARY
- *
  * Copyright (c) 2016 BayLibre, SAS.
  * Author: Neil Armstrong <narmstrong@baylibre.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- * The full GNU General Public License is included in this distribution
- * in the file called COPYING.
- *
- * BSD LICENSE
- *
- * Copyright (c) 2016 BayLibre, SAS.
- * Author: Neil Armstrong <narmstrong@baylibre.com>
- *
- * Redistribution and use in source and binary forms, with or without
- * modification, are permitted provided that the following conditions
- * are met:
- *
- *   * Redistributions of source code must retain the above copyright
- *     notice, this list of conditions and the following disclaimer.
- *   * Redistributions in binary form must reproduce the above copyright
- *     notice, this list of conditions and the following disclaimer in
- *     the documentation and/or other materials provided with the
- *     distribution.
- *   * Neither the name of Intel Corporation nor the names of its
- *     contributors may be used to endorse or promote products derived
- *     from this software without specific prior written permission.
- *
- * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
- * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
- * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
- * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
- * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
- * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
- * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
- * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
- * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
- * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/clk.h>
 #include <linux/err.h>
diff --git a/drivers/watchdog/meson_wdt.c b/drivers/watchdog/meson_wdt.c
index 304274c67735..4979ab931ca8 100644
--- a/drivers/watchdog/meson_wdt.c
+++ b/drivers/watchdog/meson_wdt.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      Meson Watchdog Driver
  *
  *      Copyright (c) 2014 Carlo Caione
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/mixcomwd.c b/drivers/watchdog/mixcomwd.c
index 3cc07447c655..aca8d13f6391 100644
--- a/drivers/watchdog/mixcomwd.c
+++ b/drivers/watchdog/mixcomwd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * MixCom Watchdog: A Simple Hardware Watchdog Device
  * Based on Softdog driver by Alan Cox and PC Watchdog driver by Ken Hollis
@@ -6,11 +7,6 @@
  *
  * Copyright (c) 1999 ITConsult-Pro Co. <info@itc.hu>
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * Version 0.1 (99/04/15):
  *		- first version
  *
diff --git a/drivers/watchdog/moxart_wdt.c b/drivers/watchdog/moxart_wdt.c
index 2c4a73d1e214..bf7478d01fe6 100644
--- a/drivers/watchdog/moxart_wdt.c
+++ b/drivers/watchdog/moxart_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MOXA ART SoCs watchdog driver.
  *
  * Copyright (C) 2013 Jonas Jensen
  *
  * Jonas Jensen <jonas.jensen@gmail.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/clk.h>
@@ -174,5 +171,5 @@ module_param(heartbeat, int, 0);
 MODULE_PARM_DESC(heartbeat, "Watchdog heartbeat in seconds");
 
 MODULE_DESCRIPTION("MOXART watchdog driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Jonas Jensen <jonas.jensen@gmail.com>");
diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index aca2d6323f8a..98fd806c13ec 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * mpc8xxx_wdt.c - MPC8xx/MPC83xx/MPC86xx watchdog userspace interface
  *
@@ -10,11 +11,6 @@
  *
  * Note: it appears that you can only actually ENABLE or DISABLE the thing
  * once after POR. Once enabled, you cannot disable, and vice versa.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/mt7621_wdt.c b/drivers/watchdog/mt7621_wdt.c
index 5c4a764717c4..627a1a5e49fa 100644
--- a/drivers/watchdog/mt7621_wdt.c
+++ b/drivers/watchdog/mt7621_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Ralink MT7621/MT7628 built-in hardware watchdog timer
  *
  * Copyright (C) 2014 John Crispin <john@phrozen.org>
  *
  * This driver was based on: drivers/watchdog/rt2880_wdt.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index 7ed417a765c7..498e7d4e1b66 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Mediatek Watchdog Driver
  *
@@ -5,16 +6,6 @@
  *
  * Matthias Brugger <matthias.bgg@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * Based on sunxi_wdt.c
  */
 
diff --git a/drivers/watchdog/mtx-1_wdt.c b/drivers/watchdog/mtx-1_wdt.c
index ca360d204548..1fa7d2b32494 100644
--- a/drivers/watchdog/mtx-1_wdt.c
+++ b/drivers/watchdog/mtx-1_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      Driver for the MTX-1 Watchdog.
  *
@@ -6,16 +7,6 @@
  *                              http://www.4g-systems.biz
  *
  *	(C) Copyright 2007 OpenWrt.org, Florian Fainelli <florian@openwrt.org>
- *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
- *      Neither Michael Stickel nor 4G Systems admit liability nor provide
- *      warranty for any of this software. This material is provided
- *      "AS-IS" and at no charge.
- *
  *      (c) Copyright 2005    4G Systems <info@4g-systems.biz>
  *
  *      Release 0.01.
diff --git a/drivers/watchdog/mv64x60_wdt.c b/drivers/watchdog/mv64x60_wdt.c
index 315275d7bab6..c237d37e94c6 100644
--- a/drivers/watchdog/mv64x60_wdt.c
+++ b/drivers/watchdog/mv64x60_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * mv64x60_wdt.c - MV64X60 (Marvell Discovery) watchdog userspace interface
  *
@@ -9,10 +10,7 @@
  *
  * Derived from mpc8xx_wdt.c, with the following copyright.
  *
- * 2002 (c) Florian Schirmer <jolt@tuxbox.org> This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
+ * 2002 (c) Florian Schirmer <jolt@tuxbox.org>
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/ni903x_wdt.c b/drivers/watchdog/ni903x_wdt.c
index dc67742e9018..350054b962a5 100644
--- a/drivers/watchdog/ni903x_wdt.c
+++ b/drivers/watchdog/ni903x_wdt.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 National Instruments Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/watchdog/nic7018_wdt.c b/drivers/watchdog/nic7018_wdt.c
index dcd265685837..144821b206b7 100644
--- a/drivers/watchdog/nic7018_wdt.c
+++ b/drivers/watchdog/nic7018_wdt.c
@@ -1,15 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 National Instruments Corp.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/watchdog/nuc900_wdt.c b/drivers/watchdog/nuc900_wdt.c
index 830bd04ff911..6d3edfa625c9 100644
--- a/drivers/watchdog/nuc900_wdt.c
+++ b/drivers/watchdog/nuc900_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2009 Nuvoton technology corporation.
  *
  * Wan ZongShun <mcuos.com@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation;version 2 of the License.
- *
  */
 
 #include <linux/bitops.h>
@@ -304,5 +301,5 @@ module_platform_driver(nuc900wdt_driver);
 
 MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
 MODULE_DESCRIPTION("Watchdog driver for NUC900");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:nuc900-wdt");
diff --git a/drivers/watchdog/nv_tco.c b/drivers/watchdog/nv_tco.c
index a0fabf6f92b0..0328981b8d84 100644
--- a/drivers/watchdog/nv_tco.c
+++ b/drivers/watchdog/nv_tco.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	nv_tco 0.01:	TCO timer driver for NV chipsets
  *
@@ -8,11 +9,6 @@
  *	Reserved.
  *				http://www.kernelconcepts.de
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	TCO timer driver for NV chipsets
  *	based on softdog.c by Alan Cox <alan@redhat.com>
  */
diff --git a/drivers/watchdog/nv_tco.h b/drivers/watchdog/nv_tco.h
index c2d1d04e055b..860499d36832 100644
--- a/drivers/watchdog/nv_tco.h
+++ b/drivers/watchdog/nv_tco.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	nv_tco:	TCO timer driver for nVidia chipsets.
  *
@@ -10,15 +11,6 @@
  *	Reserved.
  *				http://www.kernelconcepts.de
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither kernel concepts nor Nils Faerber admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 2000	kernel concepts <nils@kernelconcepts.de>
  *				developed for
  *                              Jentro AG, Haar/Munich (Germany)
diff --git a/drivers/watchdog/octeon-wdt-main.c b/drivers/watchdog/octeon-wdt-main.c
index 0ec419a3f7ed..9c0d9bb09c60 100644
--- a/drivers/watchdog/octeon-wdt-main.c
+++ b/drivers/watchdog/octeon-wdt-main.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Octeon Watchdog driver
  *
@@ -9,16 +10,6 @@
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  * This file is subject to the terms and conditions of the GNU General Public
diff --git a/drivers/watchdog/octeon-wdt-nmi.S b/drivers/watchdog/octeon-wdt-nmi.S
index 97f6eb7b5a8e..9c102049eeb2 100644
--- a/drivers/watchdog/octeon-wdt-nmi.S
+++ b/drivers/watchdog/octeon-wdt-nmi.S
@@ -1,8 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
  * Copyright (C) 2007-2017 Cavium, Inc.
  */
 #include <asm/asm.h>
diff --git a/drivers/watchdog/of_xilinx_wdt.c b/drivers/watchdog/of_xilinx_wdt.c
index 1cf286945b7a..4acbe05e27bb 100644
--- a/drivers/watchdog/of_xilinx_wdt.c
+++ b/drivers/watchdog/of_xilinx_wdt.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog Device Driver for Xilinx axi/xps_timebase_wdt
  *
  * (C) Copyright 2013 - 2014 Xilinx, Inc.
  * (C) Copyright 2011 (Alejandro Cabrera <aldaya@gmail.com>)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 
 #include <linux/clk.h>
@@ -323,4 +319,4 @@ module_platform_driver(xwdt_driver);
 
 MODULE_AUTHOR("Alejandro Cabrera <aldaya@gmail.com>");
 MODULE_DESCRIPTION("Xilinx Watchdog driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1b02bfa81b29..e349412c00b5 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * omap_wdt.c
  *
diff --git a/drivers/watchdog/omap_wdt.h b/drivers/watchdog/omap_wdt.h
index 42f31ec5e90d..950b4643f3e7 100644
--- a/drivers/watchdog/omap_wdt.h
+++ b/drivers/watchdog/omap_wdt.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *  linux/drivers/char/watchdog/omap_wdt.h
  *
@@ -5,26 +6,6 @@
  *      OMAP Watchdog timer register definitions
  *
  *  Copyright (C) 2004 Texas Instruments.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #ifndef _OMAP_WATCHDOG_H
diff --git a/drivers/watchdog/orion_wdt.c b/drivers/watchdog/orion_wdt.c
index ea676d233e1e..966dede7551c 100644
--- a/drivers/watchdog/orion_wdt.c
+++ b/drivers/watchdog/orion_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/watchdog/orion_wdt.c
  *
  * Watchdog driver for Orion/Kirkwood processors
  *
  * Author: Sylver Bruneau <sylver.bruneau@googlemail.com>
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/pc87413_wdt.c b/drivers/watchdog/pc87413_wdt.c
index 06a892e36a8d..09c8a0637437 100644
--- a/drivers/watchdog/pc87413_wdt.c
+++ b/drivers/watchdog/pc87413_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      NS pc87413-wdt Watchdog Timer driver for Linux 2.6.x.x
  *
@@ -6,15 +7,6 @@
  *      (C) Copyright 2006 Sven Anders, <anders@anduras.de>
  *                     and Marcus Junker, <junker@anduras.de>
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
- *      Neither Sven Anders, Marcus Junker nor ANDURAS AG
- *      admit liability nor provide warranty for any of this software.
- *      This material is provided "AS-IS" and at no charge.
- *
  *      Release 1.1
  */
 
diff --git a/drivers/watchdog/pcwd.c b/drivers/watchdog/pcwd.c
index b72ce68eacd3..1b7bfe15713c 100644
--- a/drivers/watchdog/pcwd.c
+++ b/drivers/watchdog/pcwd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * PC Watchdog Driver
  * by Ken Hollis (khollis@bitgate.com)
diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
index 1f78f0908621..134a5c53a050 100644
--- a/drivers/watchdog/pcwd_pci.c
+++ b/drivers/watchdog/pcwd_pci.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Berkshire PCI-PC Watchdog Card Driver
  *
@@ -9,15 +10,6 @@
  *	  Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *	  Matt Domsch <Matt_Domsch@dell.com>,
  *	  Rob Radez <rob@osinvestor.com>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
- *	provide warranty for any of this software. This material is
- *	provided "AS-IS" and at no charge.
  */
 
 /*
diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 4d02f26156f9..bee86eea512a 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Berkshire USB-PC Watchdog Card Driver
  *
@@ -10,15 +11,6 @@
  *	  Rob Radez <rob@osinvestor.com>,
  *	  Greg Kroah-Hartman <greg@kroah.com>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
- *	provide warranty for any of this software. This material is
- *	provided "AS-IS" and at no charge.
- *
  *	Thanks also to Simon Machell at Berkshire Products Inc. for
  *	providing the test hardware. More info is available at
  *	http://www.berkprod.com/ or http://www.pcwatchdog.com/
diff --git a/drivers/watchdog/pic32-dmt.c b/drivers/watchdog/pic32-dmt.c
index c797305f8338..432506df112c 100644
--- a/drivers/watchdog/pic32-dmt.c
+++ b/drivers/watchdog/pic32-dmt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * PIC32 deadman timer driver
  *
  * Purna Chandra Mandal <purna.mandal@microchip.com>
  * Copyright (c) 2016, Microchip Technology Inc.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 #include <linux/clk.h>
 #include <linux/device.h>
diff --git a/drivers/watchdog/pic32-wdt.c b/drivers/watchdog/pic32-wdt.c
index e2761068dc6f..bb908c6b0469 100644
--- a/drivers/watchdog/pic32-wdt.c
+++ b/drivers/watchdog/pic32-wdt.c
@@ -1,13 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * PIC32 watchdog driver
  *
  * Joshua Henderson <joshua.henderson@microchip.com>
  * Copyright (c) 2016, Microchip Technology Inc.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
  */
 #include <linux/clk.h>
 #include <linux/device.h>
diff --git a/drivers/watchdog/pika_wdt.c b/drivers/watchdog/pika_wdt.c
index e0a6f8c0f03c..71479b151162 100644
--- a/drivers/watchdog/pika_wdt.c
+++ b/drivers/watchdog/pika_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * PIKA FPGA based Watchdog Timer
  *
diff --git a/drivers/watchdog/pnx4008_wdt.c b/drivers/watchdog/pnx4008_wdt.c
index 0529aed158a4..1981c7d21f28 100644
--- a/drivers/watchdog/pnx4008_wdt.c
+++ b/drivers/watchdog/pnx4008_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * drivers/char/watchdog/pnx4008_wdt.c
  *
@@ -11,10 +12,6 @@
  * 2005-2006 (c) MontaVista Software, Inc.
  *
  * (C) 2012 Wolfram Sang, Pengutronix
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2. This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -268,5 +265,5 @@ module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout,
 		 "Set to 1 to keep watchdog running after device release");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:pnx4008-watchdog");
diff --git a/drivers/watchdog/pnx833x_wdt.c b/drivers/watchdog/pnx833x_wdt.c
index 882fdcb46ad1..45c8158adcea 100644
--- a/drivers/watchdog/pnx833x_wdt.c
+++ b/drivers/watchdog/pnx833x_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  PNX833x Hardware Watchdog Driver
  *  Copyright 2008 NXP Semiconductors
@@ -9,11 +10,6 @@
  *
  * (c) Copyright 2002 Guido Guenther <agx@sigxcpu.org>, All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- *
  * based on softdog.c by Alan Cox <alan@redhat.com>
  */
 
diff --git a/drivers/watchdog/pretimeout_noop.c b/drivers/watchdog/pretimeout_noop.c
index 85f5299d197c..2a553a14f1c8 100644
--- a/drivers/watchdog/pretimeout_noop.c
+++ b/drivers/watchdog/pretimeout_noop.c
@@ -1,11 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015-2016 Mentor Graphics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/pretimeout_panic.c b/drivers/watchdog/pretimeout_panic.c
index 0c197a1c97f4..dde400a2fb5d 100644
--- a/drivers/watchdog/pretimeout_panic.c
+++ b/drivers/watchdog/pretimeout_panic.c
@@ -1,11 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015-2016 Mentor Graphics
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/qcom-wdt.c b/drivers/watchdog/qcom-wdt.c
index 780971318810..1b5b56944872 100644
--- a/drivers/watchdog/qcom-wdt.c
+++ b/drivers/watchdog/qcom-wdt.c
@@ -1,14 +1,6 @@
-/* Copyright (c) 2014, The Linux Foundation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 and
- * only version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014, The Linux Foundation. All rights reserved.
  */
 #include <linux/clk.h>
 #include <linux/delay.h>
diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
index 831ef83f6de1..8436fc74b0c6 100644
--- a/drivers/watchdog/renesas_wdt.c
+++ b/drivers/watchdog/renesas_wdt.c
@@ -1,12 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Renesas WDT watchdog
  *
  * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
  * Copyright (C) 2015-17 Renesas Electronics Corporation
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/bitops.h>
 #include <linux/clk.h>
diff --git a/drivers/watchdog/retu_wdt.c b/drivers/watchdog/retu_wdt.c
index 39cd51df2ffc..258dfcf9cbda 100644
--- a/drivers/watchdog/retu_wdt.c
+++ b/drivers/watchdog/retu_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Retu watchdog driver
  *
@@ -5,15 +6,6 @@
  *
  * Based on code written by Amit Kucheria and Michael Buesch.
  * Rewritten by Aaro Koskinen.
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License. See the file "COPYING" in the main directory of this
- * archive for more details.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include <linux/slab.h>
diff --git a/drivers/watchdog/riowd.c b/drivers/watchdog/riowd.c
index aba53424605e..2f343609f8e9 100644
--- a/drivers/watchdog/riowd.c
+++ b/drivers/watchdog/riowd.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* riowd.c - driver for hw watchdog inside Super I/O of RIO
  *
  * Copyright (C) 2001, 2008 David S. Miller (davem@davemloft.net)
diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index e60f55702ab7..9111909fde24 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Ricoh RN5T618 PMIC
  *
  * Copyright (C) 2014 Beniamino Galvani <b.galvani@gmail.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/device.h>
diff --git a/drivers/watchdog/rt2880_wdt.c b/drivers/watchdog/rt2880_wdt.c
index 98967f0a7d10..e4453c8fe149 100644
--- a/drivers/watchdog/rt2880_wdt.c
+++ b/drivers/watchdog/rt2880_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Ralink RT288x/RT3xxx/MT76xx built-in hardware watchdog timer
  *
@@ -5,10 +6,6 @@
  * Copyright (C) 2013 John Crispin <john@phrozen.org>
  *
  * This driver was based on: drivers/watchdog/softdog.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published
- * by the Free Software Foundation.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/rtd119x_wdt.c b/drivers/watchdog/rtd119x_wdt.c
index d001c17ddfde..4f4411cab9b7 100644
--- a/drivers/watchdog/rtd119x_wdt.c
+++ b/drivers/watchdog/rtd119x_wdt.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Realtek RTD129x watchdog
  *
  * Copyright (c) 2017 Andreas Färber
  *
- * SPDX-License-Identifier: GPL-2.0+
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/rza_wdt.c b/drivers/watchdog/rza_wdt.c
index e618218d2374..c63ef03e24f6 100644
--- a/drivers/watchdog/rza_wdt.c
+++ b/drivers/watchdog/rza_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Renesas RZ/A Series WDT Driver
  *
  * Copyright (C) 2017 Renesas Electronics America, Inc.
  * Copyright (C) 2017 Chris Brandt
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/s3c2410_wdt.c b/drivers/watchdog/s3c2410_wdt.c
index adaa43543f0a..318a5762e10a 100644
--- a/drivers/watchdog/s3c2410_wdt.c
+++ b/drivers/watchdog/s3c2410_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Simtec Electronics
  *	Ben Dooks <ben@simtec.co.uk>
@@ -6,16 +7,6 @@
  *
  * Based on, softdog.c by Alan Cox,
  *     (c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index d3be4f831db5..8805a98b5400 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Watchdog driver for the SA11x0/PXA2xx
  *
  *	(c) Copyright 2000 Oleg Drokin <green@crimea.edu>
  *	    Based on SoftDog driver by Alan Cox <alan@lxorguk.ukuu.org.uk>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Oleg Drokin nor iXcelerator.com admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 2000           Oleg Drokin <green@crimea.edu>
  *
  *	27/11/2000 Initial release
diff --git a/drivers/watchdog/sama5d4_wdt.c b/drivers/watchdog/sama5d4_wdt.c
index 0ae947c3d7bc..47d0368caef2 100644
--- a/drivers/watchdog/sama5d4_wdt.c
+++ b/drivers/watchdog/sama5d4_wdt.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Driver for Atmel SAMA5D4 Watchdog Timer
  *
  * Copyright (C) 2015 Atmel Corporation
- *
- * Licensed under GPLv2.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/watchdog/sb_wdog.c b/drivers/watchdog/sb_wdog.c
index 3abae50773b8..1bd2145b12c4 100644
--- a/drivers/watchdog/sb_wdog.c
+++ b/drivers/watchdog/sb_wdog.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-1.0 OR GPL-2.0
 /*
  * Watchdog driver for SiByte SB1 SoCs
  *
@@ -38,10 +39,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	version 1 or 2 as published by the Free Software Foundation.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/sbc60xxwdt.c b/drivers/watchdog/sbc60xxwdt.c
index 87333a41f753..663c386abe89 100644
--- a/drivers/watchdog/sbc60xxwdt.c
+++ b/drivers/watchdog/sbc60xxwdt.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	60xx Single Board Computer Watchdog Timer driver for Linux 2.2.x
  *
  *	Based on acquirewdt.c by Alan Cox.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	The author does NOT admit liability nor provide warranty for
- *	any of this software. This material is provided "AS-IS" in
- *	the hope that it may be useful for others.
- *
  *	(c) Copyright 2000    Jakob Oestergaard <jakob@unthought.net>
  *
  *           12/4 - 2000      [Initial revision]
diff --git a/drivers/watchdog/sbc7240_wdt.c b/drivers/watchdog/sbc7240_wdt.c
index 5f268add17ce..4da02054c7a5 100644
--- a/drivers/watchdog/sbc7240_wdt.c
+++ b/drivers/watchdog/sbc7240_wdt.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *	NANO7240 SBC Watchdog device driver
  *
  *	Based on w83877f.c by Scott Jennings,
  *
- *	This program is free software; you can redistribute it and/or modify
- *	it under the terms of the GNU General Public License version 2 as
- *	published by the Free Software Foundation;
- *
- *	Software distributed under the License is distributed on an "AS IS"
- *	basis, WITHOUT WARRANTY OF ANY KIND, either express or
- *	implied. See the License for the specific language governing
- *	rights and limitations under the License.
- *
  *	(c) Copyright 2007  Gilles GIGAN <gilles.gigan@jcu.edu.au>
  *
  */
@@ -308,4 +300,4 @@ module_exit(sbc7240_wdt_unload);
 MODULE_AUTHOR("Gilles Gigan");
 MODULE_DESCRIPTION("Watchdog device driver for single board"
 		   " computers EPIC Nano 7240 from iEi");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/sbc8360.c b/drivers/watchdog/sbc8360.c
index da60560ca446..e74c5cf9ea14 100644
--- a/drivers/watchdog/sbc8360.c
+++ b/drivers/watchdog/sbc8360.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	SBC8360 Watchdog driver
  *
@@ -19,15 +20,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *	14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
diff --git a/drivers/watchdog/sbc_epx_c3.c b/drivers/watchdog/sbc_epx_c3.c
index a1c502e0d8ec..3fb6e7f1287d 100644
--- a/drivers/watchdog/sbc_epx_c3.c
+++ b/drivers/watchdog/sbc_epx_c3.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	SBC EPX C3 0.1	A Hardware Watchdog Device for the Winsystems EPX-C3
  *	single board computer
@@ -5,11 +6,6 @@
  *	(c) Copyright 2006 Calin A. Culianu <calin@ajvar.org>, All Rights
  *	Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	based on softdog.c by Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
 
diff --git a/drivers/watchdog/sbc_fitpc2_wdt.c b/drivers/watchdog/sbc_fitpc2_wdt.c
index a517d8bae757..85d9fb57367b 100644
--- a/drivers/watchdog/sbc_fitpc2_wdt.c
+++ b/drivers/watchdog/sbc_fitpc2_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for SBC-FITPC2 board
  *
  * Author: Denis Turischev <denis@compulab.co.il>
  *
  * Adapted from the IXP2000 watchdog driver by Deepak Saxena.
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME " WATCHDOG: " fmt
@@ -262,4 +259,4 @@ MODULE_PARM_DESC(margin, "Watchdog margin in seconds (default 60s)");
 module_param(nowayout, bool, 0);
 MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started");
 
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 316c2eb122d2..a2a9e7e8a38f 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SBSA(Server Base System Architecture) Generic Watchdog driver
  *
@@ -7,15 +8,6 @@
  *         Al Stone <al.stone@linaro.org>
  *         Timur Tabi <timur@codeaurora.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License 2 as published
- * by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  * ARM SBSA Generic Watchdog has two stage timeouts:
  * the first signal (WS0) is for alerting the system by interrupt,
  * the second one (WS1) is a real hardware reset.
diff --git a/drivers/watchdog/sc1200wdt.c b/drivers/watchdog/sc1200wdt.c
index 8e4e2fc13f87..1aad3afac393 100644
--- a/drivers/watchdog/sc1200wdt.c
+++ b/drivers/watchdog/sc1200wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
  *	(c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>,
  *			All Rights Reserved.
  *	Based on wdt.c and wdt977.c by Alan Cox and Woody Suwalski respectively.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	The author(s) of this software shall not be held liable for damages
- *	of any nature resulting due to the use of this software. This
- *	software is provided AS-IS with no warranties.
- *
  *	Changelog:
  *	20020220 Zwane Mwaikambo	Code based on datasheet, no hardware.
  *	20020221 Zwane Mwaikambo	Cleanups as suggested by Jeff Garzik
diff --git a/drivers/watchdog/sc520_wdt.c b/drivers/watchdog/sc520_wdt.c
index 6aadb56e7faa..c9a17898d65c 100644
--- a/drivers/watchdog/sc520_wdt.c
+++ b/drivers/watchdog/sc520_wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	AMD Elan SC520 processor Watchdog Timer driver
  *
  *	Based on acquirewdt.c by Alan Cox,
  *	     and sbc60xxwdt.c by Jakob Oestergaard <jakob@unthought.net>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	The authors do NOT admit liability nor provide warranty for
- *	any of this software. This material is provided "AS-IS" in
- *	the hope that it may be useful for others.
- *
  *	(c) Copyright 2001    Scott Jennings <linuxdrivers@oro.net>
  *           9/27 - 2001      [Initial release]
  *
diff --git a/drivers/watchdog/sch311x_wdt.c b/drivers/watchdog/sch311x_wdt.c
index 43d0cbb7ba0b..2f41e66ad644 100644
--- a/drivers/watchdog/sch311x_wdt.c
+++ b/drivers/watchdog/sch311x_wdt.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	sch311x_wdt.c - Driver for the SCH311x Super-I/O chips
  *			integrated watchdog.
  *
  *	(c) Copyright 2008 Wim Van Sebroeck <wim@iguana.be>.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Wim Van Sebroeck nor Iguana vzw. admit liability nor
- *	provide warranty for any of this software. This material is
- *	provided "AS-IS" and at no charge.
  */
 
 /*
diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
index 836377cf9271..a4b2ea605ad6 100644
--- a/drivers/watchdog/scx200_wdt.c
+++ b/drivers/watchdog/scx200_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* drivers/char/watchdog/scx200_wdt.c
 
    National Semiconductor SCx200 Watchdog support
@@ -7,15 +8,8 @@
    Some code taken from:
    National Semiconductor PC87307/PC97307 (ala SC1200) WDT driver
    (c) Copyright 2002 Zwane Mwaikambo <zwane@commfireservices.com>
+*/
 
-   This program is free software; you can redistribute it and/or
-   modify it under the terms of the GNU General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   The author(s) of this software shall not be held liable for damages
-   of any nature resulting due to the use of this software. This
-   software is provided AS-IS with no warranties. */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
diff --git a/drivers/watchdog/shwdt.c b/drivers/watchdog/shwdt.c
index a7d6425db807..4a14a2154b55 100644
--- a/drivers/watchdog/shwdt.c
+++ b/drivers/watchdog/shwdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * drivers/watchdog/shwdt.c
  *
@@ -5,11 +6,6 @@
  *
  * Copyright (C) 2001 - 2012  Paul Mundt <lethal@linux-sh.org>
  *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
  * 14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
  *     Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *
diff --git a/drivers/watchdog/sirfsoc_wdt.c b/drivers/watchdog/sirfsoc_wdt.c
index 4eea351e09b0..5943020c141d 100644
--- a/drivers/watchdog/sirfsoc_wdt.c
+++ b/drivers/watchdog/sirfsoc_wdt.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for CSR SiRFprimaII and SiRFatlasVI
  *
  * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
- *
- * Licensed under GPLv2 or later.
  */
 
 #include <linux/module.h>
@@ -227,5 +226,5 @@ module_platform_driver(sirfsoc_wdt_driver);
 
 MODULE_DESCRIPTION("SiRF SoC watchdog driver");
 MODULE_AUTHOR("Xianglong Du <Xianglong.Du@csr.com>");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL+");
 MODULE_ALIAS("platform:sirfsoc-wdt");
diff --git a/drivers/watchdog/smsc37b787_wdt.c b/drivers/watchdog/smsc37b787_wdt.c
index 445ea1ad1fa9..41da9bb76101 100644
--- a/drivers/watchdog/smsc37b787_wdt.c
+++ b/drivers/watchdog/smsc37b787_wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	SMsC 37B787 Watchdog Timer driver for Linux 2.6.x.x
  *
  *	Based on acquirewdt.c by Alan Cox <alan@lxorguk.ukuu.org.uk>
  *	and some other existing drivers
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	The authors do NOT admit liability nor provide warranty for
- *	any of this software. This material is provided "AS-IS" in
- *	the hope that it may be useful for others.
- *
  *	(C) Copyright 2003-2006  Sven Anders <anders@anduras.de>
  *
  *  History:
diff --git a/drivers/watchdog/softdog.c b/drivers/watchdog/softdog.c
index 060740625485..e5212a53f60b 100644
--- a/drivers/watchdog/softdog.c
+++ b/drivers/watchdog/softdog.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	SoftDog:	A Software Watchdog Device
  *
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *							All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *	Software only watchdog driver. Unlike its big brother the WDT501P
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 41aaae2d5287..acbabaa79687 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	sp5100_tco :	TCO timer driver for sp5100 chipsets
  *
@@ -8,11 +9,6 @@
  *	Reserved.
  *				http://www.kernelconcepts.de
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  *	See AMD Publication 43009 "AMD SB700/710/750 Register Reference Guide",
  *	    AMD Publication 45482 "AMD SB800-Series Southbridges Register
  *	                                                      Reference Guide"
diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
index 03805bc5d67a..1a511a9cce25 100644
--- a/drivers/watchdog/sp805_wdt.c
+++ b/drivers/watchdog/sp805_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * drivers/char/watchdog/sp805-wdt.c
  *
@@ -5,10 +6,6 @@
  *
  * Copyright (C) 2010 ST Microelectronics
  * Viresh Kumar <vireshk@kernel.org>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2 or later. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/device.h>
diff --git a/drivers/watchdog/sprd_wdt.c b/drivers/watchdog/sprd_wdt.c
index a8b280ff33e0..36e9a08e9b78 100644
--- a/drivers/watchdog/sprd_wdt.c
+++ b/drivers/watchdog/sprd_wdt.c
@@ -1,15 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Spreadtrum watchdog driver
  * Copyright (C) 2017 Spreadtrum - http://www.spreadtrum.com
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * version 2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/st_lpc_wdt.c b/drivers/watchdog/st_lpc_wdt.c
index e6100e447dd8..177829b379da 100644
--- a/drivers/watchdog/st_lpc_wdt.c
+++ b/drivers/watchdog/st_lpc_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ST's LPC Watchdog
  *
@@ -5,11 +6,6 @@
  *
  * Author: David Paris <david.paris@st.com> for STMicroelectronics
  *         Lee Jones <lee.jones@linaro.org> for STMicroelectronics
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/watchdog/stmp3xxx_rtc_wdt.c b/drivers/watchdog/stmp3xxx_rtc_wdt.c
index d8b11eb269ad..994c54cc68e9 100644
--- a/drivers/watchdog/stmp3xxx_rtc_wdt.c
+++ b/drivers/watchdog/stmp3xxx_rtc_wdt.c
@@ -1,13 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for the RTC based watchdog in STMP3xxx and i.MX23/28
  *
  * Author: Wolfram Sang <kernel@pengutronix.de>
  *
  * Copyright (C) 2011-12 Wolfram Sang, Pengutronix
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 #include <linux/kernel.h>
 #include <linux/module.h>
diff --git a/drivers/watchdog/sun4v_wdt.c b/drivers/watchdog/sun4v_wdt.c
index 00907973608c..e6df7e899631 100644
--- a/drivers/watchdog/sun4v_wdt.c
+++ b/drivers/watchdog/sun4v_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	sun4v watchdog timer
  *	(c) Copyright 2016 Oracle Corporation
@@ -5,11 +6,6 @@
  *	Implement a simple watchdog driver using the built-in sun4v hypervisor
  *	watchdog support. If time expires, the hypervisor stops or bounces
  *	the guest domain.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index 802e31b1416d..6510eab83490 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -1,14 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *      sunxi Watchdog Driver
  *
  *      Copyright (c) 2013 Carlo Caione
  *                    2012 Henrik Nordstrom
  *
- *      This program is free software; you can redistribute it and/or
- *      modify it under the terms of the GNU General Public License
- *      as published by the Free Software Foundation; either version
- *      2 of the License, or (at your option) any later version.
- *
  *      Based on xen_wdt.c
  *      (c) Copyright 2010 Novell, Inc.
  */
diff --git a/drivers/watchdog/tangox_wdt.c b/drivers/watchdog/tangox_wdt.c
index d5fcce062920..b1de8297fa40 100644
--- a/drivers/watchdog/tangox_wdt.c
+++ b/drivers/watchdog/tangox_wdt.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Copyright (C) 2015 Mans Rullgard <mans@mansr.com>
  *  SMP86xx/SMP87xx Watchdog driver
- *
- *  This program is free software; you can redistribute it and/or modify it
- *  under  the terms of the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the License, or (at your
- *  option) any later version.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/tegra_wdt.c b/drivers/watchdog/tegra_wdt.c
index 9403c08816e3..877dd39bd41f 100644
--- a/drivers/watchdog/tegra_wdt.c
+++ b/drivers/watchdog/tegra_wdt.c
@@ -1,14 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/ts4800_wdt.c b/drivers/watchdog/ts4800_wdt.c
index 2b8de8602b67..8087caca5882 100644
--- a/drivers/watchdog/ts4800_wdt.c
+++ b/drivers/watchdog/ts4800_wdt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for TS-4800 based boards
  *
  * Copyright (c) 2015 - Savoir-faire Linux
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/kernel.h>
diff --git a/drivers/watchdog/ts72xx_wdt.c b/drivers/watchdog/ts72xx_wdt.c
index 811e43c39ec4..d3d36799ecc2 100644
--- a/drivers/watchdog/ts72xx_wdt.c
+++ b/drivers/watchdog/ts72xx_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for Technologic Systems TS-72xx based SBCs
  * (TS-7200, TS-7250 and TS-7260). These boards have external
@@ -7,10 +8,6 @@
  * Copyright (c) 2009 Mika Westerberg <mika.westerberg@iki.fi>
  *
  * This driver is based on ep93xx_wdt and wm831x_wdt drivers.
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/platform_device.h>
@@ -175,5 +172,5 @@ module_platform_driver(ts72xx_wdt_driver);
 
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
 MODULE_DESCRIPTION("TS-72xx SBC Watchdog");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ts72xx-wdt");
diff --git a/drivers/watchdog/twl4030_wdt.c b/drivers/watchdog/twl4030_wdt.c
index 569fe85e52da..65a2aabccaff 100644
--- a/drivers/watchdog/twl4030_wdt.c
+++ b/drivers/watchdog/twl4030_wdt.c
@@ -1,21 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) Nokia Corporation
  *
  * Written by Timo Kokkonen <timo.t.kokkonen at nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
index 6f7a9deb27d0..bcaa588ef3d8 100644
--- a/drivers/watchdog/txx9wdt.c
+++ b/drivers/watchdog/txx9wdt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
- * txx9wdt: A Hardware Watchdog Driver for TXx9 SoCs
+ * txx9wdt: A Hardware Watchdog Driver for TXx9 SoC
  *
  * Copyright (C) 2007 Atsushi Nemoto <anemo@mba.ocn.ne.jp>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -174,5 +171,5 @@ static struct platform_driver txx9wdt_driver = {
 module_platform_driver_probe(txx9wdt_driver, txx9wdt_probe);
 
 MODULE_DESCRIPTION("TXx9 Watchdog Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:txx9wdt");
diff --git a/drivers/watchdog/uniphier_wdt.c b/drivers/watchdog/uniphier_wdt.c
index 0ea2339d9702..769d75344050 100644
--- a/drivers/watchdog/uniphier_wdt.c
+++ b/drivers/watchdog/uniphier_wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Watchdog driver for the UniPhier watchdog timer
  *
  * (c) Copyright 2014 Panasonic Corporation
  * (c) Copyright 2016 Socionext Inc.
  * All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/bitops.h>
diff --git a/drivers/watchdog/ux500_wdt.c b/drivers/watchdog/ux500_wdt.c
index 37c084353cce..106507122f2f 100644
--- a/drivers/watchdog/ux500_wdt.c
+++ b/drivers/watchdog/ux500_wdt.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) ST-Ericsson SA 2011-2013
  *
- * License Terms: GNU General Public License v2
- *
  * Author: Mathieu Poirier <mathieu.poirier@linaro.org> for ST-Ericsson
  * Author: Jonas Aaberg <jonas.aberg@stericsson.com> for ST-Ericsson
  */
@@ -165,5 +164,5 @@ module_platform_driver(ux500_wdt_driver);
 
 MODULE_AUTHOR("Jonas Aaberg <jonas.aberg@stericsson.com>");
 MODULE_DESCRIPTION("Ux500 Watchdog Driver");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:ux500_wdt");
diff --git a/drivers/watchdog/via_wdt.c b/drivers/watchdog/via_wdt.c
index b085ef1084ec..119f0c03e7af 100644
--- a/drivers/watchdog/via_wdt.c
+++ b/drivers/watchdog/via_wdt.c
@@ -1,8 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * VIA Chipset Watchdog Driver
  *
  * Copyright (C) 2011 Sigfox
- * License terms: GNU General Public License (GPL) version 2
  * Author: Marc Vertes <marc.vertes@sigfox.com>
  * Based on a preliminary version from Harald Welte <HaraldWelte@viatech.com>
  * Timer code by Wim Van Sebroeck <wim@iguana.be>
@@ -258,4 +258,4 @@ module_pci_driver(wdt_driver);
 
 MODULE_AUTHOR("Marc Vertes");
 MODULE_DESCRIPTION("Driver for watchdog timer on VIA chipset");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/watchdog/w83627hf_wdt.c b/drivers/watchdog/w83627hf_wdt.c
index 7817836bff55..9cd729219770 100644
--- a/drivers/watchdog/w83627hf_wdt.c
+++ b/drivers/watchdog/w83627hf_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	w83627hf/thf WDT driver
  *
@@ -17,15 +18,6 @@
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  */
 
diff --git a/drivers/watchdog/w83877f_wdt.c b/drivers/watchdog/w83877f_wdt.c
index 05658ecc0aa4..c51c5d021c3d 100644
--- a/drivers/watchdog/w83877f_wdt.c
+++ b/drivers/watchdog/w83877f_wdt.c
@@ -1,18 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	W83877F Computer Watchdog Timer driver
  *
  *      Based on acquirewdt.c by Alan Cox,
  *           and sbc60xxwdt.c by Jakob Oestergaard <jakob@unthought.net>
  *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	The authors do NOT admit liability nor provide warranty for
- *	any of this software. This material is provided "AS-IS" in
- *      the hope that it may be useful for others.
- *
  *	(c) Copyright 2001    Scott Jennings <linuxdrivers@oro.net>
  *
  *           4/19 - 2001      [Initial revision]
diff --git a/drivers/watchdog/w83977f_wdt.c b/drivers/watchdog/w83977f_wdt.c
index 20e2bba10400..5f2021b7a71a 100644
--- a/drivers/watchdog/w83977f_wdt.c
+++ b/drivers/watchdog/w83977f_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	W83977F Watchdog Timer Driver for Winbond W83977F I/O Chip
  *
@@ -5,14 +6,6 @@
  *
  *      Based on w83877f_wdt.c by Scott Jennings,
  *           and wdt977.c by Woody Suwalski
- *
- *			-----------------------
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/wafer5823wdt.c b/drivers/watchdog/wafer5823wdt.c
index db0da7ea4fd8..64b5df010d52 100644
--- a/drivers/watchdog/wafer5823wdt.c
+++ b/drivers/watchdog/wafer5823wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	ICP Wafer 5823 Single Board Computer WDT driver
  *	http://www.icpamerica.com/wafer_5823.php
@@ -12,16 +13,6 @@
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  */
diff --git a/drivers/watchdog/watchdog_core.c b/drivers/watchdog/watchdog_core.c
index eb8fa25f8eb2..041605f41e12 100644
--- a/drivers/watchdog/watchdog_core.c
+++ b/drivers/watchdog/watchdog_core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	watchdog_core.c
  *
@@ -15,15 +16,6 @@
  *	  Rusty Lynch <rusty@linux.co.intel.com>
  *	  Satyam Sharma <satyam@infradead.org>
  *	  Randy Dunlap <randy.dunlap@oracle.com>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox, CymruNet Ltd., Wim Van Sebroeck nor Iguana vzw.
- *	admit liability nor provide warranty for any of this software.
- *	This material is provided "AS-IS" and at no charge.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/watchdog_core.h b/drivers/watchdog/watchdog_core.h
index 86ff962d1e15..96deb573518f 100644
--- a/drivers/watchdog/watchdog_core.h
+++ b/drivers/watchdog/watchdog_core.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
 /*
  *	watchdog_core.h
  *
@@ -15,15 +16,6 @@
  *	  Rusty Lynch <rusty@linux.co.intel.com>
  *	  Satyam Sharma <satyam@infradead.org>
  *	  Randy Dunlap <randy.dunlap@oracle.com>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox, CymruNet Ltd., Wim Van Sebroeck nor Iguana vzw.
- *	admit liability nor provide warranty for any of this software.
- *	This material is provided "AS-IS" and at no charge.
  */
 
 #define MAX_DOGS	32	/* Maximum number of watchdog devices */
diff --git a/drivers/watchdog/watchdog_dev.c b/drivers/watchdog/watchdog_dev.c
index ffbdc4642ea5..116aca7b962b 100644
--- a/drivers/watchdog/watchdog_dev.c
+++ b/drivers/watchdog/watchdog_dev.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	watchdog_dev.c
  *
@@ -19,15 +20,6 @@
  *	  Rusty Lynch <rusty@linux.co.intel.com>
  *	  Satyam Sharma <satyam@infradead.org>
  *	  Randy Dunlap <randy.dunlap@oracle.com>
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox, CymruNet Ltd., Wim Van Sebroeck nor Iguana vzw.
- *	admit liability nor provide warranty for any of this software.
- *	This material is provided "AS-IS" and at no charge.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/watchdog_pretimeout.c b/drivers/watchdog/watchdog_pretimeout.c
index 9db07bfb4334..c140ed538580 100644
--- a/drivers/watchdog/watchdog_pretimeout.c
+++ b/drivers/watchdog/watchdog_pretimeout.c
@@ -1,11 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015-2016 Mentor Graphics
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
  */
 
 #include <linux/list.h>
diff --git a/drivers/watchdog/wd501p.h b/drivers/watchdog/wd501p.h
index 0e3a497d5626..a0cbca365744 100644
--- a/drivers/watchdog/wd501p.h
+++ b/drivers/watchdog/wd501p.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Industrial Computer Source WDT500/501 driver
  *
diff --git a/drivers/watchdog/wdat_wdt.c b/drivers/watchdog/wdat_wdt.c
index 6d1fbda0f461..46869a487e51 100644
--- a/drivers/watchdog/wdat_wdt.c
+++ b/drivers/watchdog/wdat_wdt.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ACPI Hardware Watchdog (WDAT) driver.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #include <linux/acpi.h>
diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
index 0240c60d14e3..af07f746b7cc 100644
--- a/drivers/watchdog/wdrtas.c
+++ b/drivers/watchdog/wdrtas.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * FIXME: add wdrtas_get_status and wdrtas_get_boot_status as soon as
  * RTAS calls are available
@@ -10,20 +11,6 @@
  * device driver to exploit watchdog RTAS functions
  *
  * Authors : Utz Bacher <utz.bacher@de.ibm.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/wdt.c b/drivers/watchdog/wdt.c
index e481fbbc4ae7..28f7f8ac2dac 100644
--- a/drivers/watchdog/wdt.c
+++ b/drivers/watchdog/wdt.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Industrial Computer Source WDT501 driver
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *	Release 0.10.
diff --git a/drivers/watchdog/wdt285.c b/drivers/watchdog/wdt285.c
index ebbb183be618..943f56a111b9 100644
--- a/drivers/watchdog/wdt285.c
+++ b/drivers/watchdog/wdt285.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Intel 21285 watchdog driver
  *	Copyright (c) Phil Blundell <pb@nexus.co.uk>, 1998
@@ -8,12 +9,6 @@
  *
  *	(c) Copyright 1996 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/wdt977.c b/drivers/watchdog/wdt977.c
index a8e6f87f60c9..1975bc760499 100644
--- a/drivers/watchdog/wdt977.c
+++ b/drivers/watchdog/wdt977.c
@@ -1,16 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Wdt977	0.04:	A Watchdog Device for Netwinder W83977AF chip
  *
  *	(c) Copyright 1998 Rebel.com (Woody Suwalski <woody@netwinder.org>)
  *
  *			-----------------------
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *			-----------------------
  *      14-Dec-2001 Matt Domsch <Matt_Domsch@dell.com>
  *           Added nowayout module option to override CONFIG_WATCHDOG_NOWAYOUT
  *	19-Dec-2001 Woody Suwalski: Netwinder fixes, ioctl interface
diff --git a/drivers/watchdog/wdt_pci.c b/drivers/watchdog/wdt_pci.c
index 10e2cda0ee5a..8b5a3db2875c 100644
--- a/drivers/watchdog/wdt_pci.c
+++ b/drivers/watchdog/wdt_pci.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Industrial Computer Source PCI-WDT500/501 driver
  *
  *	(c) Copyright 1996-1997 Alan Cox <alan@lxorguk.ukuu.org.uk>,
  *						All Rights Reserved.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
- *
- *	Neither Alan Cox nor CymruNet Ltd. admit liability nor provide
- *	warranty for any of this software. This material is provided
- *	"AS-IS" and at no charge.
- *
  *	(c) Copyright 1995    Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  *	Release 0.10.
diff --git a/drivers/watchdog/wm831x_wdt.c b/drivers/watchdog/wm831x_wdt.c
index 1ddc1f742cd4..116c2f47b463 100644
--- a/drivers/watchdog/wm831x_wdt.c
+++ b/drivers/watchdog/wm831x_wdt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for the wm831x PMICs
  *
  * Copyright (C) 2009 Wolfson Microelectronics
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation
  */
 
 #include <linux/module.h>
diff --git a/drivers/watchdog/wm8350_wdt.c b/drivers/watchdog/wm8350_wdt.c
index 4ab4b8347d45..33c62d51f00a 100644
--- a/drivers/watchdog/wm8350_wdt.c
+++ b/drivers/watchdog/wm8350_wdt.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Watchdog driver for the wm8350
  *
  * Copyright (C) 2007, 2008 Wolfson Microelectronics <linux@wolfsonmicro.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
diff --git a/drivers/watchdog/xen_wdt.c b/drivers/watchdog/xen_wdt.c
index f1c016d015b3..8319bee42aaf 100644
--- a/drivers/watchdog/xen_wdt.c
+++ b/drivers/watchdog/xen_wdt.c
@@ -1,12 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *	Xen Watchdog Driver
  *
  *	(c) Copyright 2010 Novell, Inc.
- *
- *	This program is free software; you can redistribute it and/or
- *	modify it under the terms of the GNU General Public License
- *	as published by the Free Software Foundation; either version
- *	2 of the License, or (at your option) any later version.
  */
 
 #define DRV_NAME	"xen_wdt"
diff --git a/drivers/watchdog/ziirave_wdt.c b/drivers/watchdog/ziirave_wdt.c
index d3594aa3a374..93d70f03c567 100644
--- a/drivers/watchdog/ziirave_wdt.c
+++ b/drivers/watchdog/ziirave_wdt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2015 Zodiac Inflight Innovations
  *
@@ -6,16 +7,6 @@
  * Based on twl4030_wdt.c by Timo Kokkonen <timo.t.kokkonen at nokia.com>:
  *
  * Copyright (C) Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/watchdog/zx2967_wdt.c b/drivers/watchdog/zx2967_wdt.c
index 9261f7c77f6d..29cb56139fac 100644
--- a/drivers/watchdog/zx2967_wdt.c
+++ b/drivers/watchdog/zx2967_wdt.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * watchdog driver for ZTE's zx2967 family
  *
  * Copyright (C) 2017 ZTE Ltd.
  *
  * Author: Baoyou Xie <baoyou.xie@linaro.org>
- *
- * License terms: GNU General Public License (GPL) version 2
  */
 
 #include <linux/clk.h>
-- 
2.16.2
