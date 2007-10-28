Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40CC6DDFC6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 02:06:55 +1100 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <200710281054.31303.dmitry.torokhov@gmail.com>
	(sfid-20071028_145444_780469_27B026AC)
References: <1193222676.4510.5.camel@johannes.berg>
	<200710280100.13304.dtor@insightbb.com>
	<1193567513.3966.9.camel@johannes.berg>
	<200710281054.31303.dmitry.torokhov@gmail.com>
	(sfid-20071028_145444_780469_27B026AC)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Z/o1/2RK1gcWnDu0hcfD"
Date: Sun, 28 Oct 2007 16:08:01 +0100
Message-Id: <1193584081.5197.17.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Dmitry Torokhov <dtor@insightbb.com>, Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Z/o1/2RK1gcWnDu0hcfD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> I was hoping that FOUNTAIN_TP_ONLY_PRODUCT_ID (0x30A) behaves similar
> to Geyser in this regard. If you know that this assumption is incorrect
> then we need to rename atp_is_older_fountain() to atp_is_fountain()
> anf add this product ID to it.

Ah ok, I forgot about that one. If I were to venture a guess I'd say
that they renamed it to geyser because of this idle behaviour
"technology upgrade", but I can't say, nor do I know anybody with such a
version, sorry.

johannes

--=-Z/o1/2RK1gcWnDu0hcfD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARySl0KVg1VMiehFYAQJcgw//TszmDy363LbKPlmsEnlfZ+ldgKw7kAFl
Li3W1D026wyRmfOeD00MGewpCgkhrJrstigxsZOgH4fkdeF/rOUX12qaweL5Xwm6
+fuw2Qixuhwe0SHRsCnJiu1+4Zxwz/qF+irinaBFPHIz7ZcL7mwMfJEK/91svXoF
XZuND2j0S9pHvdh0RqcDcX/A5/JsTKY1yNsM/rUVf0O1P1RhXlZaE6Bs7/W5uGt5
iSaakWw0rrNrYYzmNf4xhncqK2oHljCgomT1j34aIb4COiSdMs0IWpQbRKsFIpKs
YU+Qnup95iFWsYYRX6IwEixluUic+yBJwgaOGHHdsKumTLe/x0AbTNMvbbkP/2cq
Zb2TcfkJSGoC5V6vdRjJgNAEEr5bCLE7+zJh/Qi01a29J2YiVYWK83Wsnz2mTo+Z
ARbPUKrdDEPGhZoEqIdvGX0X/Pwn3QZ9ov5nA/NKKRzWR9mWpjLAh6E/+uO07U30
8ChyjFLe71YG/gtYpcpgK6FVWlTrtuhBgFmo6QfgeHlCzlr0ILNhqfBZYZ1EAuxV
RtU+tRimnlfrQLWZwsTd6zRk5pZ3S2TrJ6Tpl0o1KWw3g1/qngAHQBFXZzKefhW7
wLa2PvuopwVJCA3IpczuBCxUOIYHHrYtafGRjFvc+e2wrjGvZpidJgx9sn/gZV9N
Jo0iFQcW3WU=
=1Oqg
-----END PGP SIGNATURE-----

--=-Z/o1/2RK1gcWnDu0hcfD--
