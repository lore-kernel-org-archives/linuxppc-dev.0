Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7809CDDEBE
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Nov 2007 04:45:24 +1100 (EST)
Subject: Re: time accounting problem (powerpc only?)
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
In-Reply-To: <slrnfkijob.j2k.joerg@alea.gnuu.de>
References: <1195814816.4149.94.camel@johannes.berg>
	<slrnfkdnma.681.joerg@alea.gnuu.de>
	<1195850245.4149.170.camel@johannes.berg>
	<slrnfkijob.j2k.joerg@alea.gnuu.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-l0+Aq3oLLZ77NwwkoLM3"
Date: Sun, 25 Nov 2007 18:45:03 +0100
Message-Id: <1196012703.4149.238.camel@johannes.berg>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-l0+Aq3oLLZ77NwwkoLM3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

[can you CC me? I can sometimes only skim the lists]

> No, I saw the high hardware interrupt value in top and looked at
> /proc/interrupts and concluded that those are the evil source of the
> high load.
>=20
> > I'm fairly sure that I always had rather high numbers of interrupt
> > here. And the system isn't sluggish or unresponsive as you'd expect if
> > the IRQs actually did take 90% of the CPU time!
>=20
> Okay, so what might be the source?

I'd guess NOHZ is the problem because we're letting the CPU not do
anything rather than doing idle ticks or something.

johannes

--=-l0+Aq3oLLZ77NwwkoLM3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR0m0n6Vg1VMiehFYAQJmEBAAvUAMvyo31BfVTQ0lo7JSNceQ9Qg2BDLM
NCelxIfnF0lMgc16q+1alLtmlkDX8aYWnqGuvozUVGqtqSAolsmRDlmjrAL7n/UM
LLw0V0otDYytaxdrnL/3khKQw0bILPW7qfbtVujSomr0mAVfljPV5wRRxopvXDYh
nRIDoAYJMy1X4YL1/Y7H4CJO9FJZk2PfZ4xGG9T6yIRIFr9zM1MRtQowM4dB7bUq
O10MTe8iq0mF0lhNWToSiNAXDQpSoZk8m0AQqODi0hEGJo+ip2vqDaNGVsgKcgbN
sA4r0KJsRj2ZxzChPuf66FRGnHxbneLtjAZ4Zihlo1MfA2KM/0vdEQYHotJJS2wh
wk9KJZp5shsTKoRb2EQjGpn/qyD+UvN7qiQF1ks/Pe6aUsolkAZuUKjttAfSa1W1
XaAPlkUU0G0Z3fvBe0AnuWlgyJN6h6ITqSi8cTK5agfS6YQZkFkF9FwLsNTMPARo
jVIUnL4HoMj1ESqqSaMB8oHmgqw9+YHTvj+6sFwol9kq4ZsSc3Mo7KFpgQwQsOmI
8ZF+8Suc4JPv0wIlZtm/VWMga0rvBXvHsHO7g+pSkM0Gz/v9sfomUeFGh8cu44ZX
M86GZtx1OtXqh0vCiS9whbrYjufSzfTluo5/R51o2I5LaV16NNl2qZWUGTy+DQbA
DM4e9RG+H38=
=0f6p
-----END PGP SIGNATURE-----

--=-l0+Aq3oLLZ77NwwkoLM3--
