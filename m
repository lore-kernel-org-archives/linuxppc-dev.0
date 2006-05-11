Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7BEBA679E1
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 21:59:11 +1000 (EST)
Subject: Re: Alubook 5,8: No sound with 2.6.17-rc3-g5528e568-dirty
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1147304824.32448.82.camel@localhost.localdomain>
References: <20060510154930.GD3878@localhost>
	<2829.131.234.104.112.1147277053.squirrel@secure.sipsolutions.net>
	<1147304824.32448.82.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-y6i+8m5kueLoyHdpYUr5"
Date: Thu, 11 May 2006 13:58:22 +0200
Message-Id: <1147348702.9630.7.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-y6i+8m5kueLoyHdpYUr5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-11 at 09:47 +1000, Benjamin Herrenschmidt wrote:

> Same as mine, it works fine with snd-aoa

I should build a database with a machine string -> user* mapping... This
means that even my brother has this one and it works great with snd-aoa
as far as I know :)

Though, since the alsa userspace libs absolutely *SUCK* no program I
know of can properly represent the mixer controls except maybe amixer...
I'd hate to work around this in the kernel, but the alsa libs are such
complex beasts that I have a feeling they won't be fixed.

Anyone up to inventing a new mixer API that uses sysfs? ;)

johannes

--=-y6i+8m5kueLoyHdpYUr5
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARGMm3KVg1VMiehFYAQJM0BAAqt/YmdASobeXi3A5FMpbo4/cpJslmh7j
mV/OkEsvX41Or0mgwSELbsBMIisXxOoTyjVAPqa1j+ic5HCCfuOzP6zmdzMnAb8g
746Eir7BFB38Rbeju2oXMkluSwduI4lQY0r00QKEzaJRviAqkd/IEyAH6Ghy8r/p
WUHRn9eAc8f7NebJ5KArssGZT9fjqNss6DuXhRFOqC7Fsas9FtyP4fTC3zB/ybRs
U7GSPoykcpFihnro36zi1Jt3YGxfkNojXsf0+sVK9Jb6Qu7Eq3eQyP/uPngShMdu
L+UOMM4uQYKagDnOR1/GrnFv4C1Qv/0iqXH3sWh7dGig8vUgnpIr85NHDg3KqUOE
kY/OYxnLmRpOo8wZm5/nmQN/dkFdRsBlun/4pbw+B3AbKf4UXgVDnK2odl9FHzu8
7Bqis/EvLbFu5uWC5a+YcpPyk/cERwCFSztVocqveMgdeH2lc9zqYBAnXfMGfaLH
vwP1N8SGzzpfZw2BaUBuAA1yKtx9kaQNtod8XVJwJzM5MC34Q1AIyfJ5YHYhD2Wl
3Ff0wi/h92soU97o/GuvnMn79TtT2xZWr/ivR5lpdUXNAaV+n7YlNzGUgMRZnQYM
O+jbkQqXOLedNnRihhL+iN19wfr46zMXcJ+0QTQUabmBgTztMgriyw1++JUUKpaF
w0Y7zcamO1Q=
=F1vo
-----END PGP SIGNATURE-----

--=-y6i+8m5kueLoyHdpYUr5--
