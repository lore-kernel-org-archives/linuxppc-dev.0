Return-Path: <wsa@pengutronix.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1D3B0B712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 02:55:37 +1000 (EST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 92EBBDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 02:55:35 +1000 (EST)
Date: Thu, 11 Jun 2009 18:55:27 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc/mpc52xx/mtd: fix mtd-ram access for 16-bit
	Local Plus Bus
Message-ID: <20090611165527.GB28028@pengutronix.de>
References: <1244576781.3455.0@antares>
	<fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
In-Reply-To: <fa686aa40906110927w60a5a74alaa3420b9bf3f3e44@mail.gmail.com>
Cc: Albrecht =?iso-8859-1?Q?Dre=DF?= <albrecht.dress@arcor.de>,
	dwmw2@infradead.org, Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Blech.  ugly #ifdef and not really multiplatform safe (yeah, I know it
> shouldn't break non-5200 platforms, but it does have an undesirable
> impact).  There's got to be a better way.

What about putting the special memcpy in asm/io.h (like it is done for eeh)?
Will this cause too much overhead for a memcpy which does not go to the LPB?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoxNv8ACgkQD27XaX1/VRuNGwCePPWh1H//x17nDRbgFjteQ4yC
PYcAn37Obrlr1dM3eenWVDeBLOKh+4uj
=nqgx
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
