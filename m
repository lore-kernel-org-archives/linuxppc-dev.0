Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2928FDDDF7
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2007 21:21:02 +1100 (EST)
Subject: Re: [RFC/PATCH 0/2] powerpc: 64 bits irqtrace / lockdep support
From: Johannes Berg <johannes@sipsolutions.net>
To: Tim Pepper <lnxninja@us.ibm.com>
In-Reply-To: <eada2a070711061136l18ac7651h85bf3da19a79b669@mail.gmail.com>
References: <1192433296.924212.737979117370.qpush@grosgo>
	<eada2a070711061136l18ac7651h85bf3da19a79b669@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-qrzV0vxRsiBVv57nNwDf"
Date: Wed, 07 Nov 2007 11:22:20 +0100
Message-Id: <1194430940.4055.14.camel@johannes.berg>
Mime-Version: 1.0
Cc: External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-qrzV0vxRsiBVv57nNwDf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On Tue, 2007-11-06 at 11:36 -0800, Tim Pepper wrote:
> On 10/14/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > This is 2 patches, one from Christoph Hellwig that adds the backtrace s=
upport,
> > and one from Johannes Berg modified by me that adds the irq tracing sup=
port.
> >
> > This successfully boots a POWER5 pSeries machine. I'm going to run some=
 more
> > tests in the upcoming few days, so this is not an official submission (=
and it's
> > too late for .24 merge window anyway) but it's looking good so far.
>=20
> FYI: Boots and survives watching /proc/lock_stat during a kernel build
> for me (on a 970 based blade).

Hmm. I should give it another try and see why it breaks for me. Could be
CONFIG_HIBERNATION related maybe.

johannes

--=-qrzV0vxRsiBVv57nNwDf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARzGR26Vg1VMiehFYAQKYZQ//crgj9tT4Udqq9qwIzvP3MgybE9WHgMg3
KEWeYRQVJFTYfXAoGRLFC2v1LB+4f65oea52+w/aCI2QH3Xb5Fu2XZNcnSykXvgN
s0TTjkOo4hH1K3otm2lweaZLMjm4wHFD+SSsPpBfsk01kAgyNa1bWbczYEDGG4Lk
AflnNzRjZhdeiu2eBaa9zmjtbW2t9jVxqH1S7d59ytkfv9qKciRLisV2LIU17hJX
bCpoW/j9oMXy1Q7byse+bVrTgntB0eqKHYNhi0wURdd3BRDZ7/oZj0HNJOJ7y+8Y
m2G5kTbZPldxqrPilb+qEYDwthcyE8KeA7hkwaj+HB/fWWoPTjBYyf3Si5Q+TRwb
xc3FOwjrhD0BUT1twonYTF3rKYiZS5u7jg7J8k07ePgZanhOTq0b9J0FP8JmUDAO
xVP4fYJ+w4uEj+Jl9vAVMDKuV3bN+bLlXOkz049LEXvcp23DOiUOBBTQLaqP7RlE
53KCMItVZYSZXzMqVwBj/9CIPnzvG9o8nxhoU2D7zJ/RnhqddKD2DwpGm1wtg5nT
swsaRPyu2X9yXA0oo8m8bDcZompGO+bQDVhKEXh9r0AIM811SZNZLDg6Yi4qYRTt
PvBQ2dvb9ma6Ohi7CpGu1/DBAbO9ha+OObf4G55NkQmWA6VysuqSrAsabbShL/jn
v7VZzTsv+Fo=
=Gv9y
-----END PGP SIGNATURE-----

--=-qrzV0vxRsiBVv57nNwDf--
