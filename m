Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DDB567A63
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 04:47:58 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Johannes Berg <johannes@sipsolutions.net>
To: Eddy =?iso-8859-2?Q?Petri=BAor?= <eddy.petrisor@gmail.com>
In-Reply-To: <60381eeb0605251044i79e155f2s62fb30b93432510e@mail.gmail.com>
References: <1147860564.14395.6.camel@johannes>
	<60381eeb0605180025v2495715scb345d7067518ecc@mail.gmail.com>
	<1147947784.15507.46.camel@johannes>
	<60381eeb0605251044i79e155f2s62fb30b93432510e@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5lKv6B1jfNA1HEhMNqSe"
Date: Thu, 25 May 2006 20:47:46 +0200
Message-Id: <1148582866.11759.45.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-5lKv6B1jfNA1HEhMNqSe
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-25 at 20:44 +0300, Eddy Petri=C5=9For wrote:
> On 5/18/06, Johannes Berg <johannes@sipsolutions.net> wrote:
> > On Thu, 2006-05-18 at 10:25 +0300, Eddy Petri=C5=9For wrote:
> >
> > > Any chance for 5,2 ? What is needed for it? Codec only?
> >
> > I don't know. If you try loading the modules, the kernel will tell you
> > something about an unhandled layout id. Alternatively, you can find the
> > layout-id file in your /proc/device-tree/ and tell me the number in it.
> > The rest I can figure out.
>=20
> I am not sure if you can make _now_ somethign out of this info, but I
> guess this is will not hurt:

Hrm, I keep forgetting that you don't have a layout-id property... I
need to sort some things, been doing so much other stuff that I lost
track. Sorry.

johannes

--=-5lKv6B1jfNA1HEhMNqSe
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHX70KVg1VMiehFYAQJbmw/+ImSlR9tEx0UEktXBjWixe/QWjEqZibQU
Iudy//pG0ws0KzZ27A5Qa+1TZ1LsIDb45nGiuZ7rLpKF7op3fc+2vr1uTXhqkElh
eeRL+TVFE1lMOSZi6SoXgdSH9wwtHvHGz0i0c5pw0QpSRfQ2cWhgzP3dy5o2WnKe
YmAOT9yMiCy2U7EaaSCyiP8grGvnI779Gm1FA3pgpJ7AJmeA5/GpJK+MslJF5vbB
J0IF41EBw9oniOwLCcoD/QJ6epPoQLQBjQTBbRVOyFx3g4T60HS/I697ZKpADkUI
UWoaa3htS93i7p2ngogfDnTsRY+O5/CZBbKCkFRLQlXnOdLDsvNkeB9dUHDIPL8N
wWt0QQvz+KQea6AjbVoYZL+r3blTAFOrAOZMsLnoQ612Qk9Q0J7FNsGTNT2BSkcE
HnzTjUoes1dBCFsaRVDNfTIaY6+Tbp4nzHbUL9oe4NtMcocmuOa2k3VjDC11as3z
XceCNwJ948bM86NU9KbiRyb3TNNh6Yz7sPYwkJ2HDma0tbAdo4UBsa+bIqQIZr1J
uXZVUBcJp+OnE534rHTPTJh8R6+4x5ezoD1qMJq40ke8mrDLTvBL6jZ4TYZVDPId
7JzbmStmfuMc6/nLkvIBBabIWNhBowK751wT06y9nzJBbWlzi2lEsdM6bYgFpXMk
tOm/DvMXC1k=
=+ClE
-----END PGP SIGNATURE-----

--=-5lKv6B1jfNA1HEhMNqSe--
