Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 23247DDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 21:25:15 +1100 (EST)
Subject: Re: MPC8540 : What's "SPE used in kernel" ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Philippe De Muyter <phdm@macqel.be>
In-Reply-To: <20080223101707.GA7194@10.1.86.20>
References: <20080221123534.GA17716@ingate.macqel>
	<20080222095022.GA635@ingate.macqel>
	<08A7CD2B-27EA-4C97-9220-314E36BBBAA6@freescale.com>
	<20080223092458.GA6873@10.1.86.20>
	<1203760269.13162.11.camel@johannes.berg>
	<20080223101707.GA7194@10.1.86.20>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-hl98tEDgMv5/DefzWbWx"
Date: Sat, 23 Feb 2008 11:25:05 +0100
Message-Id: <1203762305.13162.17.camel@johannes.berg>
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


--=-hl98tEDgMv5/DefzWbWx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


> But as I said in the same mail, processes still dies unexpectedly.

Yeah, no idea though. I guess you could try putting that into the
arch/ppc Makefile, but arch/ppc will be removed this year so you don't
want to rely on it.

johannes

--=-hl98tEDgMv5/DefzWbWx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIVAwUAR7/0f6Vg1VMiehFYAQKcwBAAoxQkTbC2PWtedKVyn4xAFMmxdkLi+oM0
mNr4pPoKTphehxn4dgHEcXN8IbttpyOQwu7/tmAdsySl41aXRMMCAjpMAR+moB3q
fOMAc5XUvUjiKnQTWIxHb1JYmxxn2JaH1m4j8mF0EUjfWq5ViHbzRSCCtz8KvauS
5wyfX7Ppx0TNt7BbtuF/PpA9juShVGmzR0xrk8mu08tND11NYIRvJIRkZncKyEYA
NSSSxiKO5e5lFpKyK2O5/mdy6a1Qg2V6t0RQb/QQgeZGi1v07xqn2fUHvS3chPvc
p7zBVORNPt9o8x7rKXJyec38JE/s01uMgFHbk1UU+zv8JMRW6guWMKNTqsKcxi7l
az5rHbFRCOoCEdww2OFAju5cvRX+OWfAKH+iJ/GtiN7mwMI09dQZe7vETprjalK4
Fl+yKVuWBDhlwJY649l8K8A1uzy4eqFrG0YtyanGdgSCfZ8vQ8WvSY3HpFrgcYC5
LujR0cNawH0Xqnd1KvmoH1DKIGmI4xVQDDAZmmA69R/ghN4035ZjkfAyzwdjhoOi
PyMdVRqEVfxIWfArFHJ+jZK/E8+pP/H1BVonxjcvfi0WK9M1kUoFizZamNvVQKXT
02u3ihOLoLne1hgoQfrbV9eeDQpR/lN7RNgob7+9sTeuV1wmlo+hrENfRzHzUJAH
e/ow1ZqR+WE=
=eleS
-----END PGP SIGNATURE-----

--=-hl98tEDgMv5/DefzWbWx--
