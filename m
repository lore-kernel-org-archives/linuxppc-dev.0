Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EAF1CDDE27
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 12:58:48 +1100 (EST)
Subject: Re: Appletouch going wild
From: Johannes Berg <johannes@sipsolutions.net>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je640ba837.fsf@sykes.suse.de>
References: <je640ba837.fsf@sykes.suse.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-GQLSXg72xqmaAhsgxfJx"
Date: Sat, 10 Nov 2007 02:59:57 +0100
Message-Id: <1194659997.7258.25.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-GQLSXg72xqmaAhsgxfJx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Fri, 2007-11-09 at 13:58 +0100, Andreas Schwab wrote:
> Every once in a while the touchpad in my iBook G4 (geyser1, 030B) is
> going wild, emitting random movement events even when not being touched.
> That started only with 2.6.24-rc1.  The only way to stop it is to reload
> the appletouch module.  My guess would be that reinitializing the
> touchpad can result in some kind of race condition.

Is it the same in -rc2? The bad patch that broke fountains was fixed
later, but you do have a geyser. I see random movements once a while too
on my fountain touchpad but it's been a long time since I saw that last.
My guess would be that the reinit changes the zero levels and therefore
the zero levels are wrong, but I don't understand that part of the
driver too well.

johannes

--=-GQLSXg72xqmaAhsgxfJx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzUQnKVg1VMiehFYAQJCLxAAkuilQGV9QFfYFCQLZHGiNIjEp/Jy4SwA
IqsYxQ5DGKjSA2d/nYVL+JMFaD2xt67Vjsg2GmA8Vmq3Ry7fN9dhyTC3YZkPBRrv
0YiXu9KTeTrrz420ZomFBtLpQvFgE1eK7mNKlOhZe49Fz7RL+EXGA2iKzT2LdiJD
CUvZezSwpBp/VyS3sbKz0cT4LpGKdPokQJr/Jlb3mDc3NCYWEqn91pd/sXNEvGlP
ALEpvYGG8aPbNJs+BuBg+jK1RP/hjBtELJqNmsdYeAJXV+FwUxwmtl9PkVmPNgy0
tfxkGtFsFIil1tChL/UTSbzyJH9KcuIafL6j+a11uhRKQZ8Z7dIYWjA5ku3FRCF7
xGsA+UmdITzKvqYfJuWcXfTr7nH5MqVmf1mQQT5JuH3Kd+b9clDnUooeLbeut/ei
bXviqjbZwRfvQo27httqvrTIblGwxssRmqtiUGXl34XJt80jBT2bTqduSxag+WGl
SBQPsJFNBeYXUlXhEYqwkkhlgDJxfqgDKhr07AZgQBU4Bbq+9yzcg1FaILmEpNGG
I52Som9pqApAALEAWCpGKU1sSjuqrL+AJA9goN6fEaYxDah1asCxu8fepIGKKz4F
QphPJPEd0h1xdudwHoIqlDS/kZbhOVD6sKhwoxnF6BCoR8FwN91WCzRWPxnsoJRB
8Pf51vVTBMQ=
=1eEu
-----END PGP SIGNATURE-----

--=-GQLSXg72xqmaAhsgxfJx--
