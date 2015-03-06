Return-Path: <broonie@sirena.org.uk>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [IPv6:2400:8900::f03c:91ff:fedb:4f4])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E69281A0358
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 22:44:23 +1100 (AEDT)
Date: Fri, 6 Mar 2015 11:44:13 +0000
From: Mark Brown <broonie@kernel.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Message-ID: <20150306114413.GM21293@sirena.org.uk>
References: <20150226161142.D08681A2360@localhost.localdomain>
 <20150303184403.GE21293@sirena.org.uk> <54F6BBA7.8040008@c-s.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vD4y4bEfw1HIZ0/n"
In-Reply-To: <54F6BBA7.8040008@c-s.fr>
Subject: Re: [PATCH] spi: fsl-spi: use of_iomap() to map parameter ram on CPM1
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--vD4y4bEfw1HIZ0/n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2015 at 09:00:39AM +0100, leroy christophe wrote:
> Le 03/03/2015 19:44, Mark Brown a =E9crit :

> >Why are we using of_iomap() rather than a generic I/O mapping function
> >here?

> because all drivers for powerpc seems to be using of_iomap(), as on power=
pc
> the HW is described by the bootloader in a OF device tree.
> Today, of_iomap() is at least used in FSL SPI, FSL UART, SPI mpc52xx, UART
> mpc52xx, i2c-mpc, i2c-cpm, freescale ethernet drivers, etc ....

> Is it not correct ?

It's legacy, all that code is really old.  Modern code is written in as
architecture and firmware neutral a fashion as possible to make things
more consistent and maintainable.

--vD4y4bEfw1HIZ0/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+ZMMAAoJECTWi3JdVIfQWQMH/3MVNDlfrLPulRblYC79s4Uz
VwiWD27cmZeSFvVHDlwYRDGN60H+NfO+re90iqjLExaI7tqh6zlPbzYRKJyBQCyT
xDKHLWxQbmcHDlKCxFdtHTqYzEAyoEvblKhG65LsNJE+2ved/HBT09wvAWXc8z0U
6A/Bkhz/wSD2i9fZ6Uqb/kZFNrdQrcWz+quIuxYgT4863HjQbF0sngQuokaZQuqe
kRt8zgIKaHOy9j/SG27K1ha8eF1Oix3izZYvw6syAqAXVXxsCQrJAbv4HLxCZ35z
hI//wa4yI2UxbjQj4bs8g5TSOQ42KyonOPP2u3h2yOsribESvy7ED27QXuDOwO8=
=svrt
-----END PGP SIGNATURE-----

--vD4y4bEfw1HIZ0/n--
