Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C901DDF1A
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 23:16:15 +1000 (EST)
Subject: Re: [PATCH] fix appletouch geyser 1 breakage
From: Johannes Berg <johannes@sipsolutions.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
In-Reply-To: <d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	(sfid-20071024_135604_518920_59B194EF)
References: <1193222676.4510.5.camel@johannes.berg>
	<d120d5000710240555m545a4f95v8bfc1ac790273001@mail.gmail.com>
	(sfid-20071024_135604_518920_59B194EF)
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-DxDBrPlK1Usuw8UEy1+H"
Date: Wed, 24 Oct 2007 15:05:10 +0200
Message-Id: <1193231110.4510.42.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Anton Ekblad <valderman@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-DxDBrPlK1Usuw8UEy1+H
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

> My fault, sorry.=20

No, actually, I was wrong about Geyser 1, mine is a fountain.

> Is there a way to "plug" these Geysers? Waking up the kernel
> continuously is not nice.

Not sure really, maybe checking for is_geyser instead of is_geyser_3?

johannes

--=-DxDBrPlK1Usuw8UEy1+H
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUARx9DBaVg1VMiehFYAQJS9A//Uhvb5sEHwmlks4RUuT8lMMBHWjZKBUMM
X+HYLE1mWdIAv/8HEgg9JnbUUUqJ4HwqwM+TPV8hMtHPrGfRtto+JijETn6Dwj3D
d87NyRwzhjyMjDPkKdMPxlxsU5MMbDaQ4YxAGl1VR5WJM0cjhULkxlgDh4RwunLR
tpMhdtd3zngsB3HSbIhAFYIo9ppP0DEh7UJR0Ga+YFjOdEKuCdxXiUsbZZ0jK8W7
1bnq4s9N8gL/tZNK5iEjeNAdVzmJomTjkJglKwsqDhfJcWvR3e4alaeaRMpS8oRQ
Uq31Ydo6II4pfkk/5Ss7Gk3IuzHW2IW2SSSozJaZqhMjGuOXoFiROZltKhQnNuQN
x1zGQaagyS/Hp/nWpwEpUcZRi6rJ1OJXTqWtv7jhdkfcW6xzMHF4SDSb5xg99VRK
SnaD45b8Z1VcSUAS9oFxCmc3Dl+y+XMpO1qc3aJIcQAk6nU7VLjBmHERqtABFMxT
ORLCfqjFt1MTyR4o+Ow4kDH1FjRp6PGrVJ48ROyzoGzOuaCoEVyaJwVFwDsgH/bq
YqA9/aG96p4FtWeIcbYmeNBSdvnm6Bg5wt85XDt0erVxXFpe0wVanLo08BdjMDKY
kzCT9JnH1MMQnc4A2iAKN4rDa3Orx3WG3gDETn+YBH0bLmCE/9h4ZYh+dwhGzVft
gnRMgPFEvi0=
=vulz
-----END PGP SIGNATURE-----

--=-DxDBrPlK1Usuw8UEy1+H--
