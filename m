Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E54AB7D40
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Mar 2010 02:27:35 +1100 (EST)
Date: Tue, 2 Mar 2010 16:27:30 +0100
From: Wolfram Sang <w.sang@pengutronix.de>
To: Albrecht =?utf-8?B?RHJl77+9?= <albrecht.dress@arcor.de>
Subject: Re: [Patch] mpc5200b: improve baud rate calculation (reach high
	baud rates, better accuracy)
Message-ID: <20100302152730.GA7979@pengutronix.de>
References: <20100302082858.GA4087@pengutronix.de>
	<14429243.1267517383754.JavaMail.ngmail@webmail14.arcor-online.net>
	<22132814.1267520208614.JavaMail.ngmail@webmail14.arcor-online.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
In-Reply-To: <22132814.1267520208614.JavaMail.ngmail@webmail14.arcor-online.net>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > > This should be handled using a new compatible-entry
> > > > "fsl,mpc5200b-psc-uart".
> > >=20
> >=20
> > > I agree that this would be a lot cleaner, but it's also a lot more
> > intrusive.
> > > CC'ing the device tree discussion list here... comments, please!!
> >=20
> > Why intrusive? Maybe I miss something?
>=20
> Not for the source file, but for all the dts files, if they want to benef=
it
> from the detection of the '5200B.  Basically, *all* files have to be chec=
ked
> and touched if necessary.  Again, I agree that this would be the clean
> approach, but I wanted to avoid that effort.  Grant???

Please check the current 5200b-dts files. They already have the property,
exactly for the case that a specific driver may be added in the future. And
even if not, the behaviour of the driver would not change by missing your
driver improvement, so there is also no regression.

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkuNLmIACgkQD27XaX1/VRtJsACgtfHXuyhBJfC0dfWpZqQXACxD
al4AmQEPlSy5sjD9X+Z1yx3OeiwK+iI4
=2n1J
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--
