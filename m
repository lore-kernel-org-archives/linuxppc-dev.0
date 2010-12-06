Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 38B83B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 21:01:22 +1100 (EST)
Date: Mon, 6 Dec 2010 11:01:16 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/2] powerpc, 5200: add defconfig for charon board
Message-ID: <20101206100116.GB7320@pengutronix.de>
References: <1291450914-22485-1-git-send-email-hs@denx.de>
	<20101204211734.GD671@pengutronix.de> <4CFC911D.4070306@denx.de>
	<20101206094925.3dd90271@wker> <4CFCA91C.9030107@denx.de>
	<20101206093148.GA7320@pengutronix.de> <4CFCB195.8000306@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
In-Reply-To: <4CFCB195.8000306@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> Wolfram Sang wrote:
> > On Mon, Dec 06, 2010 at 10:13:00AM +0100, Heiko Schocher wrote:
> >> If such a file is accepted in mainline, I make a v2 post.
> >=20
> > =3D=3D=3D
> >=20
> > commit 0a0a5af30b9831e4f049610b5a2d9d5108ff027a
> > Author: Grant Likely <grant.likely@secretlab.ca>
> > Date:   Mon Jan 21 11:22:22 2008 -0700
> >=20
> >     [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards
> >    =20
> >     There is no reason to have separate defconfigs for each mpc5200 boa=
rd.
> >     Instead, here is a common defconfig that can be used for all suppor=
ted
> >     platforms.
> >    =20
> >     Merging the defconfigs means there are fewer configuration to test =
when
> >     compile testing all of arch/powerpc and should make support easier.
> >    =20
> >     Supported boards:
> >         Lite5200(b), Efika, TQM5200, CM5200, MotionPro
> >    =20
> >     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> >=20
> > =3D=3D=3D
> >=20
> > A defconfig which brings the board up is good enough. Specific projects=
 tend to
> > have specialized configs anyhow.
>=20
> Hmm.. applies this also to the DTS?

How should that work? :) There is one kernel with all needed options
(the optional ones being modules) and the DTS selects what is needed.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkz8tGwACgkQD27XaX1/VRum2wCfZi5oRfUzviyjUAf/IJSSrfSn
zioAn30u63QuBdDJ3GEfpFkP9tiTLjOu
=hGVz
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
