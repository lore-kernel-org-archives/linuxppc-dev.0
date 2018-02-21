Return-Path: <vilhelm.gray@gmail.com>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com
 [IPv6:2607:f8b0:4002:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmcXP0wKvzF0rd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 23:40:35 +1100 (AEDT)
Received: by mail-yw0-x242.google.com with SMTP id y186so437839ywf.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 04:40:35 -0800 (PST)
Date: Wed, 21 Feb 2018 07:40:25 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com,
 Linus Walleij <linus.walleij@linaro.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Baruch Siach <baruch@tkos.co.il>, Jimmy Vance <jimmy.vance@hpe.com>,
 Keguang Zhang <keguang.zhang@gmail.com>,
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
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jun Nie <jun.nie@linaro.org>,
 Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net,
 linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
 linux-mediatek@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180221124024.GA3773@sophia>
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Feb 21, 2018 at 01:27:34PM +0100, Marcus Folkesson wrote:
>- Add SPDX identifier
>- Remove boiler plate license text
>- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>  license
>
>Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>Acked-by: Mans Rullgard <mans@mansr.com>
>Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>Acked-by: Michal Simek <michal.simek@xilinx.com>
>Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>Acked-by: Thierry Reding <treding@nvidia.com>
>Reviewed-by: Eric Anholt <eric@anholt.net>
>---
>
>Notes:
>    v3:
>    	- Keep license text for ebc-c384_wdt
>    v2:
>    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>    	- Change to BSD-3-Clause for meson_gxbb_wdt
>    v1: Please have an extra look at meson_gxbb_wdt.c

[...]

>diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
>index 2170b275ea01..4c4c8ce78021 100644
>--- a/drivers/watchdog/ebc-c384_wdt.c
>+++ b/drivers/watchdog/ebc-c384_wdt.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0
> /*
>  * Watchdog timer driver for the WinSystems EBC-C384
>  * Copyright (C) 2016 William Breathitt Gray

For ebc-c384_wdt.c,

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

William Breathitt Gray
