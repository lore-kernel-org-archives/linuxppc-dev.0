Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B8C5A67A3F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 03:30:28 +1000 (EST)
Subject: Re: [RFC 01/12] snd-powermac: no longer handle anything with a
	layout-id property
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jey7vjiqwv.fsf@sykes.suse.de>
References: <20060607130909.584205000@sipsolutions.net>
	<20060607130910.156412000@sipsolutions.net>
	<jey7vjiqwv.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ROmvXrXBix9ymppYOuul"
Date: Tue, 27 Jun 2006 19:30:13 +0200
Message-Id: <1151429413.597.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	netstar@gatheringofgray.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ROmvXrXBix9ymppYOuul
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-06-26 at 22:49 +0200, Andreas Schwab wrote:

> Can we get snd-powermac back as long as snd-aoa is lacking all those
> features from snd-powermac?

I'll be fixing it next week after an exam on Friday, or if I don't go to
Nuremburg next week (4h hacking on train :) ) then the week after.

Until then, you can just revert that patch locally.

johannes

--=-ROmvXrXBix9ymppYOuul
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARKFrI6Vg1VMiehFYAQJxog/+Pr7qJ6PB6xahnCthT8ds+y+N1Qtdexro
GXoqgNcNUsXezbjl0sskH8Ch81s7PeAi4qogmhG8qAz0TDJ3Y5SVRhmNyPC4UCJa
lGvEDr6iDeviT0q1kF830rjKZA08BwKlyhpeJeZVFRoPitl9lCMjDYxIxpD8/GH0
ayceReiVU4PTmB7qKsBQelnwTRspetYAmnSxMZpwdaz1gcy0lpNs7JkyFvtY1zvi
it5nGv8/2HYCwyLSIwiPT9JXn62G6lQ1omT2mvfFm+k/RmMLTlIhM9DvumqE8Hm5
PRAouyzdxKdLyja1QeidS9g2tAAlrSCL6e5qVyFBP5sC6x6aFjUbgpnHwvMEZURQ
HqrAEP1y0QJY7Q7E5cXiFv945f3Syeyw5MlvfgX9XOrroOUhDS6K2wsiyjzcVSoi
YmMfcx0s68UsH0D/Nm6NC4iJ4vIBHhLp5SJ+lFcZMmd0vaRtXoAx1kWa2AITutTI
zWQOF73ffhOpL+k9oSTaOtD3uTnSPZNRXZ/Ac50ZcSsI7aNNo5MhDhJxHmGznOV3
ZxUDxIr1zWpt7a83gEawhg0T8PpbJDOxrcjl8pvQNDOLVzGa4AZdxn2JNkgvEUKg
YO1r2z4uQ3OPSaoaXPqv7AIWWqC3ikxmc9U9WjzJXA+fZLmyiVZIav0TpC2sm8rT
Nwc/tNZGRog=
=FxNC
-----END PGP SIGNATURE-----

--=-ROmvXrXBix9ymppYOuul--
