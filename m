Return-Path: <albrecht.dress@arcor.de>
Received: from smtp3.netcologne.de (smtp3.netcologne.de [194.8.194.66])
	by ozlabs.org (Postfix) with ESMTP id DC00FDDE01
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 04:35:36 +1000 (EST)
Date: Wed, 03 Jun 2009 20:35:26 +0200
From: Albrecht =?iso-8859-1?b?RHJl3w==?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH] powerpc: tiny memcpy_(to|from)io optimisation
To: Kenneth Johansson <kenneth@southpole.se>
References: <1243968361.4951.0@antares> <1243983086.27194.7.camel@pasglop>
	<1244039796.20864.48.camel@localhost.localdomain>
In-Reply-To: <1244039796.20864.48.camel@localhost.localdomain> (from
	kenneth@southpole.se on Wed Jun  3 16:36:36 2009)
Message-Id: <1244054133.3367.0@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	protocol="application/pgp-signature"; boundary="=-jQo4Z5PnWfYq5B0ywsKn"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--=-jQo4Z5PnWfYq5B0ywsKn
Content-Type: text/plain; charset=us-ascii; DelSp=Yes; Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 03.06.09 16:36 schrieb(en) Kenneth Johansson:
> On an e300 core using the lwzu/stwu is about 20% faster so at least =20
> one core prefer that optimization.

Bingo.  The '5200 on my test system has that core.  So "-mcpu=3D603e" =20
should select this strategy!

Cheers, Albrecht.


--=-jQo4Z5PnWfYq5B0ywsKn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iD8DBQBKJsJ1n/9unNAn/9ERAl+WAJ9N5bJav9AmNwSQ79O1g+WHCmKyXwCgyshy
OOZ5um6MIcquF8sz30L3bAs=
=TjH/
-----END PGP SIGNATURE-----

--=-jQo4Z5PnWfYq5B0ywsKn--
