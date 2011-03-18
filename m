Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AEEC7B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 19 Mar 2011 04:29:41 +1100 (EST)
Date: Fri, 18 Mar 2011 18:29:37 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Vladimir Ermakov <vooon341@gmail.com>
Subject: Re: [PATCH 2/4] serial: Add initial support for TWR-MPC5125
Message-ID: <20110318172937.GC26696@pengutronix.de>
References: <1300318427.12970.70.camel@desinto>
	<20110318125641.GD2155@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c3bfwLpm8qysLVxt"
In-Reply-To: <20110318125641.GD2155@pengutronix.de>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 18, 2011 at 01:56:41PM +0100, Wolfram Sang wrote:
> On Thu, Mar 17, 2011 at 02:33:47AM +0300, Vladimir Ermakov wrote:
> > Adds PSC UART support for MPC5125 SoC.
>=20
> Please resend the patches and make use of scripts/get_maintainer.pl

I guess you noticed by now, just to make sure: This patch also prevents hav=
ing
one kernel for mpc5121 and 5125. That should be handled before resubmitting.
The driver already has some register-abstractions, probably you can make us=
e of
it again.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk2DloEACgkQD27XaX1/VRtITwCdG1g/3Q8F52KLnFzYrY27dR8I
BFoAoLXkJQtyStaJhWiTHTwX9KgidZJs
=2Xv3
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
