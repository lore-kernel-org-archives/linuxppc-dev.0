Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] scanlog_init cleanup, minor fixes
From: Michael Ellerman <michael@ellerman.id.au>
To: Nathan Lynch <ntl@pobox.com>
In-Reply-To: <20080326230959.GI7137@localdomain>
References: <20080323225144.GA7137@localdomain>
	<1206571210.7482.0.camel@concordia.ozlabs.ibm.com>
	<20080326230959.GI7137@localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-kAm38tDdMPS1Vpz0y0F2"
Date: Thu, 27 Mar 2008 10:21:28 +1100
Message-Id: <1206573688.7482.2.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kAm38tDdMPS1Vpz0y0F2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-03-26 at 18:09 -0500, Nathan Lynch wrote:
> Michael Ellerman wrote:
> > > +	/* Ideally we could allocate a buffer < 4G */
> > > +	data =3D kzalloc(RTAS_DATA_BUF_SIZE, GFP_KERNEL);
> > > +	if (!data)
> > > +		goto err;
> >=20
> > Not your bug, but what happens if data is > 4G? Kaboom?
>=20
> An old RPA doc (scan-log-dump isn't specified in PAPR) says the buffer
> should be "contiguous real storage", so... yeah, probably.  That's why
> I preserved the comment.  Will fix if I get access to a machine to
> test this code more thoroughly (plenty of other issues in this file,
> too).

Cool, no point changing it if we can't test it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-kAm38tDdMPS1Vpz0y0F2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH6tp4dSjSd0sB4dIRAvdWAJ42Jtr6pZMFEPVN6iReceQT3hciIgCfTFo/
zfn4Nt4t+skQmxL2DXgD+DY=
=f8Gs
-----END PGP SIGNATURE-----

--=-kAm38tDdMPS1Vpz0y0F2--
