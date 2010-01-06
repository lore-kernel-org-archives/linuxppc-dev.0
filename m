Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2B9AFB6F01
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 07:17:41 +1100 (EST)
Date: Wed, 6 Jan 2010 21:17:33 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH 0/2] Create an of_i2c_gpiochip_add()
Message-ID: <20100106201733.GA17857@pengutronix.de>
References: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
	<4B44ED99.3020706@billgatliff.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
In-Reply-To: <4B44ED99.3020706@billgatliff.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Does the lack of response mean I'll be seeing these in an upcoming
> kernel release?  I'd like to, because then I could more easily push

As long as nobody said "I picked it up", it will probably not. Patches
regarding GPIO sometimes need a bit of time. Also, of_platform was in the
discussion of being removed, this might complicate things, too.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktE790ACgkQD27XaX1/VRtcCgCfYYIyNp9l0GOSZ+TW1Q3aafm5
uDgAnRAj9UHaovca3JNgmyYmmU2GiOV2
=5mVR
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
