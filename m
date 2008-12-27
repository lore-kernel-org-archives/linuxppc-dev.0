Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 652E7DDE0A
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Dec 2008 08:37:01 +1100 (EST)
Date: Sun, 28 Dec 2008 08:36:55 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v5] spi: Add PPC4xx SPI driver
Message-Id: <20081228083655.0a59d6de.sfr@canb.auug.org.au>
In-Reply-To: <200812271132.25468.david-b@pacbell.net>
References: <1227628088-10849-1-git-send-email-sr@denx.de>
	<200812271132.25468.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Sun__28_Dec_2008_08_36_55_+1100_8E=Qtt2W.Yy1GNTk"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Sun__28_Dec_2008_08_36_55_+1100_8E=Qtt2W.Yy1GNTk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David, Stefan,

On Sat, 27 Dec 2008 11:32:25 -0800 David Brownell <david-b@pacbell.net> wro=
te:
>
> Also:
>=20
> > +static struct of_platform_driver spi_ppc4xx_of_driver =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.owner =3D THIS_MODULE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D DRIVER_NAME,
>=20
> I'd hope the PPC folk eliminate this duplication soonish.
> Those fields are obvious duplicates of the driver model
> fields...

We are on the path (have been for some time).  Only the driver model
versions should be filled in for new drivers.  For old drivers we copy
the values into the driver model fields if they are not already set.  We
intend to remove the of_platform_drivers versions of "name" and "owner"
soon.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.match_table =3D spi_ppc4xx_=
of_match,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.probe =3D spi_ppc4xx_of_pro=
be,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.remove =3D __exit_p(spi_ppc=
4xx_of_remove),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0.driver =3D {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.name =3D DRIVER_NAME,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0.owner =3D THIS_MODULE,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > +};
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Sun__28_Dec_2008_08_36_55_+1100_8E=Qtt2W.Yy1GNTk
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklWn/cACgkQjjKRsyhoI8yTdQCfUK7NBTDokfdB2EZSBr5SIoss
GygAnjsmRvhyCNyN9k3FFAKx6NdbDXBa
=A0Pt
-----END PGP SIGNATURE-----

--Signature=_Sun__28_Dec_2008_08_36_55_+1100_8E=Qtt2W.Yy1GNTk--
