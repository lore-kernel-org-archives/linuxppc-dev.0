Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 38013DE1B2
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 01:53:53 +1000 (EST)
Date: Wed, 20 May 2009 17:53:46 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc/pcm030.dts: add i2c eeprom and delete cruft
Message-ID: <20090520155346.GG29102@pengutronix.de>
References: <1242806865-2334-1-git-send-email-w.sang@pengutronix.de>
	<9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sLx0z+5FKKtIVDwd"
In-Reply-To: <9e4733910905200817w20a812bcy14481255fefd011f@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--sLx0z+5FKKtIVDwd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* FIXME: EEPROM */
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeprom@52 {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 compatibl=
e =3D "at24,24c32";
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg =3D <=
0x52>;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
>=20
> Grant suggested this earlier...
> 			eeprom@52 {
> 				compatible =3D "atmel,24c32", "eeprom";
> 				reg =3D <0x52>;
> 			};

Can you give me a pointer? I just found this thread

http://ozlabs.org/pipermail/devicetree-discuss/2008-July/000008.html

but not the result you proposed.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--sLx0z+5FKKtIVDwd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoUJ4oACgkQD27XaX1/VRsSbwCgo1o//DG1wjKGR7BY1lkRxOAi
8kIAoJghKuhKMNBDXUhA4sWj/vRfDoDV
=Bmoy
-----END PGP SIGNATURE-----

--sLx0z+5FKKtIVDwd--
