Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA2B2DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:25:08 +1100 (EST)
Subject: Re: [RFC 08/10] powerpc: dart iommu suspend
From: Johannes Berg <johannes@sipsolutions.net>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <1170726767.30959.30.camel@johannes.berg>
References: <20070205183026.989209000@sipsolutions.net>
	<20070205185838.029827000@sipsolutions.net>
	<20070206011949.GA15434@lixom.net>
	<1170726767.30959.30.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3WsPrBcdIIadqCoKjBUQ"
Date: Wed, 07 Feb 2007 13:22:13 +0100
Message-Id: <1170850933.6798.29.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.osdl.org,
	Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-3WsPrBcdIIadqCoKjBUQ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-02-06 at 02:52 +0100, Johannes Berg wrote:
> How's this? Needs to go along with the correct changes in the code that
> uses it, of course.
>=20
> I can't use a local void * as you suggested because it needs to be added
> to as an unsigned long, but I can use a local unsigned long.
>=20
> Not even compiled yet.

which showed, it didn't compile but I sorted it out, will resend.

johannes

--=-3WsPrBcdIIadqCoKjBUQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD4DBQBFycR1/ETPhpq3jKURAoMdAJj/GT6pf6UBnC+cdA9eG+ZobrCQAJ4mLVM5
JNq1eZ3rZi12R6+o87LaSw==
=9aJr
-----END PGP SIGNATURE-----

--=-3WsPrBcdIIadqCoKjBUQ--
