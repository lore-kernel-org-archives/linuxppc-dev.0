Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Use of_get_next_child() in k2_sata_proc_info()
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1193202117.2085.45.camel@pasglop>
References: <2576ec47fb43bd1f4464beb8b78adfa70bdde418.1193199877.git.michael@ellerman.id.au>
	<1193202117.2085.45.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8yGg6xnxeP66hwuou9Av"
Date: Wed, 24 Oct 2007 15:31:25 +1000
Message-Id: <1193203885.8788.6.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8yGg6xnxeP66hwuou9Av
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Wed, 2007-10-24 at 15:01 +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2007-10-24 at 14:25 +1000, Michael Ellerman wrote:
> > k2_sata_proc_info() uses its own hand-rolled loop to check a nodes
> > children for a property, this is not safe WRT refcounting, so fix it
> > to use of_get_next_child().
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> (Pending you test boot it on one of our G5s first !)

As if I'd send untested patches !!

...

It just booted and seems happy.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8yGg6xnxeP66hwuou9Av
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHHtitdSjSd0sB4dIRAiLoAKDLs9VPbYwbPAS41gjet0BbSJlyDQCgjj4A
+vwKeRMJ2lbMEehAEe/wFW8=
=6HOs
-----END PGP SIGNATURE-----

--=-8yGg6xnxeP66hwuou9Av--
