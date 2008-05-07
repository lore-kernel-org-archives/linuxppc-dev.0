Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] Add null pointer check to of_find_property
From: Michael Ellerman <michael@ellerman.id.au>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1210187999-20274-1-git-send-email-timur@freescale.com>
References: <1210187999-20274-1-git-send-email-timur@freescale.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NrN4b70tdlu2juG81O39"
Date: Thu, 08 May 2008 09:21:06 +1000
Message-Id: <1210202466.16180.1.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NrN4b70tdlu2juG81O39
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-05-07 at 14:19 -0500, Timur Tabi wrote:
> Update function of_find_property() to return NULL if the device_node pass=
ed
> to it is also NULL.  Otherwise, passing NULL will cause a null pointer
> dereference.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>=20
> This patch allows callers to do this:

np =3D of_find_compatible_node(...);
prop =3D of_get_property(np);
if (!prop)
     goto error;

...

error:
 of_node_put(np)

:)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NrN4b70tdlu2juG81O39
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIIjlidSjSd0sB4dIRApl1AJ9cQcCjMhA1CAGQ1nOskP1nNWTtAACfRStb
RFsC08sR+DomvhqBCykvr5k=
=QfkS
-----END PGP SIGNATURE-----

--=-NrN4b70tdlu2juG81O39--
