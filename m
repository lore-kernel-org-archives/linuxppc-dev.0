Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 382E2B6F6F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2011 20:48:15 +1100 (EST)
Date: Sun, 13 Nov 2011 10:48:00 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH] powerpc/p3060qds: Fix select of 'MPC8xxx_GPIO'
Message-ID: <20111113094800.GA18470@pengutronix.de>
References: <1321141830.20271.22.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
In-Reply-To: <1321141830.20271.22.camel@x61.thuisdomein>
Cc: linux-kernel@vger.kernel.org, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, Shengzhou Liu <Shengzhou.Liu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 13, 2011 at 12:50:30AM +0100, Paul Bolle wrote:
> The driver for the Freescale P3060 QDS got added by commit 96cc017c5b
> ("[...] Add support for P3060QDS board"). Its Kconfig entry selects
> MPC8xxx_GPIO. But at the time that driver got added MPC8xxx_GPIO was
> already renamed to GPIO_MPC8XXX, by commit c68308dd50c ("gpio: move
> mpc8xxx/512x gpio driver to drivers/gpio").
>=20
> So make this driver select GPIO_MPC8XXX.
>=20
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Thanks for catching this!

> 2) The config tools do not complain about selects that cannot be met
> because they concern a Kconfig symbol that doesn't even exist. Shouldn't
> they be made to complain in that case?

I'd think so.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6/klAACgkQD27XaX1/VRt5LwCgxo8vn3H8WKz9+5pEM0utFWh2
CVYAnA5FZG3qLAUHXjhTMp83Xi45S+Sl
=QaI6
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
