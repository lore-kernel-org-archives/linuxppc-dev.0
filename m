Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 10538B6F76
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Sep 2011 18:09:51 +1000 (EST)
Date: Fri, 2 Sep 2011 10:09:36 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/5200: enable audio in the defconfig
Message-ID: <20110902080936.GA1901@pengutronix.de>
References: <1314916282-13863-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
In-Reply-To: <1314916282-13863-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 01, 2011 at 05:31:22PM -0500, Timur Tabi wrote:
> Audio support for the MPC5200 exists, so enable it by default.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>

Yup, I like to have the PCM030 in a working state

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk5gj0AACgkQD27XaX1/VRvQCQCgsovymLVpV4agN0J9aP7ZJ0he
27wAniebaCu72i/bXjiKM/weiAWYtusJ
=uGFK
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
