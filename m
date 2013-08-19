Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E28DA2C0148
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 07:16:29 +1000 (EST)
Date: Mon, 19 Aug 2013 23:16:20 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH RESEND] i2c: move of helpers into the core
Message-ID: <20130819211620.GA13092@katana>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
 <20130819194603.GC4961@mithrandir>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
In-Reply-To: <20130819194603.GC4961@mithrandir>
Cc: devicetree@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com,
 linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 09:46:04PM +0200, Thierry Reding wrote:
> On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
> [...]
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> [...]
> > +#if IS_ENABLED(CONFIG_OF)
> > +static void of_i2c_register_devices(struct i2c_adapter *adap)
> > +{
> [...]
> > +}
> [...]
> > +#endif /* CONFIG_OF */
>=20
> Isn't this missing the dummy implementation for !OF.

Argh, will fix...


--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEoskAAoJEBQN5MwUoCm2s7wP/jg4ety3vt8GoDAxMBSl1yyE
Aesg6uS/yOz/Rx2wXZTa6+fK//TyAJNz1zNNtuUQHx/UCtu7hxxzwFy9WQDS+Zt9
lXi1Up78t5dkVIUQU6UWYUVukjhBOxvluwAC9qC39sz571GGYN8QHWf5Y6XDV1Qx
IFertp0mZIje9ZafP/Rsr9uhB/0plyB316sv6/KWk7RI6VSDNXMVU6mhk5WqhIr5
gCMf2RQcUHWSPpTVylgfAspl4NCEBkbUrn9vFFOZ84r2njQ/2BlrBO9fPkDAaa3L
Ha+x6YJi5mhnGnoB93Eq0DWgQub6rHVGS6l9YEbkpY2+pcwwSIppZJlqZOMrr43h
5dZ2dv3nybYzzK1KILz3F92Dm6JUQsQyFwyb7Jn0h8afVkSra2ULG9BiqEHC4sRV
i0NAySXCCMLIdOqAOkQd06SDATZKMmQUPJMd1rVt96gT2cXDUY+bsnNjVQy/3Inb
gFZbChI8vzwwcZQtLqVW4ndCLRaR4942wREo0ZYoJ2vwtlW2dVsoLZfDc5CmmC5i
l+sDFbEUJvZ90y5idr9ZOY8F3N99BGk36ZjmDlPdp7PkzepMayaznRAysSPnRk45
IA/7kr2nwvGnXwMtdhkfSJ0xVqzpMoBVvSzFUWNih8JhwhltDzYvIeIDNLmoIl7s
Wv3iOYPn/bIrssEVlN9d
=fivW
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
