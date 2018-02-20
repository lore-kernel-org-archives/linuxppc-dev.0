Return-Path: <marcus.folkesson@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com
 [IPv6:2a00:1450:4010:c07::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmDrt0zgKzF1BM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 08:53:33 +1100 (AEDT)
Received: by mail-lf0-x242.google.com with SMTP id g72so6363530lfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Feb 2018 13:53:33 -0800 (PST)
Date: Tue, 20 Feb 2018 19:45:22 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>,
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
Message-ID: <20180220184522.GF24311@gmail.com>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia> <20180220132103.GD24311@gmail.com>
 <48db897e-8a61-a5bc-5a61-56349cafaa10@roeck-us.net>
 <20180220153326.GE24311@gmail.com> <20180220181427.GA25467@sophia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
In-Reply-To: <20180220181427.GA25467@sophia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--OgApRN/oydYDdnYz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 01:14:27PM -0500, William Breathitt Gray wrote:
> On Tue, Feb 20, 2018 at 04:33:26PM +0100, Marcus Folkesson wrote:
> >On Tue, Feb 20, 2018 at 07:13:43AM -0800, Guenter Roeck wrote:
> >> On 02/20/2018 05:21 AM, Marcus Folkesson wrote:
> >> > Hello William,
> >> >=20
> >> > On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wro=
te:
> >> > > On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
> >> > > > - Add SPDX identifier
> >> > > > - Remove boiler plate license text
> >> > > > - If MODULE_LICENSE and boiler plate does not match, go for boil=
er plate
> >> > > >   license
> >> > > >=20
> >> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> >> > > > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> >> > > > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> >> > > > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
> >> > > > ---
> >> > > >=20
> >> > > > Notes:
> >> > > >     v2:
> >> > > >     	- Put back removed copyright texts for meson_gxbb_wdt and c=
oh901327_wdt
> >> > > >     	- Change to BSD-3-Clause for meson_gxbb_wdt
> >> > > >     v1: Please have an extra look at meson_gxbb_wdt.c
> >> > >=20
> >> > > [...]
> >> > >=20
> >> > > > diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/=
ebc-c384_wdt.c
> >> > > > index 2170b275ea01..c173b6f5c866 100644
> >> > > > --- a/drivers/watchdog/ebc-c384_wdt.c
> >> > > > +++ b/drivers/watchdog/ebc-c384_wdt.c
> >> > > > @@ -1,15 +1,8 @@
> >> > > > +// SPDX-License-Identifier: GPL-2.0
> >> > > > /*
> >> > > >   * Watchdog timer driver for the WinSystems EBC-C384
> >> > > >   * Copyright (C) 2016 William Breathitt Gray
> >> > > >   *
> >
> >The copyright is untouched?
> >
> >> > > > - * This program is free software; you can redistribute it and/o=
r modify
> >> > > > - * it under the terms of the GNU General Public License, versio=
n 2, as
> >> > > > - * published by the Free Software Foundation.
> >> > > > - *
> >> > > > - * This program is distributed in the hope that it will be usef=
ul, but
> >> > > > - * WITHOUT ANY WARRANTY; without even the implied warranty of
> >> > > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e GNU
> >> > > > - * General Public License for more details.
> >> > > >   */
> >> > > > #include <linux/device.h>
> >> > > > #include <linux/dmi.h>
> >> >=20
> >> > Thank you for your feedback!
> >> > >=20
> >> > > I have no problem with adding a SPDX line to the top of this file,=
 but
> >> > > use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentio=
nal
> >> > > with the selection of GPL version 2 only when I published this cod=
e.
> >> >=20
> >> > SPDX-License-Identifier: GPL-2.0
> >> > Is GPL-2.0 only [1], so it respects your choice of license.
>=20
> Ah, this should be fine then. :)
>=20

Good!

> >> >=20
> >> > >=20
> >> > > Furthermore, please do not remove the existing copyright text; alt=
hough
> >> >=20
> >>=20
> >> It is not a matter if you CAN keep a copyright. You MUST NOT remove a =
copyright.
> >> As long as you do, the series is
> >>=20
> >> Nacked-by: Guenter Roeck <linux@roeck-us.net>
> >>=20
> >> Guenter
> >
> >I'm sorry, I do not see where the copyright is removed unless you count
> >the license text as part of the copyright.
> >
> >Can you please point it out?
> >
> >>=20
> >> > The copyright text:
> >> >=20
> >> >   Copyright (C) 2016 William Breathitt Gray
> >> >=20
> >> > Is still in the file.
> >
> >^^^
> >
> >> >=20
> >> >=20
> >> > > it's just boilerplate for some, I was careful with the selection of
> >> > > these words, and I worry the SPDX line only -- despite its useful
> >> > > conciseness -- may lead to misunderstandings about my intentioned
> >> > > license for this code.
> >> >=20
> >> > I'm not sure I understand your concerns here, the SPDX identifier is
> >> > a shorthand for the GPL 2.0 only license. See [1] - Linux kernel lic=
ensing rules.
> >> >=20
> >> > One of the biggest benefits with SPDX identifier is that it is hard =
to verify
> >> > boiler plate licenses due to formatting, types, different formulatio=
ns and so on.
> >> >=20
> >> > If still worrying, I think we could keep the license text as
> >> > well.
>=20
> I'm sorry for the confusion, I should have wrote "license text" rather
> than "copyright text" in my previous message. I agree with the benefits

No problem at all.

> of utilizing the SPDX identifier, and I see the addition of the SPDX
> line as useful, but I would prefer the original license text remain as
> well.

Of course, I will keep the the original license intact for v3.
>=20
> William Breathitt Gray
>=20

Best regards
Marcus Folkesson

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlqMbL0ACgkQiIBOb1ld
UjJFERAAhuwiBVxCWQs5NKL67h+hidriNHH3ALoXrhBhYQiVIzKyIiNPCHkpf/4C
DmquQEuSbAWQoLN73scR5mBRF74ZTu2Oj+BFvu1KS/oj3xdMm0fWBSBkIhyPIFXp
9pjItNmj3OBhODRP472IRlUxDh9LRnNYL20cpwYpUAVQIrM8HHWDl6W6RH5SKXIf
CcU1L4Y1i7M5Ir+wuc9bhGPBcHtZopQT7MQh2I/gImWdLVfrPObTsk8KpByaZoCe
oWAeZSxJRldTPjL+2X8N7lyabRV/Xvrvg4mJUUFXUfjUY1guIae3xbEMI2Ko/Avu
W0zsXNuBy+37KmW4PTZpIEoK0aaN8vipUBcGmwHYXtTDFHATKxjTugw6+VK2Wpj7
vjnLUXOVTcZFdt+wWJd7rpHaRfUGhG3aBu+fi73AoAzQSSQM8X9blHgk4yJ4VDiv
dzS60EDoWoew3PprwJIo8ytO4SnMBIglBeuiaa+V9NORc5tczwkwUiH6aStr/KEa
+L5OiKgiIVIUU1hAlClazpwF/O6I7KH2RHqIM8oSr7SXas0viPy4IXnwDmwr3wBD
DPeBD79K+Txb+EnKC5D/Z9Wu769rwAZ2TYgMjTQWN8W5hgaXwkB6MJVcJKNmlaxQ
8TRf6C+lhOCazPIbV18ltcQFWBT35DnO2mGWa6lnArJrfBN2zVg=
=N61S
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
