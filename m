Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 92BBBDDED0
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 10:28:59 +1100 (EST)
Subject: RE: locking problem in sata_sil24?
From: Johannes Berg <johannes@sipsolutions.net>
To: benh@kernel.crashing.org
In-Reply-To: <1204585095.21545.37.camel@pasglop>
References: <DCEAAC0833DD314AB0B58112AD99B93B0410A524@ismail.innsys.innovsys.com>
	<1204583866.21545.31.camel@pasglop>
	<DCEAAC0833DD314AB0B58112AD99B93B0410A575@ismail.innsys.innovsys.com>
	<1204585095.21545.37.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-7dwkLNGKVUdKNANKyZDc"
Date: Tue, 04 Mar 2008 00:28:29 +0100
Message-Id: <1204586910.3917.71.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-7dwkLNGKVUdKNANKyZDc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> In fact, I remember working on 64 bits lockdep, based on patches from
> Johannes,=20

Your patches never really worked for me so far but I'll be happy to try
new ones, haven't gotten around to checking into the differences.

> but I didn't do 32 bits. I think somebody worked on it, but
> now I can't find the patches...
>=20
> Whoever did it can bounce them back to me ? I intend to do some more
> work on this soon.

That was Dale Farnsworth, with the subject
"[RFC/PATCH] powerpc: Add irqtrace support to 32-bit powerpc"

johannes

--=-7dwkLNGKVUdKNANKyZDc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR8yJnKVg1VMiehFYAQLATg/+OZSqmEUaG6ISKR9Sx+eBjq0nWr90Oxjc
zCH5HIa5HTLPQhzGiceYx76FDRylHVwv/fKtDFaKbyD+x00ymiYzjn1IgDZiY8B+
5uzKc4g/WYn1n0Hr/XFOFirk1mwg066u/dzcZNV6oXPnxyovmIALePRsHyOrifXq
OkVoXCEX/IkYzZafAlPSdVGflVk59fUjwrbZ3wuJhilXktFhDW28i5631NdQ0eVH
LRdOnm6xiBBO6MotFTuBSsKBl34QF3M8sj4pJiR+ahN39+mLHYQulYwdMWYvR5uB
CeTqz/GWJ37BOjo76yp4RhxTOfwvNs2B7xTv/+v3oK1/4zlRb09A8I6EtUG3Q9yS
y6R7sjG1G7EmVWmco9N/mB4HtMH/HELnW+s2n7n2O0sXQBktEf+t0CpmvOA413AH
BUw3STV+f6j4uI5J6FOgj/Rpho+gRK5rurZ8o93mxsTg29ITP+yInNN+/XXAyDif
EpO0lyhxsZaxHMIAZiTvxdtRIOjTD8YccUvrA0K1L3u2uKK+aFRnVh5yFJOh9Dr+
Wbmg0yMWPMaRqlpeO0Yi2RNneh/qdpgg8dZO6Y7fwaIQQhq71exjLNTjm/9Auc4A
jnbBFWZDi8IkUQNEqnujGUfABytIBoRAEVJFWGUe7JXkKo/Zq6NoV7EPcmvpWTuT
dwcgWKUtybU=
=8BRa
-----END PGP SIGNATURE-----

--=-7dwkLNGKVUdKNANKyZDc--
