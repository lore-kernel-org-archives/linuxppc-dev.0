Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 05E1EB6FD0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Jun 2011 18:25:46 +1000 (EST)
Date: Wed, 22 Jun 2011 10:25:41 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/4] powerpc, mpc52xx: add a4m072 board support
Message-ID: <20110622082541.GB16605@pengutronix.de>
References: <1308729311-15375-1-git-send-email-hs@denx.de>
	<1308729311-15375-3-git-send-email-hs@denx.de>
	<20110622080959.GA16605@pengutronix.de> <4E01A43F.6030801@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
In-Reply-To: <4E01A43F.6030801@denx.de>
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


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> Grant? Do you have some comments on that patch?
> >=20
> > Can you use the mpc5200-include?
>=20
> Sorry, cannot parse this ...

Check other mpc5200-boards, like pcm030:

/include/ "mpc5200b.dtsi"

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk4BpwUACgkQD27XaX1/VRtwCACdH53bo72MpdlQDnxQeGRY63Yp
w8IAoI9plaDGwCO15CkJft0atB87myv8
=SDR5
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
