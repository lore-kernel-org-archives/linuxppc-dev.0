Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C22BA474C3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 03:10:34 +1100 (EST)
Subject: Re: [PATCH] powerpc: Specify GPIO number base for controller in DT
From: Wolfgang Ocker <weo@reccoware.de>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4900EE0F.3090105@genesi-usa.com>
References: <1224764850.4082.54.camel@galileo.recco.de>
	<5535CAC8-11C4-4262-9B18-5F6416A51DE3@kernel.crashing.org>
	<4900EE0F.3090105@genesi-usa.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-9w//7usHrRpFUj+VAyNL"
Date: Fri, 24 Oct 2008 18:10:19 +0200
Message-Id: <1224864619.4355.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-9w//7usHrRpFUj+VAyNL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-10-23 at 16:35 -0500, Matt Sealey wrote:
> > On Oct 23, 2008, at 7:27 AM, Wolfgang Ocker wrote:=20
> >> The GPIOLIB allows the specification of a base gpio number for a
> >> controller. That is not possible using OF. Instead, free gpio numbers
> >> are assigned.
> >>
> >> In order to allow static, predefined gpio numbers, a base property in
> >> the gpio controller node specifies the first gpio number.
>=20
> See my latest mail.
>=20
> I don't think it's enough to say which pin the GPIOs exposed=20
> start at; you need some sort of mask, or array of applicable=20
> GPIOs so that GPIOLIB can check which perhaps 3 pins out of a=20
> possible 32 are allocated to a controller and usable (these=20
> may be pin 5, pin 9 and pin 20, so a "base" of pin 5 would be=20
> outrageously inadequate).

I'm not sure what you mean. That "base" is used in gpiochip_add() when
registering the gpio controller. There is no magic with a mask or so.

What do I miss?

Thanks,
Wolfgang

--=-9w//7usHrRpFUj+VAyNL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBJAfNrfNTKEAPl+KoRAiwyAJ4+kVpFOA/zgnjqKiJ8+//SvTOOPwCfYJ+l
Zzxyo3wWB5ghGBp9n5yz3Kk=
=wSgM
-----END PGP SIGNATURE-----

--=-9w//7usHrRpFUj+VAyNL--
