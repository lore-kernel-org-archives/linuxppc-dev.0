Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33CB4B70A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Dec 2010 21:39:24 +1100 (EST)
Date: Thu, 9 Dec 2010 11:39:17 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH v2] powerpc, 5200: add support for charon board
Message-ID: <20101209103917.GA3383@pengutronix.de>
References: <1291450906-22445-1-git-send-email-hs@denx.de>
	<1291705135-26805-1-git-send-email-hs@denx.de>
	<20101208154911.GE4641@pengutronix.de> <4D007AA8.9050101@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <4D007AA8.9050101@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Is it possible to add to the mpc5200_defconfig, what is needed for
> this board to compile a kernel which contains all features it needs?

Just add it as modules.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk0AsdUACgkQD27XaX1/VRtbjwCcCeiNdREcPo4mq1WDjf3kPyJn
y1oAn0rtg42Wzp8/MVoR5WNBAbml+foB
=KPU5
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
