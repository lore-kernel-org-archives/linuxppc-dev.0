Date: Wed, 10 May 2000 19:56:54 +0200
From: Bernhard Reiter <bernhard@intevation.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Lombard hard freeze (update: mem>64MB)
Message-ID: <20000510195654.C2892@cheops.usf.Uni-Osnabrueck.DE>
References: <20000510192813.B2162@cheops.usf.Uni-Osnabrueck.DE> <p04301800b53f4fdb650f@[134.114.64.236]>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Nae48J/T25AfBN4"
In-Reply-To: <p04301800b53f4fdb650f@[134.114.64.236]>; from Tim.Wojtulewicz@NAU.EDU on Wed, May 10, 2000 at 10:43:41AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--6Nae48J/T25AfBN4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2000 at 10:43:41AM -0700, Tim Wojtulewicz wrote:
> >It would so nice to have a person who can debug it.
> >I will test two things:
> >	Setting mem=3D64M and see if it makes it stable.
> >
> >	Maybe a development line kernel has some fixes for this stuff,
> >	I shall try one.
> >
> >Maybe we should ask for Lombard users which have a stable system
> >with more as 64MB memory. Can they do huge compiles?
> >Somebody should have a lombard the symptom and the guts to debug it.
> >
> >	Bernhard
>=20
> I've been paying attention to this thread for a while since I have a=20
> Pismo and mine is exhibiting the same problems that yours is.  I have=20
> 128M of RAM in mine (one stick).  This is memory straight from Apple.=20
> I also see kernel panics/lockups during large compiles.  I managed to=20
> make it through KDevelop 1.2, but it will ALWAYS die during XFree 4.0.

Uh if you really have the hard freeze with one simm that might point
into the kernel problem corner.

On the other hand the Pismo has different hardware and might have other
problems.

Thanks for helping us with your input.
	Bernhard

--6Nae48J/T25AfBN4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (SunOS)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjkZouYACgkQh9ag3dpKERZDzQCgj86dL7Zl/oKorvt5mdr59qjv
GSsAoIwxOd//MyLvQeigOInyk3d9mxCr
=suO4
-----END PGP SIGNATURE-----

--6Nae48J/T25AfBN4--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
