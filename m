Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 753E2B70A9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  6 Dec 2010 20:31:53 +1100 (EST)
Date: Mon, 6 Dec 2010 10:31:48 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH 2/2] powerpc, 5200: add defconfig for charon board
Message-ID: <20101206093148.GA7320@pengutronix.de>
References: <1291450914-22485-1-git-send-email-hs@denx.de>
	<20101204211734.GD671@pengutronix.de> <4CFC911D.4070306@denx.de>
	<20101206094925.3dd90271@wker> <4CFCA91C.9030107@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <4CFCA91C.9030107@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
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

On Mon, Dec 06, 2010 at 10:13:00AM +0100, Heiko Schocher wrote:
> If such a file is accepted in mainline, I make a v2 post.

=3D=3D=3D

commit 0a0a5af30b9831e4f049610b5a2d9d5108ff027a
Author: Grant Likely <grant.likely@secretlab.ca>
Date:   Mon Jan 21 11:22:22 2008 -0700

    [POWERPC] mpc5200: merge defconfigs for all mpc5200 boards
   =20
    There is no reason to have separate defconfigs for each mpc5200 board.
    Instead, here is a common defconfig that can be used for all supported
    platforms.
   =20
    Merging the defconfigs means there are fewer configuration to test when
    compile testing all of arch/powerpc and should make support easier.
   =20
    Supported boards:
        Lite5200(b), Efika, TQM5200, CM5200, MotionPro
   =20
    Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

=3D=3D=3D

A defconfig which brings the board up is good enough. Specific projects ten=
d to
have specialized configs anyhow.

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

iEYEARECAAYFAkz8rYQACgkQD27XaX1/VRtGIwCfVzk7WLVI1RCdiLaarYCTEHqa
kqYAn0EYrvy3JqYJhrrhDbrbhu+ltjLe
=Ix92
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
