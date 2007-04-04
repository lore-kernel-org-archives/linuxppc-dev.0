Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34413DDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:08:39 +1000 (EST)
Subject: my powerbook fails to resume if backlight control is disabled
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VVXp4mfubfWJBO6+eUtr"
Date: Wed, 04 Apr 2007 17:20:40 +0200
Message-Id: <1175700040.3600.14.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-VVXp4mfubfWJBO6+eUtr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Can't really tell what's wrong, I had my kernel misconfigured
accidentally and was sitting on a train so I couldn't see if I could
still ssh in. However, it seems that the machine just froze, blindly
switching to vt 1 and rebooting didn't seem to work.

The thing is that I had turned off some options to the point where I
had /sys/class/backlight but nothing in it. I don't know for sure what
exactly these options were, but I do know that CONFIG_PMAC_BACKLIGHT and
CONFIG_PMAC_BACKLIGHT_LEGACY were off, though that alone shouldn't
cause /sys/class/backlight/radeonbl0 to disappear.

I haven't done any further tests so far.

johannes

--=-VVXp4mfubfWJBO6+eUtr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBGE8JI/ETPhpq3jKURAk/CAKCDEIQtLEtatORRuX8DH4tEqiarVgCggENX
jx0bkYhUqN0fB94KB4eq1eE=
=wGUw
-----END PGP SIGNATURE-----

--=-VVXp4mfubfWJBO6+eUtr--
