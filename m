Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3887FDDE3B
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 03:31:46 +1100 (EST)
Subject: Re: [RFC] powermac: proper sleep management
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1194814773.6510.23.camel@pasglop>
References: <1194523729.6294.18.camel@johannes.berg>
	<1194814773.6510.23.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ClNgyjhtTEBn764YUkZU"
Date: Mon, 12 Nov 2007 17:32:57 +0100
Message-Id: <1194885177.5229.45.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linux-pm <linux-pm@lists.linux-foundation.org>,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ClNgyjhtTEBn764YUkZU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> Looks good to me, +/- a couple of things:
>=20
>  - We _REALLY_ want the freezer to be optional and not enabled by
> default on PowerPC. Maybe make it a compile option ?

Well, Alan is going to tell you that USB will break. If we need
confirmation for that I can do the test he suggested to you or Paul a
while ago.

>  - Don't remove the pmu_polled_request() debug code. It's very useful
> for debugging and I don't want to have to re-invent it.

Heh, ok.

> Plus I also need to test it on some exotic hardware :-)

Obviously. I don't have any of that. I'd appreciate if somebody could
test on a 3400 powerbook to see if that pci config space save/restore
stuff is really necessary or even interferes with the regular stuff.

johannes

--=-ClNgyjhtTEBn764YUkZU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARziAOKVg1VMiehFYAQKM8BAAhC2hK04f86OL45AYOfnFyvwKWyQKYy5j
fXOg9IrpgHCcXJvqRX7/KIxREaDd62Xkvixe8PXzo45pdYjUDbv4dS7KsphRG9I9
9Zbn7gtVUf5ibxldJBuKRg5+yu166BPrv1bo1cvbJV37WSJSwiwdCjD/lx0jWJmr
Rov3f34afhKfp+UVioulOarQhWKhK/e8WZzdaN8kZbaz+tFZtST9fDB9dIDXNt1P
lJlgaIIM5Q8BOuimvY8HCjWt1FWK+yZ7/+Qdp6wwI5zC02dKqXsQCwi/NrzxdYY2
WHp+OevA8Z98xN8TIjDFpfeSjiIDBFeV3pGRr+iYxxREOupP1eQV05aVKJn4Z0Ka
gH8tAlqPbgv4bxL7Gv5aZ+Plorj2qOlhLLp7uhRmV34+xfjDXKHQTorAIiKcShkn
GqMGYHOvsULo1OmSBXuELLmsvGVcSIUjQyS/euyz6xmAGjN8zJJOAlb1vZ2k5zqm
6NxVvLiHJF+v5jCBKJ03Yx4Q9l4MPPGZU+10ANdmho8Mab/e9B8gSl+tK/BMsaMW
fABvsE8JzDvkaJYz1IdWW+lFIYKP+h2RcpxtsNUIkdR3lqQ1vZ8QW4UumGnAIp/O
qPAcuGLL1EDbhN7b2R9YYcFasrocX5qymnnXGc+oap9jBbZhW7T5G+cwRjpZMkmU
HyQPOhPM5p4=
=U4gp
-----END PGP SIGNATURE-----

--=-ClNgyjhtTEBn764YUkZU--
