Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9B9B567B30
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jun 2006 18:43:32 +1000 (EST)
Subject: Re: pmf_register_irq_client gives sleep with locks held warning
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1149977097.12687.144.camel@localhost.localdomain>
References: <1149020341.5128.7.camel@johannes>
	<1149123574.15446.15.camel@localhost.localdomain>
	<1149793098.11525.34.camel@johannes>
	<1149897784.12687.87.camel@localhost.localdomain>
	<1149931638.3864.34.camel@johannes.berg>
	<1149977097.12687.144.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-ZsK4iVWIjSUrCZYDea5w"
Date: Tue, 13 Jun 2006 10:43:19 +0200
Message-Id: <1150188199.9208.7.camel@johannes>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-ZsK4iVWIjSUrCZYDea5w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-06-11 at 08:04 +1000, Benjamin Herrenschmidt wrote:

> > That's ok, we don't have any in-kernel users anyway. Alas the alsa
> > people will be dissatisfied because they like to ship new drivers for
> > old kernels or something. Oh well, I don't care.
>=20
> We still want people to build out-of-tree for 2.6.17 (please keep the
> git there for that), as it will take a while before 2.6.18 is here.

Sure, I'll continue maintaining snd-aoa in that repository.

> The remaining possible bug in the pmf irq code is probably harmless in
> 99.99% of the cases in practice :)

I see your patch is in, I'll make a patch that fixes it then instead of
replacing it, I guess.

johannes

--=-ZsK4iVWIjSUrCZYDea5w
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIVAwUARI56paVg1VMiehFYAQKvsw/8DDL8bQhxBjJfwlk/ZoKD+o6bT8JVojhh
kH+lrMBDGahYyrWfprzvITIEz3DWxoprAkWXAiYNoE1u8zhsZvHYwtYwlHlbqhRc
7Bo1SlVdHNWObXOmLI5mNYQUIEv+dOpsJ0OMwJCTASUCd+EkZOONLZEHDL8ZnKY0
ufb3SKw7KqW69ENy6FrTix2usIUen1sQmEu2EFPreEFHlBjSi3ETv+siQflIHUtl
e3RkIQ4ud6pe+y9VCJWHMF22rMfkBe67L2sZm/C9MuWkIuIT6T/oaEAUsv7xn8AA
QgWw/NYSypmkZpZG8FkuRvUzUn77/QBLM/GlSZUqTa1UMPXGWP/AOLQtsWrN4OjK
6jQdFb3YTEQjD7J/FuI3uyuxYbB9A65ZmqxfyXglc3AMfv1fZAT5ZkhAazzH4gU0
aG/elq8AHnBWcCYn67JnNmmbHU3pRhriKGEkDEzOUpmdS3MXrbtwJxoou66B90cn
Lvc8albutw7yL5b6Mvnc4bJGFGeQEqv7208sFiMQz9J/wCAZZ8i45PKeanCgRDMZ
ImCJHuKetuZ6PhHEXsUaTdcRBeu1CZ/a360PQzLZp4nySA8cGCLPmGvt02qiLUgF
0kJ0GvzPsx/iaDf4wzL8csPoe254yl72Lqr7aVC+N+D/gOuDvE763WO6BE02dcLs
4kuIrA0tTNk=
=7xWy
-----END PGP SIGNATURE-----

--=-ZsK4iVWIjSUrCZYDea5w--
