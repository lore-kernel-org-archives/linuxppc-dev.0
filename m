Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E94C3DDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 23:44:21 +1000 (EST)
Subject: Re: [PATCH] remove awacs dmasound
From: Johannes Berg <johannes@sipsolutions.net>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20070717133752.GC3801@stusta.de>
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
	<1184678911.27780.5.camel@johannes.berg>
	<20070717133752.GC3801@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-BSl2rYVTYP4oeVaYy/3E"
Date: Tue, 17 Jul 2007 15:43:00 +0200
Message-Id: <1184679780.27780.13.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-BSl2rYVTYP4oeVaYy/3E
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-07-17 at 15:37 +0200, Adrian Bunk wrote:

> >  sound/oss/dmasound/Kconfig           |   14=20
>=20
> That's not in your patch, most likely because it's already removed as=20
> scheduled.

Ah, good point, I just removed it manually from the patch knowing that
it was gone from the config.

> The option is already removed from the Kconfig file, and the code=20
> removal is scheduled for 2.6.24. I'll take care of this (I'll send
> a patch through Andrew).

Alright. It uses the sleep notifiers I wanted to remove so I didn't want
to leave it even if it's not selectable.

johannes

--=-BSl2rYVTYP4oeVaYy/3E
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGnMdk/ETPhpq3jKURAjb3AJwO6Fo7+LnwjWKmTyHN2cS1O5VRMwCfQWs+
Y5OopSvxkgZIUEghnllDUak=
=uqnA
-----END PGP SIGNATURE-----

--=-BSl2rYVTYP4oeVaYy/3E--
