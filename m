Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D604DE0C3
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 16:23:03 +1000 (EST)
Subject: Re: [PATCH] Quieten arch/powerpc in a allmodconfig build.
From: Michael Ellerman <michael@ellerman.id.au>
To: Tony Breeds <tony@bakeyournoodle.com>
In-Reply-To: <20090408061352.GH16602@bilbo.ozlabs.org>
References: <2c4bcf8d1d7083ff53ce5b556765e96676a007fb.1239165378.git.tony@bakeyournoodle.com>
	<1239167335.10104.26.camel@localhost>
	<20090408055126.GG16602@bilbo.ozlabs.org>
	<20090408061352.GH16602@bilbo.ozlabs.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-5D2eJ+q77yhrdL89UKg6"
Date: Wed, 08 Apr 2009 16:23:02 +1000
Message-Id: <1239171783.10104.31.camel@localhost>
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


--=-5D2eJ+q77yhrdL89UKg6
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-08 at 16:13 +1000, Tony Breeds wrote:
> On Wed, Apr 08, 2009 at 03:51:26PM +1000, Tony Breeds wrote:
> =20
> > Hmm actually I think you're right.  I dont want to push my luck with th=
e gcc
> > hackers though
>=20
> Replying to myself.
>=20
> Yes this is a gcc bug but one introduced by CONFIG_TRACE_ALL_BRANCHES (or
> whatever that's called).

CONFIG_MAKE_MY_KERNEL_SUCK I think it is.

In that case I don't blame gcc.

If people want to use that option I think they can just deal with the
warnings, we can make -Werror depend on !CONFIG_PROFILE_ALL_BRANCHES.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-5D2eJ+q77yhrdL89UKg6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkncQsYACgkQdSjSd0sB4dKF2ACfZZknQJVnKt65XA3uXyKOABwX
3AkAoMfkDdMzcylmD4C357VmWnf+DTDV
=Yqur
-----END PGP SIGNATURE-----

--=-5D2eJ+q77yhrdL89UKg6--
