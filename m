Return-Path: <narmstrong@baylibre.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlxhz2LhDzF0dZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 21:30:43 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id l43so12856259wrc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 02:30:43 -0800 (PST)
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
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
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Kukjin Kim <kgene@kernel.org>,
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
 Shawn Guo <shawnguo@kernel.org>, linux-mips@linux-mips.org,
 linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 patches@opensource.cirrus.com, adi-buildroot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
 <d734dd84-ad3b-141b-779d-13d340217a18@baylibre.com>
 <20180220095811.GA24311@gmail.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <ba385270-1034-f80e-024b-1528f53b26b8@baylibre.com>
Date: Tue, 20 Feb 2018 11:30:33 +0100
MIME-Version: 1.0
In-Reply-To: <20180220095811.GA24311@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IzivREFwVUpZN1CVIM5lumn4LOmMqTANZ"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IzivREFwVUpZN1CVIM5lumn4LOmMqTANZ
Content-Type: multipart/mixed; boundary="Akfq4kJ0POMOaSnD9pn1Uka3HEHTfH41N";
 protected-headers="v1"
From: Neil Armstrong <narmstrong@baylibre.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
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
 Kevin Hilman <khilman@baylibre.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Wan ZongShun
 <mcuos.com@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux
 <slemieux.tyco@gmail.com>, Kukjin Kim <kgene@kernel.org>,
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
 Shawn Guo <shawnguo@kernel.org>, linux-mips@linux-mips.org,
 linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
 patches@opensource.cirrus.com, adi-buildroot-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Message-ID: <ba385270-1034-f80e-024b-1528f53b26b8@baylibre.com>
Subject: Re: [PATCH] watchdog: add SPDX identifiers for watchdog subsystem
References: <20180220093119.23720-1-marcus.folkesson@gmail.com>
 <d734dd84-ad3b-141b-779d-13d340217a18@baylibre.com>
 <20180220095811.GA24311@gmail.com>
In-Reply-To: <20180220095811.GA24311@gmail.com>

--Akfq4kJ0POMOaSnD9pn1Uka3HEHTfH41N
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Marcus,

