Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (unknown [213.151.39.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BC3B5679F7
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 00:00:55 +1100 (EST)
Subject: Re: snd-aoa: new apple sound driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1143604878.3585.5.camel@localhost.localdomain>
References: <1143547826.13615.24.camel@localhost>
	<1143604878.3585.5.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-VFJE4B6BkvMLxHlBKMuZ"
Date: Wed, 29 Mar 2006 15:00:43 +0200
Message-Id: <1143637243.9481.17.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>,
	Alastair Poole <netstar@gatheringofgray.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-VFJE4B6BkvMLxHlBKMuZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-03-29 at 15:01 +1100, Benjamin Herrenschmidt wrote:
> BTW.. with the current stuff, if I install the modules and then do
>=20
> modprobe i2sbus
>=20
> I get a registration error in dmesg.=20

Hmm. What's the error? Can't reproduce this at all. Also, what machine?
It works fine on my powermac, even when i2sbus is auto-loaded due to
binding to the macio i2s device alias.

> If I then try to rmmod it, the
> machine blows up. Haven't had time to track that down at this point.

That sucks.

> Appart from that, it works and I can play morse with myh SPID output :)

Heh yeah, we did that too :)

> Oh, and jackd seems to be unhappy even if I tell it to ignore the
> capture channels, it's probably a problem with setting the sample
> formats, I haven't looked in detail (yet).

Hmm. I'll try to see what jackd does.

johannes

--=-VFJE4B6BkvMLxHlBKMuZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARCqE+KVg1VMiehFYAQLG9w/9GQa839edyTh2tnRC6+X+VCGfXYiuLrHv
0eFoCdnhMZpURiQTDQXQ7H8Wz/mQvtYkUZaTjrggzdbn7r98pPzIpzRTZGGnY6Q4
KxwqbdwoMZPHTSCmNvVnkXxtDdBTVdLGaQ08vCKrbU2m1MRmgJ57vzKnFEh49+Ga
7YFsK0cwKAOD0f1Os6/d5qrxMcYWqc3pKyG3XePAfz/b3ncFLc/L3Mu1W/8AGKdV
V70qRKerjK29+qCGPZ4YD5pDDUBBfWK7H6H1iX27UW6ztjEdCIs29pM/tNPhUtCj
hG1Bu4zFNSBXZPW86ykrE8jTJpKEVYJdj3JaBFmgY2S/ukI3Xe1TaH+bk1NMZcVq
QD0wYk3dTlHibXo8R81keGCCIOjjz2rWlc6eak2vmmQMJ6mhibh1CWC93maUZSRX
zncNL0CEN3p9ZKFq3d3uNSohd2rY8FmEfIZjPRjMqqKgrGJjfRpRKzJfxUJzaUf/
fsOYelENNVpCHVlKHxGVZKBgFae7VpcZxWt4lIP9N/qdlb5eVbg6MuDq6A3hGRfG
tLUI3v63/TnygaZptZfeQ9jx5Xg1BV8FAO9xSwYLJ+3NQ9kBAN9Yotc03SAr0NQG
DatEVrf8Nw2ML8R+Ogd4Pzn0iuJRz7h3g8nDNkBE07ggIyYENBA1xUuuwPIi90+d
nZSNcSbTOsw=
=nQUg
-----END PGP SIGNATURE-----

--=-VFJE4B6BkvMLxHlBKMuZ--
