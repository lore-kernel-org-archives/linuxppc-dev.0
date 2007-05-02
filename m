Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 971D8DDF9F
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 00:03:26 +1000 (EST)
Subject: Re: [PATCH 1/5] powerpc: generic time suspend/resume code
From: Johannes Berg <johannes@sipsolutions.net>
To: michael@ellerman.id.au
In-Reply-To: <1178103995.14649.3.camel@concordia.ozlabs.ibm.com>
References: <20070319105352.771599000@sipsolutions.net>
	<20070319105357.964696000@sipsolutions.net>
	<1178082143.5296.9.camel@concordia.ozlabs.ibm.com>
	<1178094317.13233.42.camel@johannes.berg>
	<1178103995.14649.3.camel@concordia.ozlabs.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eGvbZCTMbG6yLQJ/4z6J"
Date: Wed, 02 May 2007 16:04:14 +0200
Message-Id: <1178114654.13233.58.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eGvbZCTMbG6yLQJ/4z6J
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-05-02 at 21:06 +1000, Michael Ellerman wrote:

> Ah sorry, I didn't mention prep_defconfig is arch/__ppc__.=20

Ahh, ok.

> See arch/ppc/Makefile:
>=20
> core-y                          +=3D arch/ppc/kernel/ arch/powerpc/kernel=
/ \
>                                    arch/ppc/platforms/ \
>                                    arch/ppc/mm/ arch/ppc/lib/ \
>                                    arch/ppc/syslib/ arch/powerpc/sysdev/ =
\
>                                    arch/powerpc/lib/
>=20
>=20
> So I guess we need to add the Kconfig fragment on arch/ppc also?

Yeah, but let me first see later today if I can go without rtc lib as
Paul has suggested.

johannes

--=-eGvbZCTMbG6yLQJ/4z6J
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGOJpe/ETPhpq3jKURAjYtAJ0ZQghBWKMSuG0B+0SpDjckA6TRhACfaANk
6s/8WVY7yetNpaDjm7EnILk=
=PFMb
-----END PGP SIGNATURE-----

--=-eGvbZCTMbG6yLQJ/4z6J--
