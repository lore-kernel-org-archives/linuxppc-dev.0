Return-Path: <Nicolas.Ferre@microchip.com>
Received: from esa3.microchip.iphmx.com (esa3.microchip.iphmx.com
 [68.232.153.233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlxg85bH6zF0hY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:29:08 +1100 (AEDT)
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley
 <joel@jms.id.au>, Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Linus
 Walleij <linus.walleij@linaro.org>, Support Opensource
 <support.opensource@diasemi.com>, Baruch Siach <baruch@tkos.co.il>, William
 Breathitt Gray <vilhelm.gray@gmail.com>, Jimmy Vance <jimmy.vance@hpe.com>,
 Keguang Zhang <keguang.zhang@gmail.com>, Joachim Eastwood
 <manabian@gmail.com>, Tomas Winkler <tomas.winkler@intel.com>, Johannes
 Thumshirn <morbidrsa@gmail.com>, Andreas Werner <andreas.werner@men.de>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Vladimir
 Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Kukjin
 Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Zwane
 Mwaikambo <zwanem@gmail.com>, Jim Cromie <jim.cromie@gmail.com>, Barry Song
 <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>, Maxime Ripard
 <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Marc Gonzalez
 <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie
 <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linux-mips@linux-mips.org>,
 <linux-amlogic@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <patches@opensource.cirrus.com>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Message-ID: <5a06150c-6ac4-4836-d8fb-cb0a9a0d9561@microchip.com>
Date: Tue, 20 Feb 2018 11:15:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/02/2018 at 10:31, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>    license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> 
> Notes:
>      v1: Please have an extra look at meson_gxbb_wdt.c
> 
>   drivers/watchdog/acquirewdt.c          |  6 +---

[..]

>   drivers/watchdog/at91rm9200_wdt.c      |  5 +---
>   drivers/watchdog/at91sam9_wdt.c        |  5 +---
>   drivers/watchdog/at91sam9_wdt.h        |  5 +---

For these 3

[..]

>   drivers/watchdog/sama5d4_wdt.c         |  3 +-

And this one:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
-- 
Nicolas Ferre
