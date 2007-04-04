Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E18F5DDE3A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 18:42:40 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1174349717.3660.7.camel@johannes.berg>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-akAISGAfUd0U3N13tsfr"
Date: Wed, 04 Apr 2007 10:41:53 +0200
Message-Id: <1175676113.3556.2.camel@johannes.berg>
Mime-Version: 1.0
Cc: David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-akAISGAfUd0U3N13tsfr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> This patch replaces the pmu sleep notifier that adb had with a proper
> suspend/resume hooks in the adb class.

So class suspend/resume hooks are apparently not called unless you do
some more magic juju.

I'll work more sysfs foo to fix it. You can probably
make /sys/power/state work and have adb still work by just applying all
the patches up to "remove dead code in via-pmu86k".

Then again, which patches do you have applied now? Do you even have this
one? I only sent you the other ones, and if you only have those applied
then the problem must be elsewhere...

johannes

--=-akAISGAfUd0U3N13tsfr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGE2TR/ETPhpq3jKURApw/AKCN2Ldb9AJPOWZ/epx/U6//pbsEqACdHeil
YIz3khv7vacXjV+tzL4oMF4=
=E1rR
-----END PGP SIGNATURE-----

--=-akAISGAfUd0U3N13tsfr--
