Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA88C67A5C
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 17:28:29 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1148606268.8089.12.camel@localhost.localdomain>
References: <1148553785.11759.12.camel@johannes.berg>
	<1148606268.8089.12.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eii52smJxYU3NHL76fOt"
Date: Fri, 26 May 2006 09:28:04 +0200
Message-Id: <1148628484.16989.3.camel@johannes.berg>
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


--=-eii52smJxYU3NHL76fOt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-05-26 at 11:17 +1000, Benjamin Herrenschmidt wrote:

> I think we need to be careful about a couple other things:
>=20
>  - We need non-pmf GPIO. Some layout-id based machines do need that,
> like the mac mini

Yeah, I saw that, but I need more insight into how that should work with
a feature call or so...

>  - I'm tempted to rename soundbus/i2sbus to snd-aoa-soundbus and
> snd-aoa-i2sbus (at least the module names) for now.=20

Yeah, I guess that ought to be done. Not just the module names, also the
sysfs visible part (though that's easy).

johannes

--=-eii52smJxYU3NHL76fOt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARHauAKVg1VMiehFYAQL6sQ/8DvltS0+e68bMqpS72UykLhqYgIX3BSz4
keNORre3FytcrX9hEiVmUWTkI5nR8aecI7ByNzXLhZaKrKeT337zXe/KJYYLyvHG
xVlVi6gfFef94rgRTHa4ObqAsa8ONmxBGiD9bKDjUmgoe6nSL3kR1H3bXmZgAfLe
QRTonIg07HoBw3qgsevyj90iDsnc24w32Ner+aeSHk1vg46XRy+Rc5AfIS5aSztq
m8jXVA25lX17j+eFHUP+MAH4tJFq6e135efco3VksDIUqV2PdazRYn+TXtxPRqhx
1ZTZ7sW/uIktPmC7ieXkCbBaquRt+K7SHZvN9Cdmm5T+LeIKuu6CdFnNZaKHEood
O+x3diAo/xW7JIlVJG4vLav4xoSk5PM/O+gHYF4ykULWDMMxmMQhbPrJPa+/3krt
dR3z56X/pnK21K1Q/Y01hZfrzyr334oHlKDNUgF6WDK0aFYufjGT6/zNXI+BGsyL
XTQ3bag7EViF1jwQzr3AKHq8KAEaHkp2Qv09KxDZYOKDXsJVcM9yP9coyhgsdOF1
X2uVkqKBOLRmzPmAyHYDIavI/ykmSf1G31zvg0Qmos9oynbOL36z5oPq+TK4ntDX
97m+Qsa7QgkW5YjnL3AulnzPdhSNZf1lTFyDqsU/CzjUWUDU0u8iz+UnSHOZ7SEW
S7Jtl7450KY=
=hIMo
-----END PGP SIGNATURE-----

--=-eii52smJxYU3NHL76fOt--
