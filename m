Return-Path: <ckeepax@opensource.cirrus.com>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zly472D9rzF0h9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:47:19 +1100 (AEDT)
Date: Tue, 20 Feb 2018 10:20:57 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
CC: Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@free-electrons.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
 Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
 Linus Walleij <linus.walleij@linaro.org>, Support Opensource
 <support.opensource@diasemi.com>, Baruch Siach <baruch@tkos.co.il>,
 "William Breathitt Gray" <vilhelm.gray@gmail.com>,
 Jimmy Vance <jimmy.vance@hpe.com>, Keguang Zhang <keguang.zhang@gmail.com>,
 Joachim Eastwood <manabian@gmail.com>,
 Tomas Winkler <tomas.winkler@intel.com>, "Johannes
 Thumshirn" <morbidrsa@gmail.com>, Andreas Werner <andreas.werner@men.de>,
 Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>, "Vladimir
 Zapolskiy" <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Zwane
 Mwaikambo <zwanem@gmail.com>, Jim Cromie <jim.cromie@gmail.com>, Barry Song
 <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
 "Marc Gonzalez" <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>,
 "Thierry Reding" <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Masahiro
 Yamada <yamada.masahiro@socionext.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Jun Nie <jun.nie@linaro.org>, Baoyou Xie
 <baoyou.xie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rpi-kernel@lists.infradead.org>,
 <adi-buildroot-devel@lists.sourceforge.net>,
 <linux-mips@linux-mips.org>, <linux-amlogic@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180220102057.um6g7gykvrnjx2qs@localhost.localdomain>
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20180220093119.23720-1-marcus.folkesson@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 20, 2018 at 10:31:08AM +0100, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/watchdog/wm831x_wdt.c          |  5 +---
>  drivers/watchdog/wm8350_wdt.c          |  5 +---

For the Wolfson parts:

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
