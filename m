Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A32B2DDDD5
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 23:24:07 +1000 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <d120d5000710240729v2e3faea8u615cfa7f1e489d11@mail.gmail.com>
	(sfid-20071024_152918_483347_CDA0EBD8)
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	<1193231110.4510.42.camel@johannes.berg>
	<d120d5000710240634j21d2b660t267ace56bd9d6af6@mail.gmail.com>
	<1193233015.4510.44.camel@johannes.berg>
	<d120d5000710240729v2e3faea8u615cfa7f1e489d11@mail.gmail.com>
	(sfid-20071024_152918_483347_CDA0EBD8)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-+9z5MGS1CGDf4T8bnaMz"
Date: Thu, 25 Oct 2007 15:23:25 +0200
Message-Id: <1193318605.6092.11.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>,
	Benjamin Berg <benjamin@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-+9z5MGS1CGDf4T8bnaMz
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-10-24 at 10:29 -0400, Dmitry Torokhov wrote:

> Do yo know who has powerbooks with older geyser models (0x214, 215,
> 216)?=20

Not sure, Benjamin? We're talking about the touchpad, just lsusb should
be enough.

> It would be nice to know if they send the data continiously and
> whether the geyser 3 reset hack works on them.

That'd be good, but for fountains it definitely doesn't work.

johannes

--=-+9z5MGS1CGDf4T8bnaMz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARyCYzKVg1VMiehFYAQIqhA/9GXLgMs38lEsXwBZU0/O9Mq7QHWetAMdY
U8BXQ5w+3xFpyxGW2tXrXVyOTJmrGXaQcA0BKPfz4qQzZrFRZZeYgzAKFY1YwzLs
suusOI3yVdKs54kuRHGOPgNAm8jOwF5fDrAftP+S/BE0QqXB0dvA9P6ljMnCJBrI
E7Fe4KyguqhbdkyhfODQ/r5MnpQYB9fT8pSI0YXqnW/yE/3J3TgzZW3oJobjQPD8
cdOSTXnQ18D03WWZ9P0Ck0T6dhFGnZWyAg8zq57CsVpLHzTrGoXlTTkpJOhDE2V1
8jVboqc9YSbb7NKEtAAPmb+RbHCZh4fqHaSxhVKfyk/dBoXkexvlXq9RT5NU05pF
86HGFdzzvGfVwPr++yk8t8rVR29tz2nisP/n2QtC6dMJRUJT5XMavF6IuVT2FHko
xuSp9KZpgJ+h6qsw9Ibekn0Zn/FUgmH5u+aT1Wrzm8cUF4tLI4tv4otTiwxAHaQh
iNaGcJbfwKViu4Q6/z2lkqymP2ZtkCpjrah/glivPoay/8asH4rJtEjTGAKpVec5
a05+Z8lecdHZAvGs3UQ01T28JcJKIg6lP9jsf63L68vhjIa4thjqsdjt/dRseepd
cDwpR4IZ9nc6vxjd33ExsB6uXpkLiMZ+TXgLM6rDbS5fsN8fvJMWlK99dHNIVJoG
VBcjzKymgAc=
=o+Yb
-----END PGP SIGNATURE-----

--=-+9z5MGS1CGDf4T8bnaMz--
