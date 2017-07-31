Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xLjvr4V69zDrLN
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Aug 2017 01:26:00 +1000 (AEST)
Date: Mon, 31 Jul 2017 17:19:57 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, Peter Rosin <peda@axentia.se>,
 linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] i2c: Convert to using %pOF instead of full_name
Message-ID: <20170731151957.jjq43coqlsql3v2x@ninjato>
References: <20170718214339.7774-26-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="djgytsdz3wtc2dzp"
In-Reply-To: <20170718214339.7774-26-robh@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--djgytsdz3wtc2dzp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 04:43:06PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: linux-i2c@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-arm-kernel@lists.infradead.org

Applied to for-next, thanks!


--djgytsdz3wtc2dzp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAll/Sp0ACgkQFA3kzBSg
KbYJJQ/+K+iyWbEUv/vHUQ1Yvs8XlbdXptbUdySw1CnyAWEFbl3BqWFUwELLX4mL
W07E53al1sfRi1XfhSgdbeQiEOueoDKg+Gmc2qSvpqaCwplh6Z6HNcH0iYr0aVqJ
OFKXXfjU0X2uF37LnXJ50nUJdlPaofNSW3ldLo8SB7NO+ptxDMdiHwuor/YU0HH6
voNvszqQP/4XE2degPMpzxNdU3YLmAkSiHjKCoJRv4nnAoKWBgX2HPvTJLCimYnQ
ipzpalDUEWqMHyySXnlbVN6YamzC54RrUy87iA84D0ynPm3Opo0um03k8XMEk0Wx
yA19e0s6npr50yuFLMO4icHcGd+Pt/54DZEfQnkwnxYSTp4WHZ7c++WKx5bRS9Jd
+YZ8g/wuG3tKUUYujPi56NijN2g9TtUeS2DX1BuDM/isJNuH1L0/CK1vTz/KKmoM
R65u9UKRmhXXewKpG5yEeL+zhyt7xRvNWqEnOdsggrPC7+CGnsPN5y0hoGglcSbW
4R0Vactq0icSBPmwnHp4HotDRQm4cNyxPqC+rUTzDsuFjUchk4Abdv6AH0oL3Ln5
WmGdhWPDqxoyftL6zwuoEkOXnch4lmJPMJHk1dInK7OtB9E/GjuMVEeqHOCCFxm2
6iRCVjiiTpjXfQjqcI7ualreNc/W4sOI7XVdH9ibzUPuWxKzgA4=
=bf8t
-----END PGP SIGNATURE-----

--djgytsdz3wtc2dzp--
