Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28576DDF08
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:09:16 +1000 (EST)
Subject: Re: [PATCH 1/5 v2] adb: replace sleep notifier with class
	suspend/resume hooks
From: Johannes Berg <johannes@sipsolutions.net>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175691839.2774.11.camel@shinybook.infradead.org>
References: <20070319181800.149901000@sipsolutions.net>
	<20070319183619.051498000@sipsolutions.net>
	<1174349717.3660.7.camel@johannes.berg>
	<1175676113.3556.2.camel@johannes.berg>
	<1175691839.2774.11.camel@shinybook.infradead.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8X9CFcJj0NX0HVqqoG4h"
Date: Wed, 04 Apr 2007 19:07:27 +0200
Message-Id: <1175706447.7388.13.camel@johannes.berg>
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


--=-8X9CFcJj0NX0HVqqoG4h
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-04-04 at 09:03 -0400, David Woodhouse wrote:

> I didn't have this set of patches applied. I have these:

Ok.

> Subject: [PATCH 1/3] rework pm_ops pm_disk_mode, kill misuse
> Subject: [PATCH 2/3] power management: remove firmware disk mode
> Subject: [PATCH 3/3] power management: implement pm_ops.valid for everybo=
dy
>=20
> Subject: [PATCH 1/5] powerpc: generic time suspend/resume code
> Subject: [PATCH 2/5] powerpc: fix suspend states again

Is that the version you have in the fedora CVS? Because that one seems
to be an older one that has a bug with set_context.

> Subject: [PATCH 3/5] powermac: disallow pmu sleep notifiers from aborting
> Subject: [PATCH 4/5 v2] powermac: proper sleep management
>=20
> It does re-probe ADB on resume, and it finds the keyboard every time
> (thankfully).=20

Interesting.

> It just doesn't find the mouse more than about 1 in 10
> times. Could it just be a timing thing? Resume seems to be a lot faster
> with the patches applied.

I have to admit that I have no idea, I don't have a machine with ADB in
it. I'll poke at the code a bit.

johannes

--=-8X9CFcJj0NX0HVqqoG4h
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGE9tP/ETPhpq3jKURAi2lAKCIW8t8KIOqq/K9PoWP90MGaMAxuACfYRqe
t6tmUw/K5dmmDl35GubbQ+8=
=covO
-----END PGP SIGNATURE-----

--=-8X9CFcJj0NX0HVqqoG4h--