On 20/02/2018 10:59, Marcus Folkesson wrote:
> On Tue, Feb 20, 2018 at 10:47:03AM +0100, Neil Armstrong wrote:
>> Hi Marcus,
>>
>> On 20/02/2018 10:31, Marcus Folkesson wrote:
>>> - Add SPDX identifier
>>> - Remove boiler plate license text
>>> - If MODULE_LICENSE and boiler plate does not match, go for boiler pl=
ate
>>>   license
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> ---
>>>
>>> Notes:
>>>     v1: Please have an extra look at meson_gxbb_wdt.c
>>>
>>>  drivers/watchdog/acquirewdt.c          |  6 +---
>>>  drivers/watchdog/advantechwdt.c        |  6 +---
>>>  drivers/watchdog/alim1535_wdt.c        |  6 +---
>>>  drivers/watchdog/alim7101_wdt.c        |  1 +
>>>  drivers/watchdog/ar7_wdt.c             | 14 +--------
>>>  drivers/watchdog/asm9260_wdt.c         |  2 +-
>>>  drivers/watchdog/aspeed_wdt.c          |  5 +---
>>>  drivers/watchdog/at91rm9200_wdt.c      |  5 +---
>>>  drivers/watchdog/at91sam9_wdt.c        |  5 +---
>>>  drivers/watchdog/at91sam9_wdt.h        |  5 +---
>>>  drivers/watchdog/ath79_wdt.c           |  4 +--
>>>  drivers/watchdog/atlas7_wdt.c          |  2 +-
>>>  drivers/watchdog/bcm2835_wdt.c         |  5 +---
>>>  drivers/watchdog/bcm47xx_wdt.c         |  5 +---
>>>  drivers/watchdog/bcm63xx_wdt.c         |  5 +---
>>>  drivers/watchdog/bcm7038_wdt.c         | 12 ++------
>>>  drivers/watchdog/bcm_kona_wdt.c        |  9 +-----
>>>  drivers/watchdog/bfin_wdt.c            |  2 +-
>>>  drivers/watchdog/booke_wdt.c           |  5 +---
>>>  drivers/watchdog/cadence_wdt.c         |  5 +---
>>>  drivers/watchdog/coh901327_wdt.c       |  7 ++---
>>>  drivers/watchdog/cpu5wdt.c             | 15 +---------
>>>  drivers/watchdog/cpwd.c                |  1 +
>>>  drivers/watchdog/da9052_wdt.c          |  6 +---
>>>  drivers/watchdog/da9055_wdt.c          |  6 +---
>>>  drivers/watchdog/da9062_wdt.c          | 10 +------
>>>  drivers/watchdog/da9063_wdt.c          |  5 +---
>>>  drivers/watchdog/davinci_wdt.c         |  7 ++---
>>>  drivers/watchdog/diag288_wdt.c         |  1 +
>>>  drivers/watchdog/digicolor_wdt.c       |  5 +---
>>>  drivers/watchdog/dw_wdt.c              |  6 +---
>>>  drivers/watchdog/ebc-c384_wdt.c        |  9 +-----
>>>  drivers/watchdog/ep93xx_wdt.c          |  7 ++---
>>>  drivers/watchdog/eurotechwdt.c         |  6 +---
>>>  drivers/watchdog/f71808e_wdt.c         | 16 +---------
>>>  drivers/watchdog/ftwdt010_wdt.c        |  6 ++--
>>>  drivers/watchdog/gef_wdt.c             |  6 +---
>>>  drivers/watchdog/geodewdt.c            |  5 +---
>>>  drivers/watchdog/gpio_wdt.c            |  5 +---
>>>  drivers/watchdog/hpwdt.c               |  7 ++---
>>>  drivers/watchdog/i6300esb.c            |  6 +---
>>>  drivers/watchdog/iTCO_vendor_support.c |  9 +-----
>>>  drivers/watchdog/iTCO_wdt.c            | 10 +------
>>>  drivers/watchdog/ib700wdt.c            |  6 +---
>>>  drivers/watchdog/ibmasr.c              |  3 +-
>>>  drivers/watchdog/ie6xx_wdt.c           | 18 ++---------
>>>  drivers/watchdog/imgpdc_wdt.c          |  5 +---
>>>  drivers/watchdog/imx2_wdt.c            |  5 +---
>>>  drivers/watchdog/indydog.c             |  6 +---
>>>  drivers/watchdog/intel-mid_wdt.c       |  6 ++--
>>>  drivers/watchdog/intel_scu_watchdog.c  | 18 ++---------
>>>  drivers/watchdog/intel_scu_watchdog.h  | 16 +---------
>>>  drivers/watchdog/iop_wdt.c             | 16 ++--------
>>>  drivers/watchdog/it8712f_wdt.c         | 10 +------
>>>  drivers/watchdog/it87_wdt.c            | 10 +------
>>>  drivers/watchdog/ixp4xx_wdt.c          |  6 ++--
>>>  drivers/watchdog/jz4740_wdt.c          | 10 +------
>>>  drivers/watchdog/kempld_wdt.c          | 12 ++------
>>>  drivers/watchdog/ks8695_wdt.c          |  6 ++--
>>>  drivers/watchdog/lantiq_wdt.c          |  7 ++---
>>>  drivers/watchdog/loongson1_wdt.c       |  5 +---
>>>  drivers/watchdog/lpc18xx_wdt.c         |  5 +---
>>>  drivers/watchdog/m54xx_wdt.c           |  6 ++--
>>>  drivers/watchdog/machzwd.c             | 11 +------
>>>  drivers/watchdog/max63xx_wdt.c         |  5 +---
>>>  drivers/watchdog/max77620_wdt.c        |  5 +---
>>>  drivers/watchdog/mei_wdt.c             | 12 ++------
>>>  drivers/watchdog/mena21_wdt.c          |  4 +--
>>>  drivers/watchdog/menf21bmc_wdt.c       |  8 ++---
>>>  drivers/watchdog/meson_gxbb_wdt.c      | 55 +-----------------------=
----------
>>>  drivers/watchdog/meson_wdt.c           |  6 +---
>>>  drivers/watchdog/mixcomwd.c            |  6 +---
>>>  drivers/watchdog/moxart_wdt.c          |  7 ++---
>>>  drivers/watchdog/mpc8xxx_wdt.c         |  6 +---
>>>  drivers/watchdog/mt7621_wdt.c          |  5 +---
>>>  drivers/watchdog/mtk_wdt.c             | 11 +------
>>>  drivers/watchdog/mtx-1_wdt.c           | 11 +------
>>>  drivers/watchdog/mv64x60_wdt.c         |  6 ++--
>>>  drivers/watchdog/ni903x_wdt.c          | 11 +------
>>>  drivers/watchdog/nic7018_wdt.c         | 11 +------
>>>  drivers/watchdog/nuc900_wdt.c          |  7 ++---
>>>  drivers/watchdog/nv_tco.c              |  6 +---
>>>  drivers/watchdog/nv_tco.h              | 10 +------
>>>  drivers/watchdog/octeon-wdt-main.c     | 11 +------
>>>  drivers/watchdog/octeon-wdt-nmi.S      |  5 +---
>>>  drivers/watchdog/of_xilinx_wdt.c       |  8 ++---
>>>  drivers/watchdog/omap_wdt.c            |  1 +
>>>  drivers/watchdog/omap_wdt.h            | 21 +------------
>>>  drivers/watchdog/orion_wdt.c           |  5 +---
>>>  drivers/watchdog/pc87413_wdt.c         | 10 +------
>>>  drivers/watchdog/pcwd.c                |  1 +
>>>  drivers/watchdog/pcwd_pci.c            | 10 +------
>>>  drivers/watchdog/pcwd_usb.c            | 10 +------
>>>  drivers/watchdog/pic32-dmt.c           |  5 +---
>>>  drivers/watchdog/pic32-wdt.c           |  6 +---
>>>  drivers/watchdog/pika_wdt.c            |  1 +
>>>  drivers/watchdog/pnx4008_wdt.c         |  7 ++---
>>>  drivers/watchdog/pnx833x_wdt.c         |  6 +---
>>>  drivers/watchdog/pretimeout_noop.c     |  7 +----
>>>  drivers/watchdog/pretimeout_panic.c    |  7 +----
>>>  drivers/watchdog/qcom-wdt.c            | 14 ++-------
>>>  drivers/watchdog/renesas_wdt.c         |  4 +--
>>>  drivers/watchdog/retu_wdt.c            | 10 +------
>>>  drivers/watchdog/riowd.c               |  1 +
>>>  drivers/watchdog/rn5t618_wdt.c         |  8 +----
>>>  drivers/watchdog/rt2880_wdt.c          |  5 +---
>>>  drivers/watchdog/rtd119x_wdt.c         |  2 +-
>>>  drivers/watchdog/rza_wdt.c             |  5 +---
>>>  drivers/watchdog/s3c2410_wdt.c         | 11 +------
>>>  drivers/watchdog/sa1100_wdt.c          | 11 +------
>>>  drivers/watchdog/sama5d4_wdt.c         |  3 +-
>>>  drivers/watchdog/sb_wdog.c             |  5 +---
>>>  drivers/watchdog/sbc60xxwdt.c          | 10 +------
>>>  drivers/watchdog/sbc7240_wdt.c         | 12 ++------
>>>  drivers/watchdog/sbc8360.c             | 10 +------
>>>  drivers/watchdog/sbc_epx_c3.c          |  6 +---
>>>  drivers/watchdog/sbc_fitpc2_wdt.c      |  7 ++---
>>>  drivers/watchdog/sbsa_gwdt.c           | 10 +------
>>>  drivers/watchdog/sc1200wdt.c           | 10 +------
>>>  drivers/watchdog/sc520_wdt.c           | 10 +------
>>>  drivers/watchdog/sch311x_wdt.c         | 10 +------
>>>  drivers/watchdog/scx200_wdt.c          | 10 ++-----
>>>  drivers/watchdog/shwdt.c               |  6 +---
>>>  drivers/watchdog/sirfsoc_wdt.c         |  5 ++--
>>>  drivers/watchdog/smsc37b787_wdt.c      | 10 +------
>>>  drivers/watchdog/softdog.c             | 10 +------
>>>  drivers/watchdog/sp5100_tco.c          |  6 +---
>>>  drivers/watchdog/sp805_wdt.c           |  5 +---
>>>  drivers/watchdog/sprd_wdt.c            | 10 +------
>>>  drivers/watchdog/st_lpc_wdt.c          |  6 +---
>>>  drivers/watchdog/stmp3xxx_rtc_wdt.c    |  5 +---
>>>  drivers/watchdog/sun4v_wdt.c           |  6 +---
>>>  drivers/watchdog/sunxi_wdt.c           |  6 +---
>>>  drivers/watchdog/tangox_wdt.c          |  6 +---
>>>  drivers/watchdog/tegra_wdt.c           | 10 +------
>>>  drivers/watchdog/ts4800_wdt.c          |  5 +---
>>>  drivers/watchdog/ts72xx_wdt.c          |  7 ++---
>>>  drivers/watchdog/twl4030_wdt.c         | 15 +---------
>>>  drivers/watchdog/txx9wdt.c             |  9 ++----
>>>  drivers/watchdog/uniphier_wdt.c        | 10 +------
>>>  drivers/watchdog/ux500_wdt.c           |  5 ++--
>>>  drivers/watchdog/via_wdt.c             |  4 +--
>>>  drivers/watchdog/w83627hf_wdt.c        | 10 +------
>>>  drivers/watchdog/w83877f_wdt.c         | 10 +------
>>>  drivers/watchdog/w83977f_wdt.c         |  9 +-----
>>>  drivers/watchdog/wafer5823wdt.c        | 11 +------
>>>  drivers/watchdog/watchdog_core.c       | 10 +------
>>>  drivers/watchdog/watchdog_core.h       | 10 +------
>>>  drivers/watchdog/watchdog_dev.c        | 10 +------
>>>  drivers/watchdog/watchdog_pretimeout.c |  6 +---
>>>  drivers/watchdog/wd501p.h              |  1 +
>>>  drivers/watchdog/wdat_wdt.c            |  5 +---
>>>  drivers/watchdog/wdrtas.c              | 15 +---------
>>>  drivers/watchdog/wdt.c                 | 11 +------
>>>  drivers/watchdog/wdt285.c              |  7 +----
>>>  drivers/watchdog/wdt977.c              |  8 +----
>>>  drivers/watchdog/wdt_pci.c             | 11 +------
>>>  drivers/watchdog/wm831x_wdt.c          |  5 +---
>>>  drivers/watchdog/wm8350_wdt.c          |  5 +---
>>>  drivers/watchdog/xen_wdt.c             |  6 +---
>>>  drivers/watchdog/ziirave_wdt.c         | 11 +------
>>>  drivers/watchdog/zx2967_wdt.c          |  3 +-
>>>  162 files changed, 195 insertions(+), 1059 deletions(-)
>>>
>>
>> [..]
>>
>>> diff --git a/drivers/watchdog/meson_gxbb_wdt.c b/drivers/watchdog/mes=
on_gxbb_wdt.c
>>> index 69a5a57f1446..500463c3e040 100644
>>> --- a/drivers/watchdog/meson_gxbb_wdt.c
>>> +++ b/drivers/watchdog/meson_gxbb_wdt.c
>>> @@ -1,57 +1,4 @@
>>> -/*
>>> - * This file is provided under a dual BSD/GPLv2 license.  When using=
 or
>>> - * redistributing this file, you may do so under either license.
>>> - *
>>> - * GPL LICENSE SUMMARY
>>> - *
>>> - * Copyright (c) 2016 BayLibre, SAS.
>>> - * Author: Neil Armstrong <narmstrong@baylibre.com>
>>
>> Please keep the copyright !
>=20
> Sorry Neil!
>=20
> I will fix that for v2.
>=20
> I saw that the copyright text has magically disappered for
> coh901327_wdt.c as well.
>=20
> What do you think about the BSD license? Is BSD-2-Clause right?

It's BSD-3-Clause instead.

>=20
>>
>>> - *
>>> - * This program is free software; you can redistribute it and/or mod=
ify
>>> - * it under the terms of version 2 of the GNU General Public License=
 as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it will be useful, b=
ut
>>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=

>>> - * General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License=

>>> - * along with this program; if not, see <http://www.gnu.org/licenses=
/>.
>>> - * The full GNU General Public License is included in this distribut=
ion
>>> - * in the file called COPYING.
>>> - *
>>> - * BSD LICENSE
>>> - *
>>> - * Copyright (c) 2016 BayLibre, SAS.
>>> - * Author: Neil Armstrong <narmstrong@baylibre.com>
>>> - *
>>> - * Redistribution and use in source and binary forms, with or withou=
t
>>> - * modification, are permitted provided that the following condition=
s
>>> - * are met:
>>> - *
>>> - *   * Redistributions of source code must retain the above copyrigh=
t
>>> - *     notice, this list of conditions and the following disclaimer.=

>>> - *   * Redistributions in binary form must reproduce the above copyr=
ight
>>> - *     notice, this list of conditions and the following disclaimer =
in
>>> - *     the documentation and/or other materials provided with the
>>> - *     distribution.
>>> - *   * Neither the name of Intel Corporation nor the names of its
>>> - *     contributors may be used to endorse or promote products deriv=
ed
>>> - *     from this software without specific prior written permission.=

>>> - *
>>> - * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTO=
RS
>>> - * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT=

>>> - * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS=
 FOR
>>> - * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRI=
GHT
>>> - * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDEN=
TAL,
>>> - * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
>>> - * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF =
USE,
>>> - * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON=
 ANY
>>> - * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TO=
RT
>>> - * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE=
 USE
>>> - * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMA=
GE.
>>> - */
>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>>>  #include <linux/clk.h>
>>>  #include <linux/err.h>
>>>  #include <linux/io.h>
>> [..]
>>
>> Thanks,
>> Neil
>=20
> Best regards
> Marcus Folkesson
>=20

