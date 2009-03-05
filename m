Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc/cell: Only build Axon MSI driver for IBM Cell
	Blades
From: Michael Ellerman <michael@ellerman.id.au>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20090305071356.GA9412@lixom.net>
References: <e9c405aaec255c2a3d34209fc35ae093fcae8efc.1236228043.git.michael@ellerman.id.au>
	<20090305071356.GA9412@lixom.net>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-K/SEB0cSmGAKwEQJJJjy"
Date: Fri, 06 Mar 2009 01:07:05 +1100
Message-Id: <1236262025.8325.12.camel@localhost>
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


--=-K/SEB0cSmGAKwEQJJJjy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-03-05 at 01:13 -0600, Olof Johansson wrote:
> On Thu, Mar 05, 2009 at 03:41:41PM +1100, Michael Ellerman wrote:
> > The hardware is only present on those machines, and the driver
> > depends on infrastructure which is selected by the Kconfig for
> > cell blades.
>=20
> Wouldn't it make more sense to make a separate (AXON_MSI) config option
> depend on PPC_IBM_CELL_BLADE?

Maybe, it would make the makefile cleaner, at the expense of a bit more
Kconfig. I'm not sure what people prefer, I guess I'm neutral and you're
voting for the latter, so I'll respin it that way :)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-K/SEB0cSmGAKwEQJJJjy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmv3IkACgkQdSjSd0sB4dKWggCguzOXhXwI5F/awr6XvMNEv/xD
mRoAnAzTFFCFpY3C3P6oR6Eq3znMqV58
=swXN
-----END PGP SIGNATURE-----

--=-K/SEB0cSmGAKwEQJJJjy--
