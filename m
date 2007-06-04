Return-Path: <michael@ellerman.id.au>
Subject: Re: 2.6.22-rc3-mm1
From: Michael Ellerman <michael@ellerman.id.au>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
In-Reply-To: <200706012321.16239.m.kozlowski@tuxland.pl>
References: <20070530235823.793f00d9.akpm@linux-foundation.org>
	<200706012250.58962.m.kozlowski@tuxland.pl>
	<20070601140211.81e5c301.akpm@linux-foundation.org>
	<200706012321.16239.m.kozlowski@tuxland.pl>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-s29vegfb92cUpcMYpO49"
Date: Mon, 04 Jun 2007 12:29:46 +1000
Message-Id: <1180924186.5476.3.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-s29vegfb92cUpcMYpO49
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-01 at 23:21 +0200, Mariusz Kozlowski wrote:
> BTW. This is 'make allnoconfig && make' result:
>=20
>   MODPOST vmlinux
> ln: accessing `arch/powerpc/boot/zImage': No such file or directory
> make[1]: *** [arch/powerpc/boot/zImage] Error 1
> make: *** [zImage] Error 2

If you check your .config I think you'll find you have none of the
powerpc platforms selected, which means you don't get a zImage. And your
kernel won't boot on any actual hardware either :)

Perhaps one of the platforms should be the default if nothing else is
selected, just so allnoconfig works.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-s29vegfb92cUpcMYpO49
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGY3kZdSjSd0sB4dIRApd8AKDMs7pzrdQWewpuN+wLloi2tfjBxwCghL24
EFuXT1dqappotzBlwd//r8Y=
=PNNd
-----END PGP SIGNATURE-----

--=-s29vegfb92cUpcMYpO49--
