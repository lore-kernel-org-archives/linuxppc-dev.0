Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 12D45DE160
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 06:01:44 +1000 (EST)
Date: Wed, 20 May 2009 22:01:35 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: Weird 5200/mtd-ram problem
Message-ID: <20090520200135.GB13287@pengutronix.de>
References: <14558983.1242828785546.JavaMail.ngmail@webmail10.arcor-online.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
In-Reply-To: <14558983.1242828785546.JavaMail.ngmail@webmail10.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> For the test I created a "pattern file" which is filled with the unsigned
> long 0x0055aaff.  Using the Abatron BDI3000, I can write the pattern file=
 to
> the ram and re-read it without problems.  The same applies to u-boot (wri=
te
> ram via tftp, dump contents).

Does it work with byte, word and long accesses?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoUYZ8ACgkQD27XaX1/VRt/dQCcD0wyOdUtHH8aMt8PfZs3o0nc
JYoAnA3vzRKD4MisdgiIuTDL4DUbDoaR
=HbjS
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
