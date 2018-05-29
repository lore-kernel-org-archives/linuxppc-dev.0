Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [88.99.104.3])
 by lists.ozlabs.org (Postfix) with ESMTP id 40wMkl4r4FzDr43
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 May 2018 04:31:41 +1000 (AEST)
Date: Tue, 29 May 2018 20:31:38 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Brendan Higgins <brendanhiggins@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
 Guenter Roeck <linux@roeck-us.net>,
 Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Peter Korsgaard <jacmet@sunsite.dk>, Andy Gross <andy.gross@linaro.org>,
 David Brown <david.brown@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-i2c@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] i2c: algos: make use of i2c_8bit_addr_from_msg
Message-ID: <20180529183137.vsl7cuh2zjlplzfj@ninjato>
References: <20180516071647.29277-1-peda@axentia.se>
 <20180516071647.29277-2-peda@axentia.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5jxqd6gx2jsy35an"
In-Reply-To: <20180516071647.29277-2-peda@axentia.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5jxqd6gx2jsy35an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 09:16:46AM +0200, Peter Rosin wrote:
> Because it looks neater.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>

Applied to for-next, thanks!


--5jxqd6gx2jsy35an
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlsNnIkACgkQFA3kzBSg
KbZsGg/+ONTuHz2aI66jHvuwKWxiAcRBdlIiawe6gDudTXDr9Uwt9fFXc0YJXxkx
xB0lnDjcjY/pNi792W0ejqt5G1pGGyPnffD4/MtOS8yH7NewKy/JTurGn3QjvoH6
qz58+Vmt9sXJkwt2mYOm66euOxRw7DzSJfd/BEovH+lJ2V3bMe9H9AMkns6/buti
H6t6HGZz0C/Y4G7zhSfmJQJ6K8F1Ak0Swbc4Jc5cvhE+/7K+slKJ8hsbi3Bh9/VG
2UFwIHW6h3ICBt0xDAhzeH+/tPyGXNyzSph2QCOAnli7nER72sc7hWyIlL6wymJD
nQq8gfqRJa95mBiIt1BoeMUAO3sR1qzDMdx9j0dEAk868U2/P9AEYHEOw0/L0jU1
mjypB7RXFg/2aBTiGaqIJL+Nr7a3uYcpk/KqZjmaN3wibZc8MJwE5gio14rPf09F
akvxCLzRslRKJjG0AdoO3xJZHtYGsPqOKUjrj3t9clhGfuUZnfCepft3xwirIu7p
8AqGeJB5DWNssIIlzb+2I9243RmV2808BfFB8JBzgHP+AbJ8yCDBfJCj0BqPaGqj
c/qAYFvPPKwb7qmLNsHLoErqH/2OjqAiOHlHckc3s1/eQNR+XpVD1L37jTROUBNq
2KI58ADi8/UcUCM6Y5JDyM/G7X6xC+q6oWUmRffSmWkmcoZITVk=
=y2Wp
-----END PGP SIGNATURE-----

--5jxqd6gx2jsy35an--
