Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01545DE040
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Aug 2008 21:40:50 +1000 (EST)
Subject: 64-bit build failure without hugetlbfs
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-F0UCc8qxJPvTeWtIZ5wP"
Date: Tue, 05 Aug 2008 13:39:49 +0200
Message-Id: <1217936390.3603.34.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-F0UCc8qxJPvTeWtIZ5wP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

  LD      vmlinux.o
mm/built-in.o: In function `.arch_get_unmapped_area_topdown':
(.text+0x1d084): multiple definition of `.arch_get_unmapped_area_topdown'
arch/powerpc/mm/built-in.o:(.text+0x7240): first defined here
mm/built-in.o: In function `arch_get_unmapped_area_topdown':
(.opd+0x2730): multiple definition of `arch_get_unmapped_area_topdown'
arch/powerpc/mm/built-in.o:(.opd+0x918): first defined here
mm/built-in.o: In function `.arch_get_unmapped_area':
(.text+0x1ce3c): multiple definition of `.arch_get_unmapped_area'
arch/powerpc/mm/built-in.o:(.text+0x72b8): first defined here
mm/built-in.o: In function `arch_get_unmapped_area':
(.opd+0x2718): multiple definition of `arch_get_unmapped_area'
arch/powerpc/mm/built-in.o:(.opd+0x930): first defined here
make: *** [vmlinux.o] Error 1

enabling hugetlbfs cures it.

johannes

--=-F0UCc8qxJPvTeWtIZ5wP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJImDwCAAoJEKVg1VMiehFYYl4QAJXsxnoIC1/U35TdQtLzl1hc
VjbpOQhJuZtYWnP105UaYKWPKeTa+Aav1tA3GJ5lHIJqiljVVbnUbdgIc35jALkS
miAQtj9upHxZLTxxmbfXtUjxjLTiwtlzNgwLWCNBj92Flh2QXIqUc1pNjZRIsCct
/mF6+7fDFt0SMkXXBn4S9SAhRaLyZFTwtgU5eatTz/nSuyNayfwRReIJT+jNySiR
TYGxXZC85WWiqpj0JBVZik4UpbqmxKqyN572OZ8suQ2OFz1vzm0cAJtTv31Moq+E
vZdmu21ghtztNVDVx3ymg3d3cvVwSEPfaJYdIQjdMQJ0wlkCot0zkoEdE47Q6+gI
WbYmSxxrOEWwlGlt7PmpRMTKBmKsUWUP4xdk9YFkQ6JF2sOW4aci0LxxIF/OdD7d
N+tQP2IMxD+Wh9VkhCRBTcsnbQUj2jPuwFbdt3QMTKdvo9Is+Enyk90C/+h1Rqyu
kJc4UpHeOt9wfkBl5TiQxRMp5Ap8ppP5VTmkl7Urifk0TUhBrmMnr1SQnwX5dS30
xkK1aWa4Xx77dr866kLXFwEV6i8zfaQBmqvACDsw0EzCNx7/7PC/ib2myiYqfEqs
3LLUUtCD0hIf7wq6PP5ciDfVkQCu3Hd1YNXpKdugh1el7jtxjmIIpkDzcq70dX0Z
11NwlDShLWVms3rrT24a
=GfA7
-----END PGP SIGNATURE-----

--=-F0UCc8qxJPvTeWtIZ5wP--
