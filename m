Return-Path: <matthias.bgg@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmF3P59f7zF1BD
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 09:02:41 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id p5so8195933plo.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 14:02:41 -0800 (PST)
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
To: Marcus Folkesson <marcus.folkesson@gmail.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Support Opensource <support.opensource@diasemi.com>,
 Baruch Siach <baruch@tkos.co.il>,
 William Breathitt Gray <vilhelm.gray@gmail.com>,
 Jimmy Vance <jimmy.vance@hpe.com>, Keguang Zhang <keguang.zhang@gmail.com>,
 Joachim Eastwood <manabian@gmail.com>,
 Tomas Winkler <tomas.winkler@intel.com>,
 Johannes Thumshirn <morbidrsa@gmail.com>,
 Andreas Werner <andreas.werner@men.de>, Carlo Caione <carlo@caione.org>,
 Kevin Hilman <khilman@baylibre.com>, Wan ZongShun <mcuos.com@gmail.com>,
 Michal Simek <michal.simek@xilinx.com>, Vladimir Zapolskiy <vz@mleia.com>,
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
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
From: Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c5dece62-c129-fdb2-7e91-dbe587055cc0@gmail.com>
Date: Tue, 20 Feb 2018 17:26:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180220104542.32286-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 02/20/2018 11:45 AM, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Notes:
>     v2:
>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 
>  drivers/watchdog/acquirewdt.c          |  6 +---

[...]

>  drivers/watchdog/mpc8xxx_wdt.c         |  6 +---
>  drivers/watchdog/mt7621_wdt.c          |  5 +---
>  drivers/watchdog/mtk_wdt.c             | 11 +-------
>  drivers/watchdog/mtx-1_wdt.c           | 11 +-------
>  drivers/watchdog/mv64x60_wdt.c         |  6 ++--

[...]

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..498e7d4e1b66 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Mediatek Watchdog Driver
>   *
> @@ -5,16 +6,6 @@
>   *
>   * Matthias Brugger <matthias.bgg@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Based on sunxi_wdt.c
>   */
>  

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
