Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znTlf3CQzzF1cw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 09:38:22 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marcus Folkesson <marcus.folkesson@gmail.com>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel Stanley
 <joel@jms.id.au>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@free-electrons.com>, Eric Anholt
 <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott
 Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Linus Walleij <linus.walleij@linaro.org>, Support Opensource
 <support.opensource@diasemi.com>, Baruch Siach <baruch@tkos.co.il>,
 William Breathitt Gray <vilhelm.gray@gmail.com>, Jimmy Vance
 <jimmy.vance@hpe.com>, Keguang Zhang <keguang.zhang@gmail.com>, Joachim
 Eastwood <manabian@gmail.com>, Tomas Winkler <tomas.winkler@intel.com>,
 Johannes Thumshirn <morbidrsa@gmail.com>, Andreas Werner
 <andreas.werner@men.de>, Carlo Caione <carlo@caione.org>, Kevin Hilman
 <khilman@baylibre.com>, Matthias Brugger <matthias.bgg@gmail.com>, Wan
 ZongShun <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>, Zwane Mwaikambo <zwanem@gmail.com>, Jim
 Cromie <jim.cromie@gmail.com>, Barry Song <baohua@kernel.org>, Patrice
 Chotard <patrice.chotard@st.com>, Maxime Ripard
 <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, Marc Gonzalez
 <marc.w.gonzalez@free.fr>, Mans Rullgard <mans@mansr.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jun Nie
 <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo
 <shawnguo@kernel.org>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
 linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com,
 Utz Bacher <utz.bacher@de.ibm.com>
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com>
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
Date: Fri, 23 Feb 2018 09:38:21 +1100
Message-ID: <87po4wps4i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Marcus Folkesson <marcus.folkesson@gmail.com> writes:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

<snip>

> diff --git a/drivers/watchdog/wdrtas.c b/drivers/watchdog/wdrtas.c
> index 0240c60d14e3..af07f746b7cc 100644
> --- a/drivers/watchdog/wdrtas.c
> +++ b/drivers/watchdog/wdrtas.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * FIXME: add wdrtas_get_status and wdrtas_get_boot_status as soon as
>   * RTAS calls are available
> @@ -10,20 +11,6 @@
>   * device driver to exploit watchdog RTAS functions
>   *
>   * Authors : Utz Bacher <utz.bacher@de.ibm.com>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2, or (at your option)
> - * any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>   */

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
