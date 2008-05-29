Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 4/6] Add ppc_function_entry() which gets the entry
	point for a function
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1212043037.8888.48.camel@pasglop>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<95ea86b673d9f1093abe4a54bc4ecc34a4ebcfac.1212042061.git.michael@ellerman.id.au>
	<1212043037.8888.48.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-uUB5cvU52QWJVLkcFfpK"
Date: Thu, 29 May 2008 16:57:46 +1000
Message-Id: <1212044266.22344.9.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-uUB5cvU52QWJVLkcFfpK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-29 at 16:37 +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2008-05-29 at 16:20 +1000, Michael Ellerman wrote:
> > Because function pointers point to different things on 32-bit vs
> > 64-bit,
> > add a macro that deals with dereferencing the OPD on 64-bit. The soon
> > to
> > be merged ftrace wants this, as well as other code I am working on.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Should we be smarter and also compare if the TOC pointer is the same
> between the source and target and if not, warn loudly ?

> Or we just don't care ?

I think currently only the module loader worries about changing TOC
pointers, but perhaps we should think about it in other places too. What
do you do on 32-bit though?

Still, I think that would be a new separate macro, so this stands on its
own IMHO.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-uUB5cvU52QWJVLkcFfpK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIPlPqdSjSd0sB4dIRAnpxAKCB8NDlRDuTzO13o2YhiPgz+y/RhACgvVwd
0XEFH6EhEKmR5zss2PEdMcE=
=7tc0
-----END PGP SIGNATURE-----

--=-uUB5cvU52QWJVLkcFfpK--
