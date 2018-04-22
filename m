Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40TPFL3ZKCzDqvH
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Apr 2018 19:20:06 +1000 (AEST)
Date: Sun, 22 Apr 2018 11:14:43 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Vinod Koul <vinod.koul@intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 kernel-janitors@vger.kernel.org,
 Ludovic Desroches <ludovic.desroches@microchip.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 07/61] dma: simplify getting .drvdata
Message-ID: <20180422091443.ryfdum5nhjc2b7qw@ninjato>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-8-wsa+renesas@sang-engineering.com>
 <20180422061733.GU6014@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6f5sacsuvgjsenls"
In-Reply-To: <20180422061733.GU6014@localhost>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6f5sacsuvgjsenls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 22, 2018 at 11:47:33AM +0530, Vinod Koul wrote:
> On Thu, Apr 19, 2018 at 04:05:37PM +0200, Wolfram Sang wrote:
> > We should get drvdata from struct device directly. Going via
> > platform_device is an unneeded step back and forth.
>=20
> Do you mind splitting this per driver please, that makes it easy to manage
> for me :)

No problem, done.


--6f5sacsuvgjsenls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrcUn8ACgkQFA3kzBSg
KbaGng//WtrP6nLPSP/nblFu9au/lhvSwqTePV4MjjB8spMOB7tG6nOJqt8Lc+Um
yc1h61Lnh3O/rIwu6R7785FF0yWG9cA1ALk7LOvB/80RbjBDM8X8lOHQ72gEONGs
1lFo5JqKi/FUsvCbu8OYQjgtzo5Y7YkOVw4yW6Q0H34FzaUwWQNz2d+/adjklEpj
6tfZrydqy9ell/nwp+0vCj+8TeqexpvgJOvGA2IPAizo8/0xQozcc7gjr5dfzn7j
fTgqP5cUMrscXRbl0tbZBp4csvPzKZQSgsuu4uu1YAlJGGZkXYARf732i0weVt6F
zkPKku38zY7uWoti9e5NfX8P6aVgXZpRc+0iuvs7phK0dI/BUQnlnNLztp2gKZRq
klo7ozG8EEoy+RdzgrEtfvahJPPrf0D8EtIqR3GsDiYKdnDCQenqB9IwuBtpnhji
IB3NODOOxrCgRvzKM5hUj2lRm3bP4I56SVt+TOQNO7x09ejO2b6lC5Iz2rxqxVHh
WqIoCjAj1xICqojQLw9Oo7Ow+6PMvMjwqyI2s194LJ8u+R2yPnTy3DVTohZczuw6
V26zfaxwGQj3sKJ+fDpvwBB4gQ/omcglJVAOrSb0oZXsuiV6jpEQ0xlUh0dTDlUB
a3md/tXGaYBLn34WOcFKJbwXeOVPVsu/MQIKI6HJUUwBS+BoO9k=
=hOmb
-----END PGP SIGNATURE-----

--6f5sacsuvgjsenls--
