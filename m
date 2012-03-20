Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C238DB6EEF
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 09:30:29 +1100 (EST)
Date: Tue, 20 Mar 2012 23:30:17 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: Please pull 'next' branch of 5xxx tree
Message-ID: <20120320223017.GB6292@pengutronix.de>
References: <20120320180450.5f6dffe4@wker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
In-Reply-To: <20120320180450.5f6dffe4@wker>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

>       powerpc/mpc52xx: setup port_config and CDM settings through DT

Can we skip this patch for 3.5? Between posting it and pushing it upstream =
were
about 24 hours, so one didn't have much chance of reviewing (and no linux-n=
ext
exposure).

I think the bindings leave space for questions, e.g. is it really desirable=
 to
have the fractional divide ratios encoded like in the bits in the register?=
 Why
not encode it like e.g. <11 11 11 11> (the actual divisor) or so? I could
imagine there are examples for setting dividers somewhere. Poking values in=
to
registers tends to be suspicious, so I'd vote for giving all this more
exposure.

Thanks,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAk9pBPkACgkQD27XaX1/VRviUACgrQoSghNH/jSKEf8XYV7kGVio
2z8AnRoO5xwtJRoq79D5aygSfu5pwN8u
=2G0r
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
