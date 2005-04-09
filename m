Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AAA6E67B3E
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Apr 2005 19:33:02 +1000 (EST)
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1113006674.9568.414.camel@gaston>
References: <1113006674.9568.414.camel@gaston>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-OQlNsfecKsV7BtIlE/po"
Date: Sat, 09 Apr 2005 10:50:30 +0200
Message-Id: <1113036631.5083.0.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: Sound drivers for newer machines: need help
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-OQlNsfecKsV7BtIlE/po
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

You probably know/have this already but for archive's sake:

> echo `cat /proc/device-tree/model`

PowerBook5,6


> for i in `find /proc/device-tree -name layout-id -print`; do echo $i && h=
exdump -n4 $i; done

/proc/device-tree/pci@f2000000/mac-io@17/i2s@0/i2s-a@10000/sound/layout-id
0000000 0000 0046
0000004

johannes

--=-OQlNsfecKsV7BtIlE/po
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (SIP Solutions)

iQIVAwUAQleXVaVg1VMiehFYAQJM5A//ZnrBi3Z73ufpvGlsqmkDGEn2Ulk7OUwq
otoR/4Y3Bxzc741Ob64bYeguJe0c58ac7q9LzwcRBNq+GNnF/Q8qakHSLwCR/DVy
w4vMBdnsBtruqxXBgK2GnHW6Mc69NxGI47Se4at5skaZL5t5b8GCf3U+QmsulJik
Ea2H6vC2Wj2ohwwErWiv60ne/ph1PqlA6cWpSWplE5p66NTK2C/JzeoURqswEnOP
zqA1df/qKEpRfhwQvUnSAmzS/7Csu7rgEax3nXjvMURbX0RlNsXb0C3YDPaBlJIx
BjK5kMFUEbxnA7uRIfDVALwPcsM4axTjli2uT84fSTN9pxHnxg/uYjAWcEQhdvMA
Wgfm1v6r2yIIF3LJLwT/MoI4wLkYZN9wqpZb5mhGEb2NshLsjxouQboqtfBx7hIR
zT50KmchEQLU75KdrszbPoJh3GvefvsWMSZmAJgDVl5f+CStEiI7SGGvBe3VqaYV
8SmK6EXOsa8YYwjj5eTwfonTzFLfAOBIgUWJhbJ7Zqi/cR8uZSmkNsLzNidbkYeT
+FUiZe4ZGI5qUXNaKjK3BSnQwcgPcVupN9KGrMV6hi7uBNustk4NTuSpRDsdkRsb
XiI8OuJeFHFTqQPYYEofXFewMFUl/2hRlfQU35JD4UT1m7t7A5NUmED3H8T7ijr+
S7iLHw+oXQc=
=0MBX
-----END PGP SIGNATURE-----

--=-OQlNsfecKsV7BtIlE/po--
