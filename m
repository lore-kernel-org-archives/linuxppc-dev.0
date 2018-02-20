Return-Path: <marcus.folkesson@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zm1Tq28hvzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 00:21:14 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id t79so4145296lfe.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 05:21:14 -0800 (PST)
Date: Tue, 20 Feb 2018 14:21:03 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>,
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
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180220132103.GD24311@gmail.com>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MZf7D3rAEoQgPanC"
In-Reply-To: <20180220124955.GA17814@sophia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MZf7D3rAEoQgPanC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello William,

On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wrote:
> On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
> >- Add SPDX identifier
> >- Remove boiler plate license text
> >- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
> >  license
> >
> >Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >Acked-by: Michal Simek <michal.simek@xilinx.com>
> >---
> >
> >Notes:
> >    v2:
> >    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327=
_wdt
> >    	- Change to BSD-3-Clause for meson_gxbb_wdt
> >    v1: Please have an extra look at meson_gxbb_wdt.c
>=20
> [...]
>=20
> >diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384=
_wdt.c
> >index 2170b275ea01..c173b6f5c866 100644
> >--- a/drivers/watchdog/ebc-c384_wdt.c
> >+++ b/drivers/watchdog/ebc-c384_wdt.c
> >@@ -1,15 +1,8 @@
> >+// SPDX-License-Identifier: GPL-2.0
> > /*
> >  * Watchdog timer driver for the WinSystems EBC-C384
> >  * Copyright (C) 2016 William Breathitt Gray
> >  *
> >- * This program is free software; you can redistribute it and/or modify
> >- * it under the terms of the GNU General Public License, version 2, as
> >- * published by the Free Software Foundation.
> >- *
> >- * This program is distributed in the hope that it will be useful, but
> >- * WITHOUT ANY WARRANTY; without even the implied warranty of
> >- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> >- * General Public License for more details.
> >  */
> > #include <linux/device.h>
> > #include <linux/dmi.h>

Thank you for your feedback!
>=20
> I have no problem with adding a SPDX line to the top of this file, but
> use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
> with the selection of GPL version 2 only when I published this code.

SPDX-License-Identifier: GPL-2.0
Is GPL-2.0 only [1], so it respects your choice of license.

>=20
> Furthermore, please do not remove the existing copyright text; although

The copyright text:

 Copyright (C) 2016 William Breathitt Gray

Is still in the file.


> it's just boilerplate for some, I was careful with the selection of
> these words, and I worry the SPDX line only -- despite its useful
> conciseness -- may lead to misunderstandings about my intentioned
> license for this code.

I'm not sure I understand your concerns here, the SPDX identifier is
a shorthand for the GPL 2.0 only license. See [1] - Linux kernel licensing =
rules.

One of the biggest benefits with SPDX identifier is that it is hard to veri=
fy
boiler plate licenses due to formatting, types, different formulations and =
so on.

If still worrying, I think we could keep the license text as
well.

>=20
> For the time being, I can't Ack this patch with the changes it makes
> currently:
>=20
>         Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>=20
> William Breathitt Gray

Please let me know if I got you wrong at some point.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/license-rules.rst

Best regards
Marcus Folkesson

--MZf7D3rAEoQgPanC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqMILgACgkQiIBOb1ld
UjK9Ag//RFYuvmLZSH6GnP5gGk0/GBMTVPPr95tPUKj2LxlQrPBqoWqCdFXnuHf1
da0hos+DEBo8xaRPtbvitCeWo3m3MgCG4RTCU/HKqTinyis52XV95y3YXGrMT6T9
kH/hukr9/oIIlKpz5bAIR9vfwo2hd2M1KkBsc5hYhloWY83jbuYTAEUcmogipLAu
5pPJIHWig0yHga6nTaUxwhyVShgX0qSiYfHihliemt+9reU5jtLDeDc3u5UrGiTg
6E2GeQYv9mA07s9xzWdHTAoyUx3sMCwAJ65F6u4E89uiQjVr7KFz7HvlMJswnehn
xWqnN8L2fNNaUxxDrJ7aEwPy1dMbiVjxdOoIl9ivc4mDe+DpD6N0bxPEk6bj1hbR
pMLtfoBZHQZok1lzvQk8B0EPvnfOEJsntjsb09R6io+28dU+z1KlZwFHZ7PJ4g0l
lnb64yyNupUMsG7zRyAC8Hq5bJbFGf0aZMOHD/NuZul/2+k3cNuUJUVUqV2wndyk
VduFlrBiDRk9mjFPnqlsnOgFVteAROyineIzMEeOPio05wMQ7/KJRKLxxL8TZNmw
j6TtRSFPIZZTFmpR8Xu5Ezxm32qb/5umECl2WqPkauzEWL3erJxngioWLp2q7vTy
988Zz12kOcwGHl6N2F9FCbeoO4z8Bj9zSZMYezU/f3LR+SLaAy0=
=96Xu
-----END PGP SIGNATURE-----

--MZf7D3rAEoQgPanC--
