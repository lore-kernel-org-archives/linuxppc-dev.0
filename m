Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Make IOMMU code safe for > 132 GB of memory
From: Michael Ellerman <michael@ellerman.id.au>
To: Jeremy Kerr <jk@ozlabs.org>
In-Reply-To: <200801221420.35565.jk@ozlabs.org>
References: <259a1d6aca476af7c572bdfea564a8a17aca3244.1200898886.git.michael@ellerman.id.au>
	<200801221420.35565.jk@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ovzJaA697UoD8BML+1/l"
Date: Tue, 22 Jan 2008 15:42:00 +1100
Message-Id: <1200976920.7841.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ovzJaA697UoD8BML+1/l
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-01-22 at 14:20 +1100, Jeremy Kerr wrote:
> > Currently the IOMMU code allocates one page for the segment table,
> > that isn't safe if we have more than 132 GB of RAM.
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Acked-by: Jeremy Kerr <jk@ozlabs.org>
>=20
> Can I have a Cell machine with > 132GB of RAM? :D

I have one under my desk, but I need it to warm my feet, otherwise I
could give it to you.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-ovzJaA697UoD8BML+1/l
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHlXQYdSjSd0sB4dIRAqCjAJ0X3kBoX4jeYYIEJ3rtLR9adNsbLgCfdQR3
LRzMZ6VLe9tNUuNAQmoOqWI=
=PgZ7
-----END PGP SIGNATURE-----

--=-ovzJaA697UoD8BML+1/l--
