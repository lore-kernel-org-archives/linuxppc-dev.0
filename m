Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8980FDDF2F
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Oct 2007 21:30:38 +1100 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dtor@insightbb.com>
In-Reply-To: <200710280100.13304.dtor@insightbb.com>
	(sfid-20071028_050055_048669_252648EA)
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710260905k4c6391b2j7c3d8528cc8198b0@mail.gmail.com>
	<1193430697.15686.1.camel@johannes.berg>
	<200710280100.13304.dtor@insightbb.com>
	(sfid-20071028_050055_048669_252648EA)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-T9zPWpleLeHN5B+LD0cD"
Date: Sun, 28 Oct 2007 11:31:53 +0100
Message-Id: <1193567513.3966.9.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-T9zPWpleLeHN5B+LD0cD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> OK, then maybe instead of reverting the change outright we could try the
> patch below?

That patch works, minor comments:

> Older models of fountains do not support change mode request and

I think there's only one fountain model.

> therefore shoudl be excluded from idle reset attempts.

typo

>  /* MacBook Pro (Geyser 3 & 4) initialization constants */

That comment is no longer correct, you should change it.

> -#define ATP_GEYSER3_MODE_READ_REQUEST_ID 1

> + * Reinitialise the device. This usually stops stream of empty packets
> + * coming form it.

typo "from"

johannes

--=-T9zPWpleLeHN5B+LD0cD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyRlGKVg1VMiehFYAQIzQhAAxG39+VIispBZseqrZ/8F3Ur97I0JYb38
Ce6lWNzC+FbIt6pywQ3+8nnHkE/N4t58uSO2jRdR45zqk0n/6T8OpYkJwK5CPWYL
xJZir+LhuMZpWLbjixX/QS1JshkN/GR+6bZVnfJ4eyqNv292/ShHGGeB3xVokLkb
aRe6LyOwvoIPl+WJDzHRzfhPyRRXp3Ucl0FEhvKmSjITxwHTIP9K4oKQGPNU8ahU
jb+mjFvAl0xHTkyIrvaxYUDjzu7lY65RWRk83B0otfZDe1C2gZaAXFks6qfPAIX0
dGPoEfIj1g8nI3OzRV28L61po/emk+BnbVk65Z1Ns2jw4FQgHVOp6fRXg/iM35N/
4Mz8wu+oZbEtheoVLuIM9qDA4Ko4K78XK8UBXnx/qiQqhM0QvyTLmyjex2EAyXwh
4NRozyUJ8tLH298t/JotbRt3ApYl+OC/zgXf6PvdE3deHsvQJEuPETXa2f2Zs7Kj
oeYaooxVW1xV53MgXeVd9MkFF8mJikT6BaIy+Kb6btcFFdkqBJ/NmgI7RcIZoRSa
Ewa9YGfH4j34jkNXxOUZ+f+/cU76s6zUoRZ/RE2jGItgH6zqP8Q3/caX0i3T/7ZH
UGO2x2GJV1boYSmSAJqE5qgJj49wJTDegqDHqPbNE+1uXWG7jpougBeZmcGwCsx2
SdfmksksYAw=
=amxt
-----END PGP SIGNATURE-----

--=-T9zPWpleLeHN5B+LD0cD--
