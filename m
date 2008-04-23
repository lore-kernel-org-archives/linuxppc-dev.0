Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 04/11] Convert from DBG() to pr_debug() in
	platforms/pseries/setup.c
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20080422133120.GA8338@lixom.net>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
	<6112063f5eac0a820949415417d49a5376ad5ffd.1208505275.git.michael@ellerman.id.au>
	<20080422133120.GA8338@lixom.net>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8EJUoYeWeBFPH6gqEN9W"
Date: Wed, 23 Apr 2008 15:45:11 +1000
Message-Id: <1208929511.9212.10.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8EJUoYeWeBFPH6gqEN9W
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-04-22 at 08:31 -0500, Olof Johansson wrote:
> On Fri, Apr 18, 2008 at 05:54:36PM +1000, Michael Ellerman wrote:
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> I know it's fun to see yourself in the changeset statistics, but this is
> silly. Please bake together all the simple changes to one patch instead
> of one per file. They are all trivial.

Yeah that's totally what I was going for ...

Thanks for reading them at least, they're mostly trivial but many eyes
make light work.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8EJUoYeWeBFPH6gqEN9W
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDszndSjSd0sB4dIRAkeZAJ0XI+9hrg0SuIcxdaPDWMbYL9R0cwCfQicV
5M8aXffAY1oHdV0MEdBGzww=
=ARO0
-----END PGP SIGNATURE-----

--=-8EJUoYeWeBFPH6gqEN9W--
