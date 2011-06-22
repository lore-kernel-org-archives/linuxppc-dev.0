Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E57AB6FC5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 18:10:13 +1000 (EST)
Date: Wed, 22 Jun 2011 10:09:59 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/4] powerpc, mpc52xx: add a4m072 board support
Message-ID: <20110622080959.GA16605@pengutronix.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
	<1308729311-15375-3-git-send-email-hs@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <1308729311-15375-3-git-send-email-hs@denx.de>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@lists.ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 22, 2011 at 09:55:09AM +0200, Heiko Schocher wrote:
> Signed-off-by: Heiko Schocher <hs@denx.de>
> cc: Grant Likely <grant.likely@secretlab.ca>
> cc: devicetree-discuss@ozlabs.org
> cc: Wolfgang Denk <wd@denx.de>
> ---
> For this patchseries following patch is needed:
>=20
> http://patchwork.ozlabs.org/patch/91919/
>=20
> Grant? Do you have some comments on that patch?

Can you use the mpc5200-include?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4Bo1cACgkQD27XaX1/VRsUJQCgkrL4qZKLnO+uL9Limm0ld1eZ
OuAAoJCn8hnvuEbZMqQjTgMkpk3+Q9a9
=OHiN
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
