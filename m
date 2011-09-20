Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E603B6F81
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 03:34:11 +1000 (EST)
Date: Tue, 20 Sep 2011 19:34:07 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] gpio: move mpc8xxx/512x gpio driver to drivers/gpio
Message-ID: <20110920173407.GD1915@pengutronix.de>
References: <1316539941-14092-1-git-send-email-w.sang@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
In-Reply-To: <1316539941-14092-1-git-send-email-w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 20, 2011 at 07:32:20PM +0200, Wolfram Sang wrote:
> Move the driver to the place where it is expected to be nowadays. Also
> rename its CONFIG-name to match the rest and adapt the defconfigs.
> Finally, move selection of REQUIRE_GPIOLIB or WANTS_OPTIONAL_GPIOLIB to
> the platforms, because this option is per-platform and not per-driver.
>=20
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
> I'd think this should go via ppc, so it is in sync with the defconfig upd=
ate of
> patch 2/2.

Forgot to mention: Both patches tested on a MPC5121-based board with
linux 3.1-rc6 (couldn't find an alternative location for ppc-next).

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk54zo8ACgkQD27XaX1/VRvBpQCbBzYqXIxn7VxEyuTm0PhAK80L
RfYAoMOtYRMYnx7QNjA643yLMaopk/+I
=mC4K
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
