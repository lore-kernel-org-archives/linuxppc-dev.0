Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25FAADDF1E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 17:05:11 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: Add irqtrace support for 32-bit powerpc
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1208925639.9060.16.camel@pasglop>
References: <20080404213932.GA15847@farnsworth.org>
	<20080407171428.GA14900@farnsworth.org>
	<1207670643.5550.11.camel@johannes.berg>
	<1207690574.7442.4.camel@johannes.berg>
	<1208925639.9060.16.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aKGPidFxLKlUPc4iOZur"
Date: Wed, 23 Apr 2008 08:33:59 +0200
Message-Id: <1208932439.31429.49.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-aKGPidFxLKlUPc4iOZur
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-04-23 at 14:40 +1000, Benjamin Herrenschmidt wrote:

> > Hmm. Bad news. I got a crash in console_callback() again where
> > apparently r28 had a bogus value. That, however, doesn't make sense, so
> > maybe that register value was calculated from another register.
>=20
> Possibly. How hard was it to reproduce ?=20

It just happened after maybe half an hour or an hour uptime.

> Could it be a bug unrelated to lockdep ?

Unlikely, I've been running the same kernel for days without that patch.

johannes

--=-aKGPidFxLKlUPc4iOZur
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUASA7YVqVg1VMiehFYAQI1mBAAsZTFv/VBBZZmQ3ZLqxdZWwTJyPKoGMvq
8yXL4hT72NDC/tmq1OjTKZ5bYONxcJLSbBK3IvPngKkMgeaYpO8ODiFMOe5FhX9x
DqKw4rDQ0Y77ncAUs1oHbG95T139NBL6fbFa3NLWw4YSQ5AGJeBOdaeB1tXJnY76
fDrejs6rr66brzCFFU6lcatt8rXM5tnGXhbmm6uXIaQ/s/CTx9xN0HIybGNJRdBZ
Qw2V1eTfWaMUXSiKQ6qIEOovnMVUipFIKHIMH6arm/79GsgqeVrayeWmPiResicI
GIQnSCT4WSOzbAMN5Iex1Hx8UFhuh5LhTNEC7NaSl6uXmqNyO+ypBAtV/10G0Lk/
Qo7YA048l6SF+vGD/jQFl65ctf3CHDP35bWmu3xT37CwrbX9aW6FRZMOWrn84iu5
HWzqqqRtKBocWTyw+CqvEA2LQKgR3wJOMCIKVLtn2XXC5f4ligEaSCJtxZGl8Il8
PKICCeKMW4V2FG+Z3O0UoZY2nrePeVsdNmkarMLiEoYUJBhGWTSvirV9sL6Iy1Kx
t9p2S+CTetZbJlo5rQIbfUgPTC4bwZOqkV7bbnKxfZ1VsPEWhE7H1MvqAGk3In9/
nF+ZfCzXlodN4mFyntJ17kptZ5S+qdE8KGVGkolOSlSQE+NDXwT0JHFVgYr8Negy
R4H7yf5VrCc=
=ZF+0
-----END PGP SIGNATURE-----

--=-aKGPidFxLKlUPc4iOZur--
