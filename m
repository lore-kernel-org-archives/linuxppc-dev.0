Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3303E67B4F
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 18:56:25 +1000 (EST)
Subject: Re: [PATCH] via-pmu: report powerbutton as proper input event
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1146466716.30710.39.camel@localhost.localdomain>
References: <1146251713.5019.4.camel@localhost>
	<1146466716.30710.39.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-IbZ9DmiQBU87ADOh4P3z"
Date: Mon, 01 May 2006 10:56:13 +0200
Message-Id: <1146473774.24172.2.camel@localhost>
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


--=-IbZ9DmiQBU87ADOh4P3z
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-05-01 at 16:58 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2006-04-28 at 21:15 +0200, Johannes Berg wrote:
> > This patch adds an input device for the power button so that userspace =
gets
> > notified about the user pressing it via the standard input layer.
>=20
> Looks interesting. Waht about other buttons/events the PMU can report ?

What else does it report? As far as I know it doesn't have anything
else, at least on my system.

> > +#define BUS_PMU			0x20
>=20
> Magic numbers... BAD BAD BAD ... Somebody needs to LART the input layer
> people.

It's not really a "magic" number since it doesn't really carry any
information, or would you like string identifiers in each device
descriptor? An enum would be just the same, in fact, the definition
could be rewritten as an enum :)

> Do we need these here ? Why not an initcall self-contained in each
> file ?

No heh, good point.

Thanks,
johannes

--=-IbZ9DmiQBU87ADOh4P3z
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARFXNK6Vg1VMiehFYAQLe+g//aTfvrZLcNxcCDgbT5ikoqtbjNE0jwKd8
56b4rHnAENyJTse3TDce2swFiAw5kmzF2x6+sLz2bbQvbwk1uQYiupE62e7yahJ+
UMpiqdljXrVqbUsr5D7ghp86QEqHpMMRzPYeQ+ePv5AiYdBgJ/pUAQJyJ3eyI+5R
3yhy3e7390iFBeODIOs4JC3LaqDQkntB19eb3CjFJn74J44KSPj95Lu+JBTwUiWh
1aTZ6RCU/tLMgWI0tSZSB5MtNIlAbYNEBX2fb0zCkJ+xwHZlb4Qt2CTSgEtdQDnI
AmDvK0xC9pnSGXGpH0+bMkfiM8XJzCSIjiP6hUJ6lG0XLl0sIrZEn6pjn0H9SFGg
/1EDCZ8OzMg0hUQqJXmAPotdet7DbpshduXKcxwx9J4qNTjjR33znyMZaopi9ZY3
nHSQeiAwa13UyrW9whXYu+4p4jjykT+KdJRuVAQ9LFt3mIcD2J+hLS18UZwZrlYA
tEErMblXNUIrjr1W8zMYp0suhIsu+2u7V52qbgGjm8S7x4jL8VawPXd0H8Pi3wVx
3eW9WiHfVQriiPiNlR3nEYMopRVNV36YozH1QS1gKbyVxLOJkxTONpGjQ5DH97GG
bUrtEgPMFYGFThUu9MNS3enIAA9zJiIbkY+KK5Gw7338RC8B1aEnfbPJihicQ9ZM
khHSAQ/yLUY=
=xlLn
-----END PGP SIGNATURE-----

--=-IbZ9DmiQBU87ADOh4P3z--
