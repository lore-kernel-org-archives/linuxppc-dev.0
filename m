Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7548C67BCD
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 00:13:24 +1100 (EST)
Subject: Re: [PATCH 3/3] powerpc: fix comment in kernel/irq.c
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <20061213123945.859071000@sipsolutions.net>>
References: <20061213123819.403286000@sipsolutions.net> >
	<20061213123945.859071000@sipsolutions.net>>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Gws3XRP00KS/eloGuLdx"
Date: Wed, 13 Dec 2006 14:13:12 +0100
Message-Id: <1166015592.7273.8.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-Gws3XRP00KS/eloGuLdx
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-13 at 13:38 +0100, Johannes Berg wrote:

> kernel/irq.c contains a comment that speaks of -1 and -2 as interrupt
> numbers, but this is actually dependent on configuration options now.
> Replace by NO_IRQ and NO_IRQ_ENABLED.

Humm, this got into this patchset by accident. That doesn't really make
it wrong though :)

johannes

--=-Gws3XRP00KS/eloGuLdx
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iD8DBQBFf/xo/ETPhpq3jKURAhnHAJ9yliNTQmaaq2lT2fdPxKHFqRVynACgnLA8
cD1VLprK7SAcdW9pneDx65c=
=enq4
-----END PGP SIGNATURE-----

--=-Gws3XRP00KS/eloGuLdx--
