Return-Path: <michael@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 24815B70C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Jun 2009 15:53:49 +1000 (EST)
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0BB9FDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jun 2009 15:53:49 +1000 (EST)
Subject: Re: sym scsi driver problem with 2.6.26 or newer debian kernel on
	p610 (fwd)
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1245799792.10356.42.camel@pasglop>
References: <Pine.LNX.4.64.0906141105050.4412@axis700.grange>
	<4A38B883.80507@ktk.bme.hu>  <4A3F4A77.6070704@ktk.bme.hu>
	<1245719890.4017.26.camel@pasglop> <1245724218.4017.35.camel@pasglop>
	<1245794228.10356.31.camel@pasglop> <1245799792.10356.42.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-UrNTdUiMKim5jMLoK0SG"
Date: Wed, 24 Jun 2009 15:53:46 +1000
Message-Id: <1245822826.9237.62.camel@concordia>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, blackluck@ktk.bme.hu
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-UrNTdUiMKim5jMLoK0SG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-06-24 at 09:29 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-06-24 at 07:57 +1000, Benjamin Herrenschmidt wrote:
> > > I tried on a POWER3 box I have here "IBM,7044-170" and things work fi=
ne
> > > here with current upstream. (I suspect a much smaller machine).
> > >=20
> > > I will really need an actual bisection here... In the meantime, I'll =
see
> > > if I can get my hand on one of these machines here.
> >=20
> > Ok so I think we may have found it... looks like
> > CONFIG_MPIC_BROKEN_REGREAD is what breaks it which is enabled by PA-Sem=
i
> > support in the .config.
> >=20
> > Can you verify that disabling PA-Semi support removes that option from
> > your .config and that once removed, it works again ?
> >=20
> > We don't know yet -why- it breaks it, still investigating.
>=20
> Do the following patch also fix it ?

Doesn't fix my machine :/

cheers


--=-UrNTdUiMKim5jMLoK0SG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpBv2oACgkQdSjSd0sB4dKlJwCgksWVwf3TosDh5Gszsrizk/BZ
9cMAoJFlq8jfuEmM53mWmGa221QhI/SG
=abD5
-----END PGP SIGNATURE-----

--=-UrNTdUiMKim5jMLoK0SG--
