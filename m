Return-Path: <albrecht.dress@arcor.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B0105B7136
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 03:19:18 +1000 (EST)
Date: Tue, 16 Jun 2009 19:19:06 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH V2 2/2] mtd/maps/mtd-ram: add an of-platform driver
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40906160553m2f0e7cc4n644c3893573845f@mail.gmail.com>
	(from grant.likely@secretlab.ca on Tue Jun 16 14:53:17 2009)
Message-Id: <1245172753.3400.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-3vEv1y6AYteInxT4S5bC"
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=-3vEv1y6AYteInxT4S5bC
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 16.06.09 14:53 schrieb(en) Grant Likely:
> I'm not happy about the use case though.  It probably shouldn't =20
> appear in this binding, or if it does it should be tagged as an =20
> optional property.

I agree with you that the naming is really misleading - other devices =20
which are not mtd's may suffer from the same problem of the lpb (in my =20
case, I have an extra memory-mapped Ethernet chip which I didn't try to =20
access yet...).

As it is actually a chip select property, what about defining an =20
optional property like "cs-width =3D (8|16|32)" which defaults to 8 and =20
may be added to each 5200 lpb child?

> It is only in the 5200 localplus case that bank-width is needed to =20
> figure out how to apply the workaround.

Just out of curiosity: what about the "localbus" of other Freescale =20
chips (82xx? 83xx? Maybe others?)?

Thanks, Albrecht.

--=-3vEv1y6AYteInxT4S5bC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKN9QRn/9unNAn/9ERAgcZAKCDBRHS+2sgGwIwB2vjxbbyuycbjwCfQBnb
016afTZRn4vmVMeRgCX/P/Y=
=RUF4
-----END PGP SIGNATURE-----

--=-3vEv1y6AYteInxT4S5bC--
