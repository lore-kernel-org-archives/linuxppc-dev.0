Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86D5A67CF0
	for <linuxppc-dev@ozlabs.org>; Wed, 24 May 2006 19:44:06 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148422544.13249.96.camel@localhost.localdomain>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
	<1148169389.13249.44.camel@localhost.localdomain>
	<1148280172.6228.79.camel@johannes.berg>
	<1148422544.13249.96.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-jozGK26R0akBOjwmasOX"
Date: Wed, 24 May 2006 11:42:57 +0200
Message-Id: <1148463777.11734.19.camel@johannes>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-jozGK26R0akBOjwmasOX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-05-24 at 08:15 +1000, Benjamin Herrenschmidt wrote:
> > Right, that's how snd-powermac does it. It has the nasty side-effect of
> > polluting the cache a lot though, since dbdma commands are 16 bytes
> > long. Am I wrong?
>=20
> You don't have that much DBDMA commands that it would pollute the cache
> _a lot_ :)=20

Ah, yeah, I guess so. Well I do have 32 dbdma commands, them being
spaced up in 16-bytes means 16 cachelines, no? I'm not sure how the
cache is wired up ...

> > Alsa calls this thing the 'pointer' :) The frame counter we currently
> > use is the frame counter register of the i2s bus controller, and I don'=
t
> > see why we shouldn't do that instead of reading back all the dbdma
> > command status fields.
>=20
> If you manage to have it properly in sync, that may work too.

Seems to work fine so far, even if bcm43xx kills a few interrupts ;)

johannes

--=-jozGK26R0akBOjwmasOX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHQqnaVg1VMiehFYAQJ9rA/9Gu3oPdOK0FKS61x0wh6z54HIteAeVS3c
msqL+hXGRVPHAd7xNs+otSKDGy2OHxyo9GUMUPVy4AR+ePX9q7PhzboXltiGaa7J
uSgEtRAjqF7mHHYbYUsVeZFOE69sho+jFa4Hu2a3X5xcvI9X3XwheQ8BMFgn+ReZ
ZF+F9ahbeUEKry7WNxYk6g9sT2u97HFB0NXb6CMWQ1gLMRtZCyPXBYBXIkt31SH7
C1Ruxq/24h1O/ZigGkzID7BVXkH/QqdiQpBcls4ZQmq3/Re9ee2XEGbQWAZoN7ru
A4WIEynRxzh66+0of2F7uVv0E7cngMIM5GUOHndsgjcOi/GcPUTY9sQZ4sgrEJ53
5z4QW3D+0wvt1sB0UO6TkxPqJIeVBk+jX01RO9bpO4kycixHJRqWx31EnEo1DR0s
H7Ab4uakzj1oJPnonVrwU5Kdfc0HDVbWmQjMGhKV6Yxuwmp+6/fESXm0l8wfT+yL
NbWpz56QEwZvzwMadjjZwMN5LZAsbBj50GDFNUyl/7e2v75IESlUg7epycHoWKO1
s/90Dln/KAW/h998YesRsfo0VcW/1+GMVNUMcaXun6db5lxHddB1kN+ABhwyLckn
c42u4vCt5cYiPKiG+2HHz/Il/xnV90X1hLZ7+YJ59pZlapuuRW8Z4OfqlJc+ZOp3
4NaiNXWwMug=
=Q7B7
-----END PGP SIGNATURE-----

--=-jozGK26R0akBOjwmasOX--
