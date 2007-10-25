Return-Path: <benjamin@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 70A35DDE3A
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Oct 2007 05:11:04 +1000 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1193318605.6092.11.camel@johannes.berg>
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
	<d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	<1193233015.4510.44.camel@johannes.berg>
	<d120d5000710240729v2e3faea8u615cfa7f1e489d11@mail.gmail.com>
	(sfid-20071024_152918_483347_CDA0EBD8)
	<1193318605.6092.11.camel@johannes.berg>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-zJzYqGG0RMkZknj7KsJa"
Date: Thu, 25 Oct 2007 20:28:01 +0200
Message-Id: <1193336881.4630.8.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-zJzYqGG0RMkZknj7KsJa
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2007-25-10 at 15:23 +0200, Johannes Berg wrote:
> On Wed, 2007-10-24 at 10:29 -0400, Dmitry Torokhov wrote:
>=20
> > Do yo know who has powerbooks with older geyser models (0x214, 215,
> > 216)?=20
>=20
> Not sure, Benjamin? We're talking about the touchpad, just lsusb should
> be enough.

lsusb says I have a 0x215
(Bus 003 Device 002: ID 05ac:0215 Apple Computer, Inc.)

Everything is working fine with a 2.6.24-rc1 kernel (ie. no bogus
messages).

> > It would be nice to know if they send the data continiously and
> > whether the geyser 3 reset hack works on them.
>=20
> That'd be good, but for fountains it definitely doesn't work.

Benjamin

--=-zJzYqGG0RMkZknj7KsJa
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHIOAxJddvdAxOva4RAstpAJ93Zen6p79J0qTjnfUavj0cIMfR5ACfRGgu
SdTS+/cJKeDQfdzhQ7udKUM=
=nVjZ
-----END PGP SIGNATURE-----

--=-zJzYqGG0RMkZknj7KsJa--
