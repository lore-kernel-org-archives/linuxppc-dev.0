Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E96A2DDE47
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 08:41:33 +1100 (EST)
Subject: Re: Why are CONFIG_LOCKDEP_SUPPORT, CONFIG_TRACE_IRQFLAGS_SUPPORT,
	and CONFIG_STACKTRACE_SUPPORT not defined for PowerPC?
From: Johannes Berg <johannes@sipsolutions.net>
To: Tim Pepper <tpepper@gmail.com>
In-Reply-To: <eada2a070711281336i41a7f149i2c1db7cd49c0fd69@mail.gmail.com>
References: <474DC7D0.4080907@freescale.com>
	<eada2a070711281336i41a7f149i2c1db7cd49c0fd69@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NyL3QwqXVnDTZPIqJ/RS"
Date: Wed, 28 Nov 2007 22:41:16 +0100
Message-Id: <1196286076.6058.167.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-NyL3QwqXVnDTZPIqJ/RS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> These work for me, but I don't think they're finalised yet so your
> mileage may vary:
>=20
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D14171
> http://patchwork.ozlabs.org/linuxppc/patch?id=3D14172

FWIW, the second one doesn't work on my quad G5 but I have a version
that works... Haven't figured out yet what's wrong with this one.

johannes

--=-NyL3QwqXVnDTZPIqJ/RS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR03ge6Vg1VMiehFYAQIEAQ//accftQzMHXGrMxnqFI8DHxoy21ntt4Pm
ZAaR02uRcylrJnbDIFPhj5hIATcyM7lp8EibmIe1DCD6HUel+D/72rwhaIZ8FmID
guOpWA+KQiCa9Z+bDw1n6ZQfvPTXVgDZClKunmF3uGpftUYrblWq24RqPucHYlEt
QFk5ZBUZbVFT+KbHOsGs1dwEf7N2DO4BZ0lsqev7meZyf9lHIhcaRNDyRoatND8s
ilryWMbUW31tVuvV23VQj9ZqyCZgKbiFXzY88of7224xijeuX/bQt1Uj9P8toNKQ
+u88JogGsUCwX9O3Z0OXdiwFiyeQosvIKbSBqbfrJZg3AccZW4SdIcRQGYAetHXB
bKjUpRPxp/N2BQajEV6RWgCX3zeRHV4j+sj/LUKZhmY4y+Rxg4fZahFPs6cidx3X
g/tjS/sL+1Id1uiAYjtlEtt6MDDafQ5tgIhK9Gr58XxT8n96mBZy5zvwQZjLXubm
dEYCeiS8A8pu1WwSEOBmp8T5IQGwdd09BbPBELh6P8NqNw2NncviLP/HeZAqHMI2
HLyQReT+uSBSrkxHbLU4+0lN21+fkkQ/aRViEM115CSZkvUFqwjv/wD9TW11oEAS
5xp1vP4vPTqTycMw5YgxVDwN9HmVCAX5GjT6A1//1rVWcnejM8mdCIqy+MWNywg+
ef4ytJWC5nE=
=tnjT
-----END PGP SIGNATURE-----

--=-NyL3QwqXVnDTZPIqJ/RS--