Thanks,
Neil


--Akfq4kJ0POMOaSnD9pn1Uka3HEHTfH41N--

--IzivREFwVUpZN1CVIM5lumn4LOmMqTANZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJai/jMAAoJEHfc29rIyEnRjGgQALc+fnjfkEQc+/1hF7OUT5wZ
ar+MXmewvuRL9J76k7bFvf/fG4g1N3MiB7XP+OSnSUBK7gfW2DnchCkwGhLHMD2D
iTf4oG/weAD/x18ECTk4Qz74LJYbhomQFs0VV2qrAI5MOBGfv0eUIV7VRFfFG8F9
dsRvbKI/O4iRSPXE3KMkZsBpxz3ci1gvR3N0L55kVefhb7X6hcW+DE0sEt9lXwC7
uZbCf1BiWfgjLDRZGRw12MLmpPpuZkMO5pygcCLrp578sIg0q33GjczL7nlhCL8i
G+z/zI4Ms0rz44axhShXF8QJjqi97AjOvB1uFWabkA391BXBd3U3mQ7YGSKpXsYu
5AOvUUmj/KUi0nRy+UAR8EU2/h1PkjPptzB+eBCVPJtHOA71JsXO43m9Kvk7+Svz
6mhyAjEDcM88KVzjQ247iq3t3tLTgmCNuVbOKuIzxD6/Jsv40Z0IsWZmjCT0HC0/
7tZd8iOLOLekos04uelYkfk6t+CP78tB7OQoaS7B0B8HHf86rm72ls7uTqh0WGnF
5/CDJIsD3vBhUoSomSmjk3l94GKZpHcszCPjf7Qmyr95WGFS9HTCFtRiToaQRRlp
fMMaZtfj/uxiDpWoXIDCkEL/tPHFR3M0pixJWBqaWOy0FjOdv84lgqR3EOqACjnT
7UgpDjilY+vFqPw4w5cA
=DVk1
-----END PGP SIGNATURE-----

--IzivREFwVUpZN1CVIM5lumn4LOmMqTANZ--
